n = 100;
f = linspace(1,200,100);
% r0 = linspace(100, 600, 5);
r = linspace(25,1000,n);
r0 = 200;
Q0 = 20;
f0 = 1;
Vc0 = 1295;
% B = (0.177).*r0.*pi.*f.^1.3736;
B = (1.061e-4).*r0.*pi.*f.^1.3736;
% B = (3.86e-5).*r0.*pi.*f.^1.3736;
% B = (3.86e-5).*r0.*pi;
X = 2.*log(1 + (1./(B))).*exp(-2.*B)+(1-exp(-B)).*exp(-B).*sqrt(2*pi./B);
% X = 2.*log(1 + 1./(f.^-0.3736)).*exp(-2.*f.^-0.3736)+(1-exp(-f.^-0.3736)).*exp(-f.^-0.3736).*sqrt(1./f.^-0.3736);
Q = (f.^4.868).*X;
P = (f.^4.9).*exp((-2*pi*r0*f.^1.4)/(Q0*Vc0*f0^0.4));
TheoMax = (f.^6.3).*exp((-2*pi*r0*f.^1.4)/(Q0*Vc0*f0^0.4));
Max = 1:n; %Preallocate max array
Freq = 1:n; %Preallocate frequency index array
for i = 1:n
    B = (1.061e-4).*r(i).*pi.*f.^1.3736;
    X = 2.*log(1 + (1./(B))).*exp(-2.*B)+(1-exp(-B)).*exp(-B).*sqrt(2*pi./B);
    Q = (f.^4.868).*X;
    [Max(i),FreqIndex] = max(Q);
    Freq(i)= f(FreqIndex);
end
p = polyfit(Freq, r, 2);
x = linspace(1,80,100);
y = polyval(p, x);

func = @(B,x)  B(1).*exp(B(2).*x) + B(3);     % B(1) = a,  B(2) = b,  B(3) = c
beta = nlinfit(Freq, r, func, [0, 0, 0]);
% y = beta(1)*log(x) + beta(2);
y = beta(1).*exp(beta(2).*x) + beta(3);