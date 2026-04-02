clc;
clear;
close all;

% Sampling parameters
fs = 500;                     % Sampling frequency
t_total = 10;                 % total simulation time (seconds)
t = 0:1/fs:t_total;

% Heart rate
hr = 72;
f = hr/60;

% Initialize ECG signal
ecg = zeros(size(t));

% Generate ECG signal
for i = 1:length(t)
    tau = mod(t(i), 1/f);

    p = 0.1 * exp(-((tau - 0.2)^2)/(2*0.01^2));
    q = -0.15 * exp(-((tau - 0.35)^2)/(2*0.005^2));
    r = 1.0 * exp(-((tau - 0.4)^2)/(2*0.01^2));
    s = -0.25 * exp(-((tau - 0.45)^2)/(2*0.005^2));
    t_wave = 0.3 * exp(-((tau - 0.6)^2)/(2*0.02^2));

    ecg(i) = p + q + r + s + t_wave;
end

% Add noise
ecg = ecg + 0.02 * randn(size(ecg));

% Real-time plotting setup
figure;
h = animatedline('Color','b','LineWidth',1.5);
ax = gca;
ax.YLim = [-1.5 1.5];
ax.XLim = [0 5];              % display window of 5 seconds
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Real-Time ECG Simulation');

% Animate ECG signal
for k = 1:length(t)
    addpoints(h, t(k), ecg(k));
    
    % Scroll effect (moving window)
    if t(k) > 5
        ax.XLim = [t(k)-5 t(k)];
    end
    
    drawnow limitrate
end
