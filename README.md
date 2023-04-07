# Biomedical-Signal-Processing-NCKU-2019
This repo includes homework from Professor Sheng-Fu Liang's Biomedical Signal Processing course at National Cheng Kung University 2019. All works were implemented using MATLAB.


- HW1 to-dos (goal: ECG signal denoising and BPM calculation): 
    - perform **(time) synchronous averaging(同步平均)** to a noisy ECG signal and compare signal-to-noise ratio (SNR)
        > Synchronous averaging: 將多個週期疊加，最後取平均，以此去除雜訊的影響。(The default white noise is normally distributed, with a mean value of zero, and the noise after the mean value is zero, which has no effect on our signal.)
    - select a QRS complex from the signal as template and use a suitable threshold on **cross-correlation** function for beat detection
        > [Cross-correlation](https://www.investopedia.com/terms/c/crosscorrelation.asp) is generally used when measuring information between two different time series. The possible range for the correlation coefficient of the time series data is from -1.0 to +1.0. The closer the cross-correlation value is to 1, the more closely the sets are identical.
    - perform **moving average(移動平均)** by 2 points and 4 points
        > A simple moving average (SMA) is a calculation that takes the arithmetic mean of a given set of values over a specific number of point in the past.


- HW2 to-dos (goal: EEG correlation and ECG signal denoising):
    - perform **autocorrelation** and **cross-correlation** on frontal and occipital EEG data
        > [Autocorrelation](https://www.investopedia.com/terms/a/autocorrelation.asp) represents the degree of similarity between a given time series and a lagged version of itself over successive time intervals. Autocorrelation measures the relationship between a variable's current value and its past values.
    - apply **three-point central-difference** to ECG data (reduce low frequency noise, detrending), compare noise level (RMS) before and after, and calculate BPM. 
        > The three-point central-difference: taking the average of two successive output value of firstorder difference operator. It represents a bandpass filter. In MATLAB implementation, we use convolution to achieve, `y = conv(ecg, h)`, with impulse response `h = 0.5[-1, 0, 1]`.
 
 - HW3 to-dos (goal: Wiener filtering using different desired/optimal signal):
    - design a **Wiener filter** to remove the artifacts in the ECG signal (**Wiener Hopf** equation for optimal filter coefficients)
        <img src="https://i.imgur.com/vkUD8Fq.png" height="400" />

        > If a representation of the desired signal is available, then the Wiener filters can be applied. The Wiener filter theory is to minimize the difference between the filtered output and some desired output.
    - create a **piece-wise linear model** of the desired version of the signal by concatenating linear segments to provide P, QRS, and T waves similar to the given ECG signal
    - redo the above steps by using the ECG filtered by the **Comb filter** as the template (desired signal)
        > 梳形濾波器，用於濾除一系列等間距的頻率(harmonics)
        > 1. analyze power spectra (FFT) of the ECG
        > 2. find the frequencies with peak amplitude
        > 3. in the **zplane**, put **Zeros** at those frequencies (a frequency can calculate a pair of Zeros site)
        > 4. compute z-domain transfer function/coefficient and normalize
        > 5. convolution
    - also compare the results with the results of the **lowpass filter** (16-points moving average)
    
    
- HW4 to-dos (goal: the Pan-Tompkins method):
    - implement **[the Pan-Tompkins method](https://en.wikipedia.org/wiki/Pan%E2%80%93Tompkins_algorithm)** for QRS detection
        > Pan-Tomplins algorithm is based on analysis of the slope, amplitude, and width of QRS complexes. It includes a series of bandpass (lowpass+high pass), derivative, squaring, integration, adaptive thresholding & search procedures.
    - compute average heart rate and QRS width
    - implement the **adaptive thresholding** and searchback procedure to your P-T method and redo above step (refer to lecture note HW4/BSP-6(lecture).pdf)
    - Apply the P-T method to personal ECG


- HW5 to-dos (goals:  Multi-Channel EEG analysis via PCA):
    - Use **PCA** (Principle Component Analysis) to analyze the EEG data
        > PCA transforms a set of correlated variables into a new set of uncorrelated variables that are called principal components (PCs). In addition to being uncorrelated, the PCs are orthogonal and are ordered in terms of the variability they represent.
    - analyze **covariance matrix** in each channel and 10 PCs
    - calculate how many PCs are needed to contain 85% variance
    - Observe the relationship between the **eigenvector coefficient** and the channel
