function [code, xq] = pcm(x, M)
    Nb = log2(M);
    L = max(x) - min(x);
    delta = L/(M-1);
    Mq = min(x):delta:max(x);
    Ml = 0:M-1;
    xq = zeros(size(x));
    xcode = xq;
    for k = 1:M
        ind = find((x > Mq(k) - delta/2) & (x <= Mq(k)+delta/2));
        xq(ind) = Mq(k);
        xcode(ind) = Ml(k);
    end
    code = de2bi(xcode, Nb, 'left-msb');
end