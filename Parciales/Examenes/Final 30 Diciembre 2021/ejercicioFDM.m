k = 2;
centro = 0.1;
delta = 0.03333;
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

d_f1 = double(subs(coef(1),delta))*double(subs(fun,ptos(1)))+...
      double(subs(coef(2),delta))*double(subs(fun,ptos(2)))+...
      double(subs(coef(3),delta))*double(subs(fun,ptos(3)))+...
      double(subs(coef(4),delta))*double(subs(fun,ptos(4)));
  
d_f2 = double(subs(coef(1),delta2))*double(subs(fun,ptos(1)))+...
      double(subs(coef(2),delta2))*double(subs(fun,ptos(2)))+...
      double(subs(coef(3),delta2))*double(subs(fun,ptos(3)))+...
      double(subs(coef(4),delta2))*double(subs(fun,ptos(4)))


error1 = analitica-d_f1;
error2 = analitica-d_f2;
error1/error2