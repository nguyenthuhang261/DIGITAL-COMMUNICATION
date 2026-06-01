% PM MODULATION & DEMODULATION (CUSTOM MATH)
clear; clc; close all;
fs = 1000;
Ts = 1/fs;
t = 0:Ts:2-Ts;
fc = 60;

s = cos(8*pi*t) + cos(12*pi*t + pi/4);

% 1. Dieu che PM
kp = 1.5; % He so nhay pha (rad/V)
tx_pm = cos(2*pi*fc*t + kp*s);

% 2. Kenh truyen AWGN (Tin hieu Passband -> Nhieu thuc)
SNR_dB = 8;
SNR_linear = 10^(SNR_dB/10);
signal_power = mean(tx_pm.^2); 
noise_power = signal_power / SNR_linear;
noise = sqrt(noise_power) * randn(size(tx_pm)); 
rx_pm = tx_pm + noise;

% 3. Giai dieu che PM (IQ Demodulator)
% Nhan tin hieu voi cac nhanh vuong goc I va Q
I = rx_pm .* cos(2*pi*fc*t);
Q = rx_pm .* -sin(2*pi*fc*t);

% Loc thong thap loai bo tan so cao (2*fc)
[b, a] = butter(4, 15/(fs/2)); 
I_f = filtfilt(b, a, I);
Q_f = filtfilt(b, a, Q);

% Khoi phuc goc pha (Chinh la ban tin trong dieu che PM)
phase = unwrap(atan2(Q_f, I_f));

% Loai bo thanh phan DC (Hieu chinh do sai lech pha ban dau neu co)
phase = phase - mean(phase);

% Khoi phuc bien do ban tin
s_demod = phase / kp;

% 4. Do thi thoi gian
subplot(2, 1, 1);
plot(t, rx_pm, 'k');
title(['Tin hieu thu PM qua kenh AWGN (SNR = ', num2str(SNR_dB), ' dB)']);
xlim([0 0.5]); 
grid on;

subplot(2, 1, 2);
plot(t, s, 'b', 'LineWidth', 1.8); hold on;
plot(t, s_demod, 'r');
title('So sanh Ban tin goc va Giai dieu che PM');
legend('Goc', 'Khoi phuc');
xlim([0 0.5]); 
grid on;
