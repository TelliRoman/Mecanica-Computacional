close all; clear all; more off; clc;

xnode = [
  0.0, 0.0;
  0.4, 0.0;
  0.4, 0.15;
  0.0, 0.3;
  0.4, 0.3;
];

icone = [
       1,      2,      3,     -1;
       4,      1,       3,      -1;
       4,      3,       5,      -1;
];

DIR = [
       1, 180;
       2, 180;
];

NEU = [
       1, 4, 0;
       4, 5, 0;
];

ROB = [
       2, 3, 50, 25;
       5, 3, 50, 25;
];

PUN = [];

disp('---------------------------------------------------------------');
disp('Inicializando modelo de datos...');

model.nnodes = size(xnode,1);
model.nelem = size(icone,1);

model.kx = 1.5;
model.ky = 1.5;
model.c = 0;

% Cantidad de elementos
model.G = [
    0;
    0;
    0;
];

% Esquema Temporal: [0] Explícito, [1] Implícito, [X] Estacionario
model.ts = 2;

% Parámetros para esquemas temporales
model.rho = 1.0;
model.cp = 1.0;
model.maxit =            1;
model.tol = 1.000000e-05;

% Condición inicial
model.PHI_n = mean(DIR(:,2))*ones(model.nnodes,1);

disp('Iniciando el método numérico...');

% Llamada principal al Método de Elementos Finitos
[PHI,Q] = fem2d_heat(xnode,icone,DIR,NEU,ROB,PUN,model);

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
#fem2d_heat_graph_mesh(full(PHI),Q,xnode,icone,mode,graph);

disp('Finalizado el post-procesamiento.');

% Posproceso, evaluacion puntual

% yp = 0.5, por ser simetrico el sistema, se toma que yp = 0.1
xp = 0.1; yp = 0.1;

nodos = icone(2, 1:3);
pos_nodes = xnode(nodos, :);

N = fem2d_heat_blerp(pos_nodes, xp, yp);
Naux = blerp_cartes(pos_nodes, xp, yp);
P = N'*PHI(nodos);

hold on;
plot(xp, yp, 'ro');


