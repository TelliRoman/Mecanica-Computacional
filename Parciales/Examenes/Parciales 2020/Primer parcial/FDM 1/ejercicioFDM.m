k = 1;
% centro = 0.1;
% delta = 0.03333;
% delta2 = delta/2;
% ptos = [centro-delta*2 centro-delta centro centro+delta];
puntos = [1 2];

% ptos2 = [centro-delta2*2 centro-delta2 centro centro+delta2];


[coef] = taylorDF(puntos,k);

% %Calculo analitco
% syms x
% fun = exp(-0.1*x^2);
% d_fun = diff(fun);
% analitica = double(subs(d_fun,0.1)); %-0.0200
% 
% %Calculo numérico
% f = @(x) exp(-0.1*x.^2);
% phis = f(ptos);
% aprox1 = phis*double(subs(coef,delta));
% 
% error1 = (analitica-aprox1);
% 
% phis2 = f(ptos2);
% aprox2 = phis2*double(subs(coef,delta2));
% 
% error2 = (analitica-aprox2);
% 
% tasaError = error1/error2
