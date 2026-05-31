% CMI
clear;
clc;

N_bits = 50;
bit = randi([0 1], 1, N_bits);
nums_disp = 10;
text = num2str(bit(1:nums_disp));
R = 500*1e6;
T = 1/R;
Ns = 100;
fs = Ns*R;
Ts = 1/fs;
t = 0:Ts:N_bits*T-Ts;

% bit 1 thi dao bit
idx = find(bit == 1);
sgn = ones(1, length(idx));
sgn(2:2:end) = -1;
bit(idx) = sgn;
bit1 = repelem(bit, Ns);

% bit 0 thi nua dau -V, nua sau +V
idx1 = find(bit == 0);
bit2 = zeros(1, N_bits);
sgn1 = ones(1, length(idx1));
bit2(idx1) = sgn1;
bit3 = repelem(bit2, Ns);

base_pulse = [-1*ones(1, Ns/2), ones(1, Ns/2)];
x_polar = repmat(base_pulse, 1, N_bits);
y = bit3 .* x_polar;

y_cmi = bit1 + y;

figure;
plot(t, y_cmi, 'LineWidth', 1.8);
title('Mã hóa đường CMI có chuỗi bit là ', text);
ylabel('Biên độ điện áp V');
grid on;
axis([0 nums_disp*T -2 2]);
