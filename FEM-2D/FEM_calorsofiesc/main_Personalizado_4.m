% ======================[ examen)]=====================
close all; clear all; more off; clc;

xnode = [0.1 1; 2 0.1; 1 2];

nodes = xnode;

J = [ nodes(2, :) - nodes(1, :); ...
      nodes(3, :) - nodes(1, :)];
Be = gen_Be_heat(nodes, 1, 1);

##d12 = norm(J(1, :))
##
##Ae = 0.5*det([ones(3, 1) nodes])
d23 = norm(xnode(3, :) - xnode(2, :))

icone = [
  1 2 3 -1;
];
% DIR = [nodo, Phi]

% inventado, para que no de error
DIR = [
1 100
];

% NEU = [nodo1, nodo2, q]
NEU = [
       1, 2, -10;
];
% ROP = [nodo1, nodo2, h, Phi_inf]
ROB = [2 3 1000 200];

% PUN = [n_elemento, G, xp, yp]
PUN = [];

disp('---------------------------------------------------------------');
disp('Inicializando modelo de datos...');

model.nnodes = size(xnode,1);
model.nelem = size(icone,1);

model.kx = 0.1;
model.ky = 0.1;
model.c = 0;

% Cantidad de elementos
model.G = 100*ones(model.nelem, 1);

% Esquema Temporal: [0] Explicito, [1] Implicito, [X] Estacionario
model.ts = 2;

% Parametros para esquemas temporales
model.rho = 1; % Expresado en kg/m^3
model.cp = 1.0;
model.maxit =            1;
model.tol = 1.000000e-05;

% Condicion inicial
model.PHI_n = mean(DIR(:,2))*ones(model.nnodes,1);

disp('Iniciando el metodo numerico...');

% Llamada principal al Metodo de Elementos Finitos
[PHI,Q] = fem2d_heat(xnode,icone,DIR,NEU,ROB,PUN,model);

disp('Finalizada la ejecucion del metodo numerico.');

disp('---------------------------------------------------------------');
disp('Iniciando el post-procesamiento...');

% mode ---> modo de visualización:
%           [0] 2D - Con malla
%           [1] 3D - Con malla
%           [2] 2D - Sin malla
%           [3] 3D - Sin malla
% graph --> tipo de grafica:
%           [0] Temperatura (escalar)
%           [1] Flujo de Calor (vectorial)
%           [2] Flujo de Calor eje-x (escalar)
%           [3] Flujo de Calor eje-y (escalar)
%           [4] Magnitud de Flujo de Calor (escalar)
mode = 0;
graph = 0;
fem2d_heat_graph_mesh(full(PHI),Q,xnode,icone,mode,graph);

disp('Finalizado el post-procesamiento.');


% ======================[ Ejemplo 2(EJERCICIO EXAMEN.pdf)]=====================




