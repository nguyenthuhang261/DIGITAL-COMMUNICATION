% NRZ bipolar/polar

% a. Tạo chuỗi bit nhị phân ngẫu nhiên gồm 120 phần tử.
% b. Chuyển đổi chuỗi bit thành dạng sóng mã đường NRZ lưỡng cực (Polar NRZ) tại tốc độ 250 Mb/s.
% c. Vẽ biểu diễn dạng sóng tín hiệu trên 15 chu kì bit đầu tiên.
clear;
clc; close all;

element = 120;
bit = randi([0 1], 1, element);

R = 250*1e6;
T = 1/R;
Ns = 100;
fs = Ns * R;
Ts = 1/fs;
nums_disp = 12;
text = num2str(bit(1:nums_disp));
t = 0:Ts:element*T-Ts;
bits_polar = 2*bit-1;    % bipolar
% bits_polar = bit;          % polar
bit1 = repelem(bits_polar, Ns);

figure;
plot(t, bit1, 'LineWidth', 2);
title(['Tin hieu NRZ lưỡng cực có chuỗi bit là: ', text]);
xlabel('Thời gian t(s)');
ylabel('Biên độ điện áp (V)');
axis([0 nums_disp * T -2 2]);
grid on;