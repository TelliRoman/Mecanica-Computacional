clear; clc;
%Funcion analítica
% phi = @(x,y) exp(5*(x^2+y^2))*(2*x^2-x*y-1/2*y^2);
phi = @(x,y) exp(x)+exp(y);
%Largo de la cara
L = 1;
a = sqrt(3)/2*L; %apotema de hexagono regular
h = 2*a; %altura del hexágono
fx = a/h; %factor de interpolación fx = fN/NP
v = 3*a*L; %volumen de celda
%Puntos
P = [0 0];
xn = cos(deg2rad(30));
yn = sin(deg2rad(30));
N1 = [xn -yn];
N2 = [xn yn];

N3 = [0 h];
N6 = [0 -h];

N4 = [-xn yn];
N5 = [-xn -yn];


%Temperaturas en los centroides de celda
phiP = phi(P(1),P(2));
phiN1 = phi(N1(1),N1(2));
phiN2 = phi(N2(1),N2(2));
phiN3 = phi(N3(1),N3(2));
phiN4 = phi(N4(1),N4(2));
phiN5 = phi(N5(1),N5(2));
phiN6 = phi(N6(1),N6(2));

%Temperatura en los centroides de cara:
phiFN1 = fx*phiP+(1-fx)*phiN1;
phiFN2 = fx*phiP+(1-fx)*phiN2;
phiFN3 = fx*phiP+(1-fx)*phiN3;
phiFN4 = fx*phiP+(1-fx)*phiN4;
phiFN5 = fx*phiP+(1-fx)*phiN5;
phiFN6 = fx*phiP+(1-fx)*phiN6;

%Gradiente en P
n1 = [xn -yn 0];
n2 = [xn yn 0];
n3 = [0 1 0];
n4 = [-xn yn 0];
n5 = [-xn -yn 0];
n6 = [0 -1 0];
gradP = 1/v*(n1*phiFN1+...
             n2*phiFN2+...
             n3*phiFN3+...
             n4*phiFN4+...
             n5*phiFN5+...
             n6*phiFN6);