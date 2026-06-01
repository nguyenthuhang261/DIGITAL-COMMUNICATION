clear;
clc;
close all;

% Dieu che pha

fm = 4;
Tm = 1/fm;
fc = 5000;
sps = 100;
fs = sps * fc;
Ts = 1/fs;
nums_disp = 4;
t = 0:Ts:nums_disp*Tm-Ts;
x = sin(10*pi*t) - sin(5*pi+t+pi);
Ac = 1;
k = 5;

y_fm = Ac*cos(2*pi*fc*t + k * x);

% b qua kenh AWGN
SNRdB = 10;
SNR_linear = 10^(SNRdB/10);
noise_pow = mean(abs(y_fm).^2);
noise_p = SNR_linear/noise_pow;
noise = sqrt(noise_p/2) .* (randn(1, length(x)) + 1i.*randn(1, length(x)));

rt = y_fm + noise;

% c
% wrong when use arccos, but can't use acos like below
% xt = (acos(rt/Ac)-2*pi*fc*t)/k;

% Demodulation
y_analytic = hilbert(rt);
inst_phase  = unwrap(angle(y_analytic));
xt          = (inst_phase - 2*pi*fc*t) / k;

figure;
subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.8);
title('Tin hieu ban tin');
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu');
grid on;

subplot(3, 1, 2);
plot(t, y_fm, 'r-', 'LineWidth', 1.8);
title('Tin hieu sau dieu che');
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu');
grid on;

subplot(3, 1, 3);
plot(t, xt, 'g-', 'LineWidth', 1.8);
title('Tin hieu sau giai dieu che');
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu');
grid on;

figure;
plot(t, rt, 'c-', 'LineWidth', 1.8);
title('Tin hieu sau khi qua kenh AWGN');
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu');
grid on;

