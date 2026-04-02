clc; clear; close all;

% Load ECG signal
load('../data/ecg_sample.mat'); % variable: ecg
fs = 360;

t = (0:length(ecg)-1)/fs;

% Add noise
noisy_ecg = add_noise(ecg, fs);

% Filter ECG
filtered_ecg = filter_ecg(noisy_ecg, fs);

% Compute SNR improvement
snr_before = snr(ecg, noisy_ecg - ecg);
snr_after = snr(ecg, filtered_ecg - ecg);

fprintf('SNR Before: %.2f dB\n', snr_before);
fprintf('SNR After: %.2f dB\n', snr_after);

% Plot results
figure;
subplot(3,1,1);
plot(t, ecg);
title('Original ECG');

subplot(3,1,2);
plot(t, noisy_ecg);
title('Noisy ECG');

subplot(3,1,3);
plot(t, filtered_ecg);
title('Filtered ECG');

saveas(gcf, '../results/output_plot.png');

