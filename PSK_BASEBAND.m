% PSK
clear; clc; close all;

n_bits = 1000;
M = 4;
bit = randi([0 M-1], 1, n_bits);
dk = pskmod(bit, M, 0, 'gray');
Es = 1;
Tsym = 1;
pulse_amp = sqrt(2*Es/Tsym);
phi0 = 0;
s_sym = dk .* exp(1i*phi0);
sps = 50;
fs = sps/Tsym;
st = repelem(s_sym, sps) * pulse_amp;

SNRdB = 10;
SNR_linear = 10^(SNRdB/10);
signal_power = mean(abs(st).^2);
noise_power = signal_power/SNR_linear;
noise = sqrt(noise_power/2) * (randn(1, length(st)) + 1i*randn(1, length(st)));

rt = st + noise;
t = (0:length(st)-1)/fs;
nums_disp = 20;
ind_dis = 1:(nums_disp*sps);

figure;
subplot(2, 1, 1);
plot(t(ind_dis), real(st(ind_dis)), 'LineWidth', 1.8);
title('Muc bien do cua tin hieu 4-PSK truoc khi qua kenh truyen');
xlabel('Thoi gian t(s)');
ylabel('Bien do');
grid on;

subplot(2, 1, 2);
plot(t(ind_dis), real(rt(ind_dis)), 'LineWidth', 1.8);
title('Muc bien do cua tin hieu 4-PSK sau khi qua kenh truyen');
xlabel('Thoi gian t(s)');
ylabel('Bien do');
grid on;

% b
opt_samp_idx = sps/2:sps:length(st);
st_sample = st(opt_samp_idx);
rt_sample = rt(opt_samp_idx);
figure;
subplot(1, 2, 1);
plot(real(st_sample), imag(st_sample), 'bo', 'MarkerSize', 8);
title('Gian do chom sao tin hieu 4-PSK truoc khi qua kenh truyen');
grid on;

subplot(1, 2, 2);
plot(real(rt_sample), imag(rt_sample), 'bo', 'MarkerSize', 8);
title('Gian do chom sao tin hieu 4-PSK sau khi qua kenh truyen');
grid on;

% c
eyediagram(real(st), 2*sps, Tsym);
set(gcf, 'Name', 'Gian do mat tin hieu 4-PSK truoc khi qua kenh truyen');

eyediagram(real(rt), 2*sps, Tsym);
set(gcf, 'Name', 'Gian do mat tin hieu 4-PSK sau khi qua kenh truyen');
