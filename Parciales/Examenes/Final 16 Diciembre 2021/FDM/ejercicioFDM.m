clear; clc;
k = 2;
centro = 0.1;
delta = 2;
delta2 = delta/2;
ptos = [centro centro+delta centro+(2*delta) centro+(3*delta)];
puntos = [0 1 2 3];

ptos2 = [centro centro+delta2 centro+(2*delta2) centro+(3*delta2)];


[coef] = taylorDF(puntos,k);

%Calculo analitco
syms x
fun = exp(-0.25*x^3);
d_fun = diff(fun);
dd_fun = diff(diff(fun));
analitica = double(subs(dd_fun,0.1)); %-0.1499

%Calculo numérico
f = @(x) exp(-0.25*x.^3);
phis = f(ptos);
aprox1 = phis*double(subs(coef,delta));

error1 = (analitica-aprox1);

phis2 = f(ptos2);
aprox2 = phis2*double(subs(coef,delta2));

error2 = (analitica-aprox2);

tasaError = error1/error2
