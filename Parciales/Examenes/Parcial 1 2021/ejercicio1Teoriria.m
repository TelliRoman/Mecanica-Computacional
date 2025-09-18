clear; close all; clc
%Funcion analítica
phi = @(x,y) exp(5*(x^2+y^2))*(2*x^2-x*y-1/2*y^2);
% phi = @(x,y) exp(x)+exp(y);


%DELTAX=DELTAY = delta
delta = 1/4;
delta2 = 1/8;
syms x y;

%puntos malla 1
P = [0 0];
P10 = [delta 0];
P_10 = [-delta 0];
P01 = [0 delta];
P_01 = [0 -delta];
P11  = [delta delta];
P_11  = [-delta delta];
P_1_1  = [-delta -delta];
P1_1  = [delta -delta];


%puntos malla 2
P2 = [0 0];
P102 = [delta2 0];
P_102 = [-delta2 0];
P012 = [0 delta2];
P_012 = [0 -delta2];
P112  = [delta2 delta2];
P_112  = [-delta2 delta2];
P_1_12  = [-delta2 -delta2];
P1_12  = [delta2 -delta2];



figure
hold on
grid on
plot(P(1),P(2),'or')
plot(P10(1),P10(2),'or')
plot(P01(1),P01(2),'or')
plot(P_10(1),P_10(2),'or')
plot(P_01(1),P_01(2),'or')
plot(P11(1),P11(2),'+r')
plot(P_11(1),P_11(2),'+r')
plot(P_1_1(1),P_1_1(2),'+r')
plot(P1_1(1),P1_1(2),'+r')

plot(P2(1),P2(2),'xg')
plot(P102(1),P102(2),'xg')
plot(P012(1),P012(2),'xg')
plot(P_102(1),P_102(2),'xg')
plot(P_012(1),P_012(2),'xg')
plot(P112(1),P112(2),'+g')
plot(P_112(1),P_112(2),'+g')
plot(P_1_12(1),P_1_12(2),'+g')
plot(P1_12(1),P1_12(2),'+g')

%1 - Derivada de phi con respecto a x
difx = simplify(diff(phi,x));
phiPrimaXa = subs(difx,{x,y},{0,0});

phiPrimaX1 = phi(P10(1),P10(2))-phi(P_10(1),P_10(2))/2*(delta);
phiPrimaX2 = phi(P102(1),P102(2))-phi(P_102(1),P_102(2))/2*(delta2);

error1 = (phiPrimaXa-phiPrimaX1)/phiPrimaXa;
error2 = (phiPrimaXa-phiPrimaX2)/phiPrimaXa;
tasaError1 = error1/error2
%La primer derivada es cero, no tenemos manera de demostrar por la tasa de
%error que es de orden cuadrático. La solución es singular


%2 - Derivada de phi con respecto a y
dify = simplify(diff(phi,y));
phiPrimaYa = subs(dify,{x,y},{0,0});

phiPrimaY1 = phi(P01(1),P01(2))-phi(P_01(1),P_01(2))/2*(delta);
phiPrimaY2 = phi(P012(1),P012(2))-phi(P_012(1),P_012(2))/2*(delta2);

error1 = (phiPrimaYa-phiPrimaY1)/phiPrimaYa;
error2 = (phiPrimaYa-phiPrimaY2)/phiPrimaYa;
tasaError2 = error1/error2
%La primer derivada es cero, no tenemos manera de demostrar por la tasa de
%error que es de orden cuadrático. La solución es singular

%3 - Derivada de phi con respecto a x dos veces
difxx = simplify(diff(diff(phi,x),x));
phiPrimaXXa = subs(difxx,{x,y},{0,0});

phiPrimaXX1 = (phi(P_10(1),P_10(2))-2*phi(P(1),P(2))+phi(P10(1),P10(2)))/(delta^2);
phiPrimaXX2 = (phi(P_102(1),P_102(2))-2*phi(P2(1),P2(2))+phi(P102(1),P102(2)))/(delta2^2);

error1 = (phiPrimaXXa-phiPrimaXX1)/phiPrimaXXa;
error2 = (phiPrimaXXa-phiPrimaXX2)/phiPrimaXXa;
tasaError3 = simplify(error1/error2)


%4 - Derivada de phi con respecto a y dos veces
difyy = simplify(diff(diff(phi,y),y));
phiPrimaYYa = subs(difyy,{x,y},{0,0});

phiPrimaYY1 = (phi(P_01(1),P_01(2))-2*phi(P(1),P(2))+phi(P01(1),P01(2)))/(delta^2);
phiPrimaYY2 = (phi(P_012(1),P_012(2))-2*phi(P2(1),P2(2))+phi(P012(1),P012(2)))/(delta2^2);

error1 = (phiPrimaYYa-phiPrimaYY1)/phiPrimaYYa;
error2 = (phiPrimaYYa-phiPrimaYY2)/phiPrimaYYa;
tasaError4 = simplify(error1/error2)

%5 - Derivada de phi con respecto a x y con respecto a y
difxy = simplify(diff(diff(phi,x),y));
phiPrimaXYa = subs(difxy,{x,y},{0,0});

phiPrimaXY1 = 1/(4*delta^2)*(phi(P11(1),P11(2))-phi(P_11(1),P_11(2))-phi(P1_1(1),P1_1(2))+phi(P_1_1(1),P_1_1(2)));
phiPrimaXY2 = 1/(4*delta2^2)*(phi(P112(1),P112(2))-phi(P_112(1),P_112(2))-phi(P1_12(1),P1_12(2))+phi(P_1_12(1),P_1_12(2)));

error1 = (phiPrimaXYa-phiPrimaXY1)/phiPrimaXYa;
error2 = (phiPrimaXYa-phiPrimaXY2)/phiPrimaXYa;
tasaError5 = simplify(error1/error2)

%6 - Phi con respecto a su normal. Al ser combinación lineal de dos cosas
%que son de segundo orden, entonces se asegura que sea de segundo orden
n = [1 1];
nNorm = n/norm(n);
%La derivada enotonces es d_phix*Nx + d_phiY*Ny
%En este caso ambas son ceros, por lo que su resultado será cero