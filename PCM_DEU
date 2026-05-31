% PCM DEU

f = 2.5;
T = 1/f;
fs = 1000;
Ts = 1/fs;
t = 0:Ts:5*T-Ts;
x = cos(20*pi*t+pi/2) + 3*sin(10*pi*t) + 5*cos(15*pi*t+pi);

plot(t, x, 'LineWidth', 1.8);
hold on;
title('Tín hiệu tương tự');
xlabel('Thời gian t(s)');
ylabel('Biên độ tín hiệu');
grid on;

M = 8;         % so muc luong tu hoa
[code, xq] = pcm(x, M);
% Display 
stairs(t-Ts/2, xq, 'LineWidth',1.8);
