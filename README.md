

# **DCT-Based Image Watermarking System**  
*A MATLAB GUI for embedding and extracting invisible watermarks using Discrete Cosine Transform (DCT) along with live-script in Matlab*  

![GUI Screenshot](https://via.placeholder.com/600x400?text=DCT+Watermarking+GUI) 

## **Features**  
✅ **Invisible Watermarking**: Embeds binary watermarks into DCT coefficients.  
✅ **Noise Resistance**: Tests robustness against Gaussian, Salt & Pepper, and other noises.  
✅ **Accuracy Metrics**: Calculates bit accuracy and correlation for validation.  
✅ **User-Friendly GUI**: Built with MATLAB App Designer for intuitive operation.  

---

## **How It Works**  
1. **Embedding**:  
   - Watermark is hidden in mid-frequency DCT coefficients (e.g., `(5,5)`).  
   - Adjustable embedding strength (default: ±10).  

2. **Extraction**:  
   - Dynamic thresholding to recover watermark bits.  
   - Supports noisy/corrupted images.  

3. **Validation**:  
   - Compares extracted watermark with original using **bit accuracy** and **correlation**.  

---

## **Files in Repository**  
| File | Description |  
|------|-------------|  
| `app5.mlapp` | MATLAB App Designer GUI (Main Project File) |  
| `DCT_Watermarking_Live_Script.mlx` | Live Script with step-by-step explanation |  
| `README.md` | This documentation |  
| `sample_images/` | Test images (cover + watermark) |  

---

## **Usage**  
### **1. GUI Workflow**  
1. **Load Images**:  
   - *Cover Image*: Host image (e.g., `watermark.png`).  
   - *Watermark*: Binary image (e.g., `log.png`).  

2. **Embed Watermark**:  
   - Click *"Embed Watermark"* to hide the watermark in the cover image.  

3. **Add Noise (Optional)**:  
   - Test robustness by applying noise (*Gaussian*, *Salt & Pepper*, etc.).  

4. **Extract & Validate**:  
   - Extract the watermark and check accuracy.  

### **2. Live Script**  
Run `DCT_Watermarking_Live_Script.mlx` in MATLAB for a code walkthrough.  

---

## **Technical Details**  
- **Algorithm**: DCT-based (8×8 blocks) + Dynamic thresholding.  
- **MATLAB Version**: R2021a or later.  
- **Dependencies**: Image Processing Toolbox.  

---

## **Results**  
| Metric | No Noise | Gaussian Noise | Salt & Pepper |Speckle|Poisson|
|--------|----------|----------------|---------------|-------|-------|
| **Bit Accuracy** | ~68-100% | ~65-78% | ~65-80% |~65-100% |~60-97% |


*(Example values; actual results depend on settings.)*  

---

## **How to Improve?**  
🔹 **Stronger Embedding**: Increase coefficient modification strength (e.g., ±25).  
🔹 **Mid-Frequency Bands**: Use `(4,4)` or `(3,5)` instead of `(5,5)` for better robustness.  
🔹 **Multiple Coefficients**: Embed bits across multiple DCT coefficients.  

---

## **Credits**  
- Developed by **Sreeneesh** (GitHub: [SREENESH KS](https://github.com/SREENESHKS))  
- Inspired by academic papers on DCT watermarking.  

**License**: MIT  

--- 

### **Screenshot of GUI**  
*(Add a screenshot here using `![GUI](path/to/image.png)`)*  

---

Let me know if you'd like to add more details (e.g., installation steps, video demo link, or publication reference). Happy to refine further! 🎉
