k = 2;
centro = 0.1;
delta = 0.03333;
delta2 = delta/2;
ptos = [centro-delta*2 centro-delta centro centro+delta];
puntos = [0 1 2 3];

ptos2 = [centro-delta2*2 centro-delta2 centro centro+delta2];


[coef] = taylorDF(puntos,k);

%Calculo analitco
syms x
fun = exp(-0.1*x^2);
d_fun = diff(fun);
analitica = double(subs(d_fun,0.1)); %-0.0200
