% AMI
clear;
clc;
element = 50;
bit = randi([0 1], 1, element);

R = 500*1e6;
T = 1/R;
Ns = 100;
fs = Ns * R;
Ts = 1/fs;
nums_disp = 10;
text = num2str(bit(1:nums_disp));
t = 0:Ts:element*T-Ts;

idx = find(bit == 1);
sgn = ones(1, length(idx));
sgn(2:2:end) = -1;
ami_polar = zeros(1, length(bit));
ami_polar(idx) = sgn;

bit1 = repelem(ami_polar, Ns);
t_per = mod(t, T);
percent = 0.5;
x = double((t_per > 0) & (t_per <= T*percent));
y = bit1 .* x;

figure;
plot(t, y, 'LineWidth', 1.8);
title(['Mã đường AMI có chuỗi bit là ', text]);
xlabel('Trục hoành');
ylabel('Biên độ điện áp');
grid on;
axis([0 nums_disp*T -2 2]);
