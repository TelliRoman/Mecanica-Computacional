syms x
f = x^4-2*x^3+x;
deltaX1 = 0.1;
deltaX2 = 0.05;
xc = 0.4;

phiPrima1 = double((subs(f,xc+deltaX1/2)-subs(f,xc-deltaX1/2))/(deltaX1));
phiPrima2 = double(subs(f,xc+deltaX2/2)-subs(f,xc-deltaX2/2))/(deltaX2);


derivada = diff(f,x);
analitica = double(subs(derivada,xc));

error1 = (analitica-phiPrima1);
error2 = (analitica-phiPrima2);
tasaError = error1/error2