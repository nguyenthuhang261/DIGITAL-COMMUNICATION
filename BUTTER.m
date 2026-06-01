% LOC BUTTERWORTH FFT
clear; clc; close all;
fs = 500;
Ts = 1/fs;
t = 0:Ts:3-Ts;
x = sin(4*pi*t) + 0.5*sin(40*pi*t);
n = 4;
B = 8;

y = butterw(x, n, B, Ts);
[f, Px] = spectrocal(t, x);
[~, Py] = spectrocal(t, y);

subplot(2, 1, 1);
semilogy(f, Px, 'b', f, Py, 'r', 'LineWidth', 1.2);
xline(B, 'k--');
title('Pho cong suat PSD');
xlim([0 fs/2]);
grid on;

subplot(2, 1, 2);
plot(t, x, 'b', t, y, 'r', 'LineWidth', 1.2);
title('Mien thoi gian');
xlim([0 1.5]);
grid on;

function y = butterw(x, n, B, Ts)
    Ns = length(x);
    f = (-Ns/2:Ns/2-1)/(Ns*Ts);
    X_shifted = fftshift(fft(x));
    H_f = 1./(1+(f./B).^(2*n));
    Y_shifted = ifftshift(X_shifted.*H_f);
    y = real(ifft(Y_shifted));
end

function [f, Pf] = spectrocal(t, x)
    Ns = length(x);
    Ts = t(2) - t(1);
    f = (-Ns/2 : Ns/2-1) / (Ns*Ts);
    Y_shifted = fftshift(fft(x, Ns)) / Ns;
    Pf = abs(Y_shifted).^2;
end
