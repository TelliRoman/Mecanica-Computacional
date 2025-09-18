%Que pasa si me dan un punto al que tengo que calcular la temperatura en
%el?
%punto a encontrar valor
p = [0.05 0.0];
%A que elemento pertenece el punto?
nodos = buscarElementoPorPuntos(p,xnode);
%Calculamos las funciones de forma del triangulo
%Sacamos los coeficientes
coef = funFormaTriang(nodos,xnode);
temperatura = full(PHI(nodos))';

N = coef'*[p 1]';
temperaturaPunto = temperatura*N;


% N1 = coef(1,1)*p(1)+coef(2,1)*p(2)+coef(3,1);
% N2 = coef(1,2)*p(1)+coef(2,2)*p(2)+coef(3,2);
% N3 = coef(1,3)*p(1)+coef(2,3)*p(2)+coef(3,3);
% phi_punto = temperatura(1)*N1+temperatura(2)*N2+temperatura(3)*N3
