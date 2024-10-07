close all; clear all; more off;
addpath('C:/Ingenieria Informatica/4to año/Segundo cuatri/Mecanica Computacional/DF-1D');
##Punto A
xnode = [
 -4.00, -3.00;
 -2.00, -3.00;
  0.00, -3.00;
  2.00, -3.00;
  4.00, -3.00;
 -4.00, -1.00;
 -2.00, -1.00;
  0.00, -1.00;
  2.00, -1.00;
  4.00, -1.00;
 -4.00,  1.00;
 -2.00,  1.00;
  0.00,  1.00;
  2.00,  1.00;
  4.00,  1.00;
 -4.00,  3.00;
 -2.00,  3.00;
  0.00,  3.00;
  2.00,  3.00;
  4.00,  3.00;
];

icone = [
  1, 2, 7, 6;
  2, 3, 8, 7;
  3, 4, 9, 8;
  4, 5, 10, 9;
  6, 7, 12, 11;
  7, 8, 13, 12;
  8, 9, 14, 13;
  9, 10, 15, 14;
  11, 12, 17, 16;
  12, 13, 18, 17;
  13, 14, 19, 18;
  14, 15, 20, 19;
];

NEU = [
  1, 0, 1;
  2, 0, 1;
  3, 0, 1;
  4, 0, 1;
  5, 0, 1;
  16, 0,1;
  17, 0,1;
  18,0,1;
  19,0,1;
  20,0,1
];
ROB=[
  5,2,10,2;
  10,2,10,2;
  15,2,10,2;
  20,2,10,2
];
DIR =[
  1,20;
  6,20;
  11,20;
  16,20
];

model.nnodes = size(xnode,1);
model.k = 3*ones(1,length(xnode));
model.c = zeros(1,length(xnode));
model.G = zeros(1,length(xnode));
for i=1:length(xnode)
  x = xnode(i,1);
  model.G(i) = 100*x;
endfor
## Esquema Temporal: [0] Explícito, [1] Implícito, [X] Estacionario
model.ts = 1;
## Parámetros para esquemas temporales
model.rho = 1.0;
model.cp = 1.0;
model.maxit = 10000;
model.tol = 1.000000e-05;
model.dt = 1/400;
## Condición inicial
model.PHI_n = zeros(model.nnodes,1);
disp('Iniciando el método numérico...');
## Llamada principal al Método de Diferencias Finitas
[PHI,Q] = fdm2d(xnode, icone, DIR, NEU, ROB, model);
disp('Finalizada la ejecución del método numérico.');
mode = 0;
graph = 0;
##fdm2d_graph_mesh(full(PHI),Q,xnode,icone,mode,graph);
##Punto A
T_13=PHI(13,end)
T_8=PHI(8,end)
T_00 = (T_13 - T_8)*(1/2) + T_8
##Punto B
l1=-4; l2=4;
N=21;
dx = (l2-l1)/N;
xnode = l1:dx:l2;
cb = [1 20 -1; 3 2 10];
model.rho = 0; model.cp = 0;
model.k = 3; model.c = 0;
model.G = 100 .* (xnode);
dt = 0;
et=[0 0 0 0];
Tini = 0;
figure(2)
T = difFinitas(xnode, model, cb, et,Tini);
T_11=T(11);
T_12=T(12);
T_00 = (T_12 - T_11)/(dx)*(dx/2) + T_11
##Punto C
Nodofic = T(21) - ((2*dx*2)/3) * T(22) + ((2*dx*2)/3) * 10;
GrandT = Nodofic - T(21) / dx
