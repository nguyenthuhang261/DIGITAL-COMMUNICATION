% Cho tín hiệu bản tin như sau:$$x(t) = \sin(8\pi t). Sử dụng Matlab để:
% a. Mô phỏng quá trình điều tần tín hiệu bản tin trên với sóng mang có các tham số như sau: 
% tần số 1200 Hz, biên độ 1, pha ban đầu $\pi/2$, độ lệch tần số cực đại $\Delta f = 20\text{ Hz}$ (hoặc đề có thể cho chỉ số điều tần $\beta = 5$). 
% Chú ý: Không sử dụng hàm điều chế sẵn có trong Matlab.
% b. Vẽ tín hiệu bản tin, tín hiệu sóng mang và tín hiệu sau điều tần trong khoảng 10 chu kì tín hiệu bản tin.

clear;
clc;
close all;
f = 1200;
Ac = 1;
phi0 = pi/2;
delta_f = 20;

fm = 4;
Tm = 1/fm;
sps = 100;
fs = sps*f;
Ts = 1/fs;
nums_disp = 10;
t = 0:Ts:nums_disp*Tm-Ts;
x = sin(8*pi*t);

integral_x = cumsum(x)*Ts;
c = Ac * cos(2*pi*f*t+phi0);
k = delta_f/max(abs(x));
y_fm = Ac*cos(2*pi*f*t + phi0 + 2*pi*k*integral_x);
figure;
subplot(3, 1, 1);
plot(t, x, 'b', 'LineWidth', 2);
title('Tín hiệu bản tin x(t)');
xlabel('Thời gian t(s)');
ylabel('Biên độ');
grid on;


subplot(3, 1, 2);
plot(t, c, 'k');
title('Tín hiệu sóng mang c(t)');
xlabel('Thời gian t(s)');
ylabel('Biên độ');
grid on;
xlim(0.1+[0 0.005]);


subplot(3, 1, 3);
plot(t, y_fm, 'r');
title('Tín hiệu sau điều tần FM');
xlabel('Thời gian t(s)');
ylabel('Biên độ');
grid on;
xlim(0.1 + [0 0.005]);

