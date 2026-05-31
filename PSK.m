clear;
clc;
close all;
M = 4;
k = log2(M);
N_bits = 10000;
% x = [1; 0; 0; 1; 1; 1; 0; 0];
x = randi([0 1], N_bits, 1);

tx_sym = bit2int(x, k);
tx_signal = pskmod(tx_sym, M, 0, 'gray');
% disp('Bản tin tại phía phát:');
% disp(tx_signal');

% AWGN
SNRdB = 10;
SNR_linear = 10^(SNRdB/10);
signal_power = mean(abs(tx_signal).^2);
noise_power = signal_power/SNR_linear;
noise = sqrt(noise_power/2) * (randn(size(tx_signal)) + 1i * randn(size(tx_signal)));

rx_signal = tx_signal + noise;

figure;
plot(real(tx_signal), imag(tx_signal), 'ro', 'LineWidth',1.2);
title(['Transmit symbols ', num2str(M), '-PSK']);
axis([-2 2 -2 2]);
grid on;

figure;
plot(real(rx_signal), imag(rx_signal), 'bo', 'LineWidth',1.2);
title(['Receive symbols ',   num2str(M), '-PSK ', 'with SNRdB = ', num2str(SNRdB), ' (dB)']);
axis([-2 2 -2 2]);
grid on;

% DEMODULATION

rx_sym = pskdemod(rx_signal, M, 0, 'gray');
rx_bits = int2bit(rx_sym, k);

% COUNT ERROR BITS
num_errors = sum(x~=rx_bits);
BER = num_errors/N_bits;

% PRINT RES
fprintf("Total number of bits: %d\n", N_bits);
fprintf("Error bits: %d\n", num_errors);
fprintf("BER: %.6f\n", BER);
