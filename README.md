# BCI Motor Imagery Classification

This project implements a reproducible Brain–Computer Interface (BCI) pipeline to classify **left vs. right hand motor imagery** from EEG signals. Using **EEGLAB** and **BCILAB** in MATLAB, the study demonstrates how motor-related neural activity can be extracted, visualized, and classified using open-source tools.

---

## 📊 Dataset
- **Name:** EEG Motor Movement/Imagery Dataset (OpenNeuro, [DOI: 10.18112/openneuro.ds004362.v1.0.0](https://openneuro.org/datasets/ds004362/versions/1.0.0))  
- **Subject:** S008  
- **Task:** Left vs. Right hand motor imagery (Task 2)  
- **Channels:** 64 (10–10 system)  
- **Sampling Rate:** 160 Hz  

---

## ⚙️ Methods
1. **Preprocessing (EEGLAB)**
   - Band-pass filter: 1–30 Hz (mu & beta rhythms preserved).
   - Common average reference.
   - Epoching (−1 to +4 sec around motor imagery events).
   - Baseline correction (−1000 to 0 ms).

2. **Feature Extraction & Classification (BCILAB)**
   - Windowed Means paradigm.
   - Focused on 8–30 Hz (mu & beta rhythms).
   - Extracted features from 5 time windows (0–2.5 s).
   - Classifier: Linear Discriminant Analysis (LDA).
   - Evaluation: 5-fold cross-validation.

---

## 📈 Results
- **Classification Accuracy:** ~56% (error rate ~44.4%), above chance level.  
- **True Positive Rate (Left-hand imagery):** 67%  
- **True Negative Rate (Right-hand imagery):** 45%  
- **ERP Analysis:** Contralateral activation at electrodes C3 & C4.  
- **Topoplots:** Physiologically plausible activation patterns in μ and β bands.  

---

## 🧑‍💻 How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/BCI-Motor-Imagery-Classification.git
   cd BCI-Motor-Imagery-Classification
