%% 
% *LOAD IMAGE & CONVERT TO GRAYSCALE IF RGB & TO 256 PIXELS AS GRAY=[0,255]*

clc;
clear;
close all;
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp','Image Files (*.jpg, *.png, *.bmp)'}, 'Select the Host Image');
if isequal(filename,0)
   disp('User canceled image selection.');
   return;
end
fullimagePath = fullfile(pathname, filename);
rgbimage = imread(fullimagePath);
if size(rgbimage,3) == 3
    grayimage = rgb2gray(rgbimage);
else
    grayimage = rgbimage;
end
grayimage = imresize(grayimage, [256 256]);
figure, imshow(grayimage), title('Selected Grayscale Image');
[rows, cols] = size(grayimage);
%% 
% WATERMARK IMPORT- CONVERSION TO 32*32 PIXEL

[wmfile, wmpath] = uigetfile({'*.jpg;*.png;*.bmp','Watermark Image Files (*.jpg, *.png, *.bmp)'}, 'Select the Watermark Image');
if isequal(wmfile, 0)
    disp('User canceled watermark selection.');
    return;
end
fullwmpath = fullfile(wmpath, wmfile);
wmimage = imread(fullwmpath);
if size(wmimage, 3) == 3
    wmimage = rgb2gray(wmimage);
end
wmimage = imbinarize(wmimage);
wmimage = imresize(wmimage, [32 32]);
figure, imshow(wmimage), title('Selected Binary Watermark');
wmbits = wmimage(:);  
%% 
% DCT EMDEDDING

watermarkedimage = zeros(size(grayimage));
bitindex = 1;
for row = 1:8:256
    for col = 1:8:256
        block = grayimage(row:row+7, col:col+7);
        dctblock = dct2(block)
        if wmbits(bitindex) == 1
            dctblock(5,5) = dctblock(5,5) + 10;  % EmbeDDING 1
        else
            dctblock(5,5) = dctblock(5,5) - 10;  % EmbEDDING 0
        end
        watermarkedblock = idct2(dctblock);
        
        watermarkedimage(row:row+7, col:col+7) = watermarkedblock;
        bitindex = bitindex + 1;
        if bitindex > length(wmbits)
            break;
        end
    end
end
figure, imshow(uint8(watermarkedimage)), title('Watermarked Image');
%% 
% watermark extraction

if size(watermarkedimage, 3) == 3
    graywatermarked = rgb2gray(uint8(watermarkedimage));
else
    graywatermarked = uint8(watermarkedimage);
end
graywatermarked = imresize(graywatermarked, [256 256]);

bitindex = 1;
extractedbits = zeros(1024, 1);  

for row = 1:8:256
    for col = 1:8:256
        block = graywatermarked(row:row+7, col:col+7);
        dctblock = dct2(double(block));
        if dctblock(5,5) > 0
            extractedbits(bitindex) = 1;
        else
            extractedbits(bitindex) = 0;
        end

        bitindex = bitindex + 1;
        if bitindex > 1024
            break;
        end
    end
end
extractedwatermark = reshape(extractedbits, [32 32]);
figure, imshow(extractedwatermark), title('Extracted Watermark');
%% 
% ACCURACY

bitErrors = sum(xor(wmbits, extractedbits));
accuracy = (1 - bitErrors/length(wmbits)) * 100;
fprintf('Watermark Extraction Accuracy: %.2f%%\n', accuracy);

%% 
% ADDING GAUSSIAN NOISE

noisyImage = imnoise(uint8(watermarkedimage), 'gaussian', 0, 0.005);  

figure, imshow(noisyImage), title('Watermarked Image with Gaussian Noise');
%% 
% EXTRACTING AS WE DID SAME FOR WATERMARKED IMAGE INSTEAD OF WATERMARKED USE 
% NOISY IMAGE

extractedbitsnoisy = zeros(length(wmbits), 1);
bitindex = 1;

for row = 1:8:256
    for col = 1:8:256
        block = noisyImage(row:row+7, col:col+7);
        dctblock = dct2(block);

        if dctblock(5,5) > 0
            extractedbitsnoisy(bitindex) = 1;
        else
            extractedbitsnoisy(bitindex) = 0;
        end

        bitindex = bitindex + 1;
        if bitindex > length(wmbits)
            break;
        end
    end
end

extractedWatermarkNoisy = reshape(extractedbitsnoisy, [32, 32]);

figure, imshow(extractedWatermarkNoisy), title('Extracted Watermark after Gaussian Noise');
bitErrorsNoisy = sum(xor(wmbits, extractedbitsnoisy));
accuracyNoisy = (1 - bitErrorsNoisy / length(wmbits)) * 100;

fprintf('Accuracy after Gaussian Noise: %.2f%%\n', accuracyNoisy);
%% 
% SALT AND PEPPER NOISE

spImage = imnoise(uint8(watermarkedimage), 'salt & pepper', 0.02);
figure, imshow(spImage), title('Salt & Pepper Noisy Image');

bitindex = 1;
extractedBitsSP = zeros(length(wmbits), 1);

for row = 1:8:256
    for col = 1:8:256
        block = spImage(row:row+7, col:col+7);
        dctblock = dct2(block);
        if dctblock(5,5) > 0
            extractedBitsSP(bitindex) = 1;
        else
            extractedBitsSP(bitindex) = 0;
        end
        bitindex = bitindex + 1;
        if bitindex > length(wmbits)
            break;
        end
    end
end

extractedWatermarkSP = reshape(extractedBitsSP, [32 32]);
figure, imshow(extractedWatermarkSP), title('Extracted Watermark - Salt & Pepper');
bitErrorsSP = sum(xor(wmbits, extractedBitsSP));
accuracySP = (1 - bitErrorsSP / length(wmbits)) * 100;
fprintf('Accuracy after Salt & Pepper Noise: %.2f%%\n', accuracySP);
%% 
% SPECKLE NOISE

speckleImage = imnoise(uint8(watermarkedimage), 'speckle');
figure, imshow(speckleImage), title('Speckle Noisy Image');
bitindex = 1;
extractedBitsSpeckle = zeros(length(wmbits), 1);

for row = 1:8:256
    for col = 1:8:256
        block = speckleImage(row:row+7, col:col+7);
        dctblock = dct2(block);
        if dctblock(5,5) > 0
            extractedBitsSpeckle(bitindex) = 1;
        else
            extractedBitsSpeckle(bitindex) = 0;
        end
        bitindex = bitindex + 1;
        if bitindex > length(wmbits)
            break;
        end
    end
end

extractedWatermarkSpeckle = reshape(extractedBitsSpeckle, [32 32]);
figure, imshow(extractedWatermarkSpeckle), title('Extracted Watermark - Speckle');
bitErrorsSpeckle = sum(xor(wmbits, extractedBitsSpeckle));
accuracySpeckle = (1 - bitErrorsSpeckle / length(wmbits)) * 100;
fprintf('Accuracy after Speckle Noise: %.2f%%\n', accuracySpeckle);
%% 
% POISSON NOISE

poissonImage = imnoise(uint8(watermarkedimage), 'poisson');
figure, imshow(poissonImage), title('Poisson Noisy Image');
bitindex = 1;
extractedBitsPoisson = zeros(length(wmbits), 1);

for row = 1:8:256
    for col = 1:8:256
        block = poissonImage(row:row+7, col:col+7);
        dctblock = dct2(block);
        if dctblock(5,5) > 0
            extractedBitsPoisson(bitindex) = 1;
        else
            extractedBitsPoisson(bitindex) = 0;
        end
        bitindex = bitindex + 1;
        if bitindex > length(wmbits)
            break;
        end
    end
end

extractedWatermarkPoisson = reshape(extractedBitsPoisson, [32 32]);
figure, imshow(extractedWatermarkPoisson), title('Extracted Watermark - Poisson');
bitErrorsPoisson = sum(xor(wmbits, extractedBitsPoisson));
accuracyPoisson = (1 - bitErrorsPoisson / length(wmbits)) * 100;
fprintf('Accuracy after Poisson Noise: %.2f%%\n', accuracyPoisson);
%% 
% NOISE COMPARISON

fprintf('\nSummary of Watermark Extraction Accuracy:\n');
fprintf('------------------------------------------\n');
fprintf('Original (No Noise]:       %.2f%%\n', accuracy);
fprintf('Gaussian Noise:            %.2f%%\n', accuracyNoisy);
fprintf('Salt & Pepper Noise:       %.2f%%\n', accuracySP);
fprintf('Speckle Noise:             %.2f%%\n', accuracySpeckle);
fprintf('Poisson Noise:             %.2f%%\n', accuracyPoisson);
figure;
subplot(2,3,1), imshow(wmimage), title('Original Watermark');
subplot(2,3,2), imshow(extractedwatermark), title('No Noise');
subplot(2,3,3), imshow(extractedWatermarkNoisy), title('Gaussian');
subplot(2,3,4), imshow(extractedWatermarkSP), title('Salt & Pepper');
subplot(2,3,5), imshow(extractedWatermarkSpeckle), title('Speckle');
subplot(2,3,6), imshow(extractedWatermarkPoisson), title('Poisson');
%% 
% *CONFUSION MATRIX ,PSNR AND SSIM*

figure;
confusionchart(double(wmbits), double(extractedbits));
