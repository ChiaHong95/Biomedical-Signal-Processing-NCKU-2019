# Biomedical-Signal-Processing-NCKU-2019
This repo includes homework from Professor Sheng-Fu Liang's Biomedical Signal Processing course at National Cheng Kung University 2019. All works were implemented using MATLAB.


- HW1 to-dos (goal: ECG signal denoising and BPM calculation): 
    - perform **(time) synchronous averaging(同步平均)** to a noisy ECG signal and compare signal-to-noise ratio (SNR)
        > Synchronous averaging: 將多個週期疊加，最後取平均，以此去除雜訊的影響。(The default white noise is normally distributed, with a mean value of zero, and the noise after the mean value is zero, which has no effect on our signal.)
    - select a QRS complex from the signal as template and use a suitable threshold on **cross-correlation** function for beat detection
        > [Cross-correlation](https://www.investopedia.com/terms/c/crosscorrelation.asp) is generally used when measuring information between two different time series. The possible range for the correlation coefficient of the time series data is from -1.0 to +1.0. The closer the cross-correlation value is to 1, the more closely the sets are identical.
    - perform **moving average(移動平均)** by 2 points and 4 points
        > A simple moving average (SMA) is a calculation that takes the arithmetic mean of a given set of values over a specific number of point in the past.
