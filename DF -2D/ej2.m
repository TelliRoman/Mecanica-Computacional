close all; clear all; more off;
% Definir dx y dy
dx = 1/10;
dy = 1/10;
% Inicializar la matriz de nodos
xnode = [];
% Generar los nodos
for j = 0:10  % Iterar sobre y
    for i = 0:10  % Iterar sobre x
        xnode = [xnode; i*dx, j*dy];
    end
end
% Mostrar la matriz de nodos
#plot(xnode(:,1),xnode(:,2),'o');
NEU = [];
ROB = [];
DIR = [
  1,0;
  2,0;
  3,0;
  4,0;
  5,0;
  6,0;
  7,0;
  8,0;
  9,0;
  10,0;
  11,0;
  12,0;
  23,0;
  34,0;
  45,0;
  56,0;
  67,0;
  78,0;
  89,0;
  100,0;
  111,0;
  112,0;
  113,0;
  114,0;
  115,0;
  116,0;
  117,0;
  118,0;
  119,0;
  120,0;
  121,0;
  22,0;
  33,0;
  44,0;
  55,0;
  66,0;
  77,0;
  88,0;
  99,0;
  110,0
];
#plot(xnode(DIR(:,1),1),xnode(DIR(:,1),2),'o');
% Dimensiones de la malla
nx = 11;  % Número de nodos en x
ny = 11;  % Número de nodos en y
% Inicializar la matriz icone
icone = [];
% Crear los elementos
for j = 1:(ny-1)
    for i = 1:(nx-1)
        % Definir los nodos de cada cuadrado (elemento)
        n1 = i + (j-1)*nx;       % Nodo inferior izquierdo
        n2 = n1 + 1;             % Nodo inferior derecho
        n3 = n1 + nx;            % Nodo superior izquierdo
        n4 = n3 + 1;             % Nodo superior derecho
        % Añadir el elemento a la matriz icone
        icone = [icone; n1, n2, n4, n3];
    end
end
model.nnodes = size(xnode,1);
model.k = ones(1,length(xnode));
model.c = zeros(1,length(xnode));
model.G = zeros(1,length(xnode));
% Esquema Temporal: [0] Explícito, [1] Implícito, [X] Estacionario
model.ts = 1;
% Parámetros para esquemas temporales
model.rho = 1.0;
model.cp = 1.0;
#model.maxit = 10; #PARA EL PUNTO 1  QUE PIDE LA T EN t=0.025, lo cual son 10 iteraciones de dt = 1/400
model.maxit = 4; #punto 2 para dt=1/400
model.tol = 1.000000e-03;
model.dt = 1/400;
% Condición inicial
model.PHI_n = sin(xnode(:,1) .* pi) .* sin(xnode(:,2) .* (2*pi));
disp('Iniciando el método numérico...');

% Llamada principal al Método de Diferencias Finitas
[PHI,Q] = fdm2d(xnode, icone, DIR, NEU, ROB, model);

disp('Finalizada la ejecución del método numérico.');

mode = 0;
graph = 0;
fdm2d_graph_mesh(full(PHI),Q,xnode,icone,mode,graph);
