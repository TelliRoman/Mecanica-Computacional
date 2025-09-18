close all; clear all; more off;

xnode = [
  0.0000000000000000, 0.0000000000000000;
  0.0000000000000000, 1.5000000000000000;
  0.5000000000000000, 1.0000000000000000;
  1.0000000000000000, 0.0000000000000000;
];

icone = [
       1,      3,      2,     -1;
       4,      3,       1,      -1;
];
%   - Columna 1: número de nodo.
%   - Columna 2: valor en ese nodo (escalar).
DIR = [
       1, 20.0000000000000000;
       2, 20.0000000000000000;
];
%   - Columnas 1-2: dos nodos contiguos formando un lado de un elemento.
%   - Columna 3: valor de flujo térmico (q) asociado al lado del elemento.
NEU = [
       1, 4.0000000000000000, 0;
       4, 3.0000000000000000, 30;
];
%   - Columnas 1-2: dos nodos contiguos formando un lado de un elemento.
%   - Columna 3: valor de coeficiente de calor (h).
%   - Columna 4: valor de temperatura de referencia (phi_inf).
ROB = [
       3, 2.0000000000000000, 20.0000000000000000, 100;
];
%   - Columna 1: número de elemento al que se aplica la fuente.
%   - Columna 2: valor de la fuente aplicada (G).
%   - Columnas 3-4: posición absoluta (x,y) donde se aplica la fuente
%     (cualquier parte del dominio).
PUN = [
       1, 5.0000000000000000, 0.2500000000000000, 0.8000000000000000
];

disp('---------------------------------------------------------------');
disp('Inicializando modelo de datos...');

model.nnodes = size(xnode,1);
model.nelem = size(icone,1);

model.kx = 13.0000000000000000;
model.ky = 17.0000000000000000;
model.c = 19.0000000000000000;

model.G = [
    23.0000000000000000;
    23.0000000000000000;
];

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
fem2d_heat_graph_mesh(full(PHI),Q,xnode,icone,mode,graph);

disp('Finalizado el post-procesamiento.');
