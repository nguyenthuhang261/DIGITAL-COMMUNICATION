clear;
clc;
close all;

n_bits = 200;
% data = randi([0 1], 1, n_bits); % wrong
data = randi([0 1], n_bits, 1); 

M = 4;
Nbs = log2(M);
% data1 = bit2int(data, Nbs, 'left-msb'); % wrong
data1 = bit2int(data, Nbs, true);
dk = qammod(data1, M, 'gray');

figure;
plot(real(dk), imag(dk), 'bo', 'MarkerSize', 8);
title('Gian do chom sao 4-QAM');
xlabel('Truc thuc');
ylabel('Truc ao');
grid on;
