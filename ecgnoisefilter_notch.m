clc; clear; close all;

% Generate ECG
fs = 360;
t = 0:1/fs:10;
ecg_signal = ecg(length(t));

% Add 50 Hz noise
noisy_ecg = ecg_signal + 0.5*sin(2*pi*50*t);

% Notch Filter Design
wo = 50/(fs/2);    % Normalized frequency
bw = wo/35;

[b,a] = iirnotch(wo, bw);

% Apply filter
filtered_ecg = filtfilt(b, a, noisy_ecg);

% Plot
figure;
subplot(3,1,1); plot(t, ecg_signal); title('Original ECG');
subplot(3,1,2); plot(t, noisy_ecg); title('Noisy ECG (50 Hz)');
subplot(3,1,3); plot(t, filtered_ecg); title('Notch Filtered ECG');
