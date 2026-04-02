clc;
clear;
close all;

% Sampling parameters
fs = 500;              % Sampling frequency (Hz)
t = 0:1/fs:2;          % Time vector (2 seconds)

% Heartbeat rate
hr = 72;               % beats per minute
f = hr/60;             % frequency in Hz

% ECG waveform components (Gaussian functions)
ecg = zeros(size(t));

for i = 1:length(t)
    % Time within one heartbeat cycle
    tau = mod(t(i), 1/f);

    % P wave
    p = 0.1 * exp(-((tau - 0.2)^2)/(2*0.01^2));
    
    % Q wave
    q = -0.15 * exp(-((tau - 0.35)^2)/(2*0.005^2));
    
    % R wave
    r = 1.0 * exp(-((tau - 0.4)^2)/(2*0.01^2));
    
    % S wave
    s = -0.25 * exp(-((tau - 0.45)^2)/(2*0.005^2));
    
    % T wave
    t_wave = 0.3 * exp(-((tau - 0.6)^2)/(2*0.02^2));
    
    % Total ECG signal
    ecg(i) = p + q + r + s + t_wave;
end

% Add noise (optional)
noise = 0.02 * randn(size(ecg));
ecg_noisy = ecg + noise;

% Plot ECG signal
figure;
plot(t, ecg_noisy, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Simulated ECG Signal');
grid on;
