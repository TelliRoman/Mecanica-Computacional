close all; clear all; more off;

xnode = [
  0.0	0.0;
  1/6	0.0;
  1/3	0.0;
  0.5	0.0;
  2/3	0.0;
  7/9	0.0;
  8/9	0.0;
  1.0	0.0;

  0.0	1/6;
  1/6	1/6;
  1/3	1/6;
  0.5	1/6;
  2/3	1/6;
  7/9	1/6;
  8/9	1/6;
  1.0	1/6;

  0.0	1/3;
  1/6	1/3;
  1/3	1/3;
  0.5	1/3;
  2/3	1/3;
  7/9	1/3;
  8/9	1/3;
  1.0	1/3;

  2/3	5/12;
  7/9	5/12;
  8/9	5/12;
  1.0	5/12;

  0.0	4/9;
  1/6	4/9;
  1/3	4/9;

  2/3	1/2;
  7/9	1/2;
  8/9	1/2;
  1.0	1/2;

  0.0	5/9;
  1/6	5/9;
  1/3	5/9;

  2/3	7/12;
  7/9	7/12;
  8/9	7/12;
  1.0	7/12;

  0.0	2/3;
  1/6	2/3;
  1/3	2/3;
  0.5	2/3;
  2/3	2/3;
  7/9	2/3;
  8/9	2/3;
  1.0	2/3;

  0.0	1.0;
  1/6	1.0;
  1/3	1.0;
  0.5	1.0;
  2/3	1.0;
  7/9	1.0;
  8/9	1.0;
  1.0	1.0;
];

icone = [
       1,2,10,9;
       2,3,11,10;
       3,4,12,11;
       4,5,13,12;
       5,6,14,13;
       6,7,15,14;
       7,8,16,15;
       9,10,18,17;
       10,11,19,18;
       11, 12, 20, 19;
       12, 13, 21, 20;
       13, 14, 22, 21;
       14, 15, 23, 22;
       15, 16, 24, 23;

       17, 18, 30, 29;
       18, 19, 31, 30;
       29, 30, 37, 36;
       30, 31, 38, 37;
       36, 37, 44, 43;
       37, 38, 45, 44;

       21, 22, 26, 25;
       22, 23, 27, 26;
       23, 24, 28, 27;
       25, 26, 33, 32;
       26, 27, 34, 33;
       27, 28, 35, 34;
       32, 33, 40, 39;
       33, 34, 41, 40;
       34, 35, 42, 41;
       39, 40, 48, 47;
       40, 41, 49, 48;
       41, 42, 50, 49;

       43, 44, 52, 51;
       44, 45, 53, 52;
       45, 46, 54, 53;
       46, 47, 55, 54;
       47, 48, 56, 55;
       48, 49, 57, 56;
       49, 50, 58, 57;
];
# EN ICONE NO HAY -1, SOLO EN NEIGHB

DIR = [
      % borde 1
      1, 50;
      2,50;
      3,50;
      4, 50;
      % borde 4
      53, 100;
      54, 100;
      55, 100;
      56, 100;
      57, 100;
      58, 100;
];

NEU = [
      % borde 2
      5, 0, 1;
      6, 0, 1;
      7, 0, 1;
      8, 0, 1;
      %borde 5
      51, 10, 3;
      52, 10,3;
      %borde 7
      20, 0, 3;
      25, 0, 4;
      32, 0, 4;
      39, 0, 4;
      46, 0, 1;
      31, 0, 2;
      38, 0, 2;
];

ROB = [
      %borde 3
       8, 2, 200, 2;
       16, 2, 200, 2;
       24, 2, 200, 2;
       28, 2, 200, 2;
       35, 2, 200, 2;
       42, 2, 200, 2;
       50, 2, 200, 2;
       %borde 6
       9, 10,0,4;
       17, 10,0,4;
       29, 10,0,4;
       36, 10,0,4;
       43, 10,0,4;
       51, 10,0,4; # este nodo se pone dos veces


];

disp('---------------------------------------------------------------');
disp('Inicializando modelo de datos...');

model.nnodes = size(xnode,1);

model.k = zeros(1,length(xnode));
for i=1:length(xnode)
  if xnode(i,1)<0.5
    model.k(i)=1;
  else
    model.k(i)=10;
  endif
endfor

model.c = zeros(1,length(xnode));

model.G = zeros(1,length(xnode));
for i=1:length(xnode)
  x = xnode(i,1);
  y = xnode(i,2);
  model.G(i) = 1000*x-100*y;
endfor

% Esquema Temporal: [0] Explícito, [1] Implícito, [X] Estacionario
model.ts = 2;

% Parámetros para esquemas temporales
model.rho = 1.0000000000000000;
model.cp = 1.0000000000000000;
model.maxit =            1;
model.tol = 1.000000e-05;

% Condición inicial
model.PHI_n = mean(DIR(:,2))*ones(model.nnodes,1);

disp('Iniciando el método numérico...');

% Llamada principal al Método de Diferencias Finitas
[PHI,Q] = fdm2d(xnode, icone, DIR, NEU, ROB, model);

disp('Finalizada la ejecución del método numérico.');

disp('---------------------------------------------------------------');
disp('Iniciando el post-procesamiento...');

% mode ---> modo de visualización:
%           [0] 2D - Con malla
%           [1] 3D - Con malla
%           [2] 2D - Sin malla
%           [3] 3D - Sin malla
% graph --> tipo de gráfica:
%           [0] Temperatura (escalar)
%           [1] Flujo de Calor (vectorial)
%           [2] Flujo de Calor eje-x (escalar)
%           [3] Flujo de Calor eje-y (escalar)
%           [4] Magnitud de Flujo de Calor (escalar)
mode = 0;
graph = 0;
fdm2d_graph_mesh(full(PHI),Q,xnode,icone,mode,graph);

disp('Finalizado el post-procesamiento.');
