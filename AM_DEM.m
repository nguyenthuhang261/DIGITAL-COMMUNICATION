% AM MODULATION & DEMODULATION (CUSTOM MATH)
clear; clc; close all;
fs = 1000;
Ts = 1/fs;
t = 0:Ts:2-Ts;
fc = 60;
Ac = 2;

s = cos(8*pi*t) + cos(12*pi*t + pi/4);

% 1. Dieu che AM
tx_am = (Ac + s) .* cos(2*pi*fc*t);

% 2. Kenh truyen AWGN (Tin hieu Passband -> Nhieu thuc)
SNR_dB = 8;
SNR_linear = 10^(SNR_dB/10);
signal_power = mean(tx_am.^2); 
noise_power = signal_power / SNR_linear;
noise = sqrt(noise_power) * randn(size(tx_am)); 
rx_am = tx_am + noise;

% 3. Giai dieu che AM (Dong bo)
% Nhan tin hieu thu voi song mang
mix_am = rx_am .* cos(2*pi*fc*t); 

% Loc thong thap (Butterworth bac 4, tan so cat 15Hz)
[b, a] = butter(4, 15/(fs/2)); 
s_demod = filtfilt(b, a, mix_am) * 2 - Ac;

% 4. Do thi thoi gian
subplot(2, 1, 1);
plot(t, rx_am, 'k');
title(['Tin hieu thu AM qua kenh AWGN (SNR = ', num2str(SNR_dB), ' dB)']);
xlim([0 0.5]); 
grid on;

subplot(2, 1, 2);
plot(t, s, 'b', 'LineWidth', 1.8); hold on;
plot(t, s_demod, 'r');
title('So sanh Ban tin goc va Giai dieu che');
legend('Goc', 'Khoi phuc');
xlim([0 0.5]); 
grid on;
