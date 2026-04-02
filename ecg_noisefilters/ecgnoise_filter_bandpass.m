clc; clear; close all;

% Generate ECG signal
fs = 360;                     % Sampling frequency
t = 0:1/fs:10;
ecg_signal = ecg(length(t));

% Add noise
noisy_ecg = ecg_signal ...
    + 0.5*sin(2*pi*50*t) ...     % Powerline noise
    + 0.3*randn(size(t)) ...     % White noise
    + 0.5*sin(2*pi*0.5*t);       % Baseline wander

% Bandpass Filter Design (0.5–40 Hz)
[b,a] = butter(4, [0.5 40]/(fs/2), 'bandpass');

% Apply filter
filtered_ecg = filtfilt(b, a, noisy_ecg);

% Plot
figure;
subplot(3,1,1); plot(t, ecg_signal); title('Original ECG');
subplot(3,1,2); plot(t, noisy_ecg); title('Noisy ECG');
subplot(3,1,3); plot(t, filtered_ecg); title('Bandpass Filtered ECG');
