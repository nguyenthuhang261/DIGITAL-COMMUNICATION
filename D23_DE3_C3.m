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
noise = sqrt(noise_p/2) .* ()

