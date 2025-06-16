# DCT-Based-Digital-Watermarking-GUI-with-Attacks-Analysis
This Digital Watermark Embedding and Extraction GUI is a project implemented in MATLAB. It utilizes Discrete Cosine Transform (DCT) to embed a binary watermark into a cover image and extract it back afterwards. along with several Noiseattacks


The main highlights of this project include:

- Graphical User Interface (GUI) for embedding, attack, and extraction.
- Implementation of DCT algorithm for robust and imperceptible watermark embedding.
- Simulation of attacks (Poisson, Gaussian, Salt & Pepper, Speckle) to test robustness.
- Quantitative Accuracy scoring to measure robustness against attacks.
- Visual comparison between original, watermarked, attacked, and extracted images.

Practical Applications:

- Digital Rights Management
- Copyright Protection
- Authentication of Digital Content
- Security Applications (such as tamper detection)

---

## Tech Stack

- **MATLAB**
- **Discrete Cosine Transform (DCT) Algorithm**
- **GUI components (MATLAB GUI)**

---

## Features

- User-friendly GUI for embedding, attack, and extraction
- Variety of attack simulations to test robustness
- Quantitative Accuracy scoring
- Visual comparison of original, watermarked, and extracted images

---

## GUI Interface

![GUI Screenshot](images/gui-screenshot.jpg)

---

## Sample Comparison (Before and After Attack)

![Comparison Screenshot](images/comparison-screenshot.jpg)

---

## Installation and Usage

1. Download or clone this repository.
2. Open **MATLAB**.
3. Run the main GUI file (typically a `.fig` or `.mlapp`) to launch the application.
4. Select a cover image and a watermark.
5. Perform embedding, attack, and extraction directly from the GUI.
## Accuracy

The Accuracy of Watermark Extraction varies depending on:

- The cover image used
- The attack applied (Poisson, Gaussian, Speckle, Salt & Pepper, etc.)
- The embedding strength or coefficients

For different images and attacks, Accuracy typically falls in the range of **60%–95%**.

This variability highlights:
- The robustness of the algorithm under different conditions.
- The dependency on cover content and attack parameters.



