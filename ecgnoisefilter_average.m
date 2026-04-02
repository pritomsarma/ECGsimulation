clc; clear; close all;

% Generate ECG
fs = 360;
t = 0:1/fs:10;
ecg_signal = ecg(length(t));

% Add noise
noisy_ecg = ecg_signal + 0.4*randn(size(t));

% Moving Average Filter
window_size = 10;
filtered_ecg = filter(ones(1,window_size)/window_size, 1, noisy_ecg);

% Plot
figure;
subplot(3,1,1); plot(t, ecg_signal); title('Original ECG');
subplot(3,1,2); plot(t, noisy_ecg); title('Noisy ECG');
subplot(3,1,3); plot(t, filtered_ecg); title('Moving Average Filtered ECG');
