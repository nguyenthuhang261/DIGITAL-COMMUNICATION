clear;
clc;

data = randi([0 3], 5, 6);
mean = 0;
sigma = 3;
data1 = sigma * randn([0 3], 5, 6);
A = data + 1i.*data1;
fprintf("Ma tran A la: \n");
disp(A);

% b: Chuan hoa ma tran ve (0, 1)

norm_a = abs(max(A));
A_norm = A.*(1/norm_a);
fprintf("Ma tran A sau chuan hoa la: \n");
disp(A_norm);

