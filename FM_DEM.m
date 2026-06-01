% FM MODULATION & DEMODULATION (CUSTOM MATH)
clear; clc; close all;
fs = 1000;
Ts = 1/fs;
t = 0:Ts:2-Ts;
fc = 60;

s = cos(8*pi*t) + cos(12*pi*t + pi/4);

% 1. Dieu che FM (Tu code toan hoc)
m = 0.4;
f_max = 6;
delta_f = m * f_max;
kf = delta_f / max(abs(s)); 
int_s = cumsum(s) * Ts;
tx_fm = cos(2*pi*fc*t + 2*pi*kf*int_s);

% 2. Kenh truyen AWGN (Tin hieu Passband -> Nhieng thuc)
SNR_dB = 8;
SNR_linear = 10^(SNR_dB/10);
signal_power = mean(tx_fm.^2); 
noise_power = signal_power / SNR_linear;
noise = sqrt(noise_power) * randn(size(tx_fm)); 
rx_fm = tx_fm + noise;

% 3. Giai dieu che FM (IQ Demodulator)
% Nhan tin hieu voi cac nhanh vuong goc I va Q
I = rx_fm .* cos(2*pi*fc*t);
Q = rx_fm .* -sin(2*pi*fc*t);

% Loc thong thap de loai bo tan so cao (2*fc)
[b, a] = butter(4, 15/(fs/2)); 
I_f = filtfilt(b, a, I);
Q_f = filtfilt(b, a, Q);

% Khoi phuc goc pha va dao ham de tim tan so tuc thoi
phase = unwrap(atan2(Q_f, I_f));
inst_freq = diff(phase) / (2*pi*Ts);
inst_freq = [inst_freq(1), inst_freq]; % Bu 1 mau bi mat do phep dao ham (diff)

% Khoi phuc bien do ban tin
s_demod = inst_freq / kf;

% 4. Do thi thoi gian
subplot(2, 1, 1);
plot(t, rx_fm, 'k');
title(['Tin hieu thu FM qua kenh AWGN (SNR = ', num2str(SNR_dB), ' dB)']);
xlim([0 0.5]); 
grid on;

subplot(2, 1, 2);
plot(t, s, 'b', 'LineWidth', 1.8); hold on;
plot(t, s_demod, 'r');
title('So sanh Ban tin goc va Giai dieu che');
legend('Goc', 'Khoi phuc');
xlim([0 0.5]); 
grid on;
