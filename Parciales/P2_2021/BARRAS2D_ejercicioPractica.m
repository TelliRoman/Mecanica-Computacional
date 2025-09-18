% Calculo Elementos de Barra 1D
% limpiamos la ventana
clc; clear all; clf;

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Configuracion~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
Nele = 3;                                 % N�mero de elementos
E = [30e6 30e6 30e6];                     % M�dulo de elasticidad por barra/elemento
area = [2 2 2];                           % Areas de cada elemento
xnod = [0 0 ; 0 120 ; 120 120 ; 120 0];       % Coordenadas de cada nodo
icone = [1 2 ; 1 3; 1 4];            % conectividad de cada barra
Desplaz = [1 1 0 0 0 0 0 0];                  % Desplazamientos por nodo s cond. borde
Fuerzas = [0 -1e4, 0 0, 0 0, 0 0];              % Fuerzas aplicadas por nodo
angulo = [90 45 0];
L = [];                    % Longitud de cada barra en un vector (lo calculamos de bajo)

for i=1:Nele
    L = [L norm(xnod(icone(i,2),:)- xnod(icone(i,1),:))];
end
% Definimos las matrices de rigidez por cada barra/elemento
k = zeros(4,4,Nele);
for i = 1:Nele
    %Datos para la matriz:
    c = cos(deg2rad(angulo(i))); s = sin(deg2rad(angulo(i)));
    c2 = c^2; s2 = s^2; cs = c*s;
    
    % Matrices de rigidez por elemento
    k(:,:,i) = ((E(i).*area(i))./L(i))*[c2 cs -c2 -cs; cs s2 -cs -s2;-c2 -cs c2 cs; -cs -s2 cs s2]; 
end 
% Las visualizamos 
format short g
% Vemos cada una de las matrices
k;

% Ensamblamos las matrices de rigidez de cada elemento en la matriz global
% que denominamos MG

S = size(xnod,1);  % Cantidad de nodos.
K= zeros(2*S,2*S,Nele);     % Matriz global vac�a
% Recorremos las barras
for i = 1:Nele
    m = icone(i,1);
    n = icone(i,2);
    % Incorporamos lx
    K([2*m-1 2*m (2*n-1) 2*n],[2*m-1 2*m (2*n-1) 2*n],i) = k(:,:,i);
end
K
% Proceso de ensamble de todas las matrices (globales) de cada barra en una unica
% matriz

K = sum(K,3);                        
% [indx] = find(K<=1e-9);
% K(indx)=0;
% K
% Para el calculo podemos seguir un `proceso de reduccion de la matriz global

v = find(Desplaz==0); % buscamos los valores nulos donde pusimos las condiciones
                      % de contorno (fijaciones)    
v2 = find(Desplaz~=0 & Desplaz~=1); % buscamos los valores no nulos donde pusimos las condiciones iniciales

% Formamos la matriz reducida               
MGR=K;
MGR(v,:)=0;  % ponemos ceros en la filas relacionadas con el nodo fijado
MGR(:,v)=0;  % ponemos ceros en la columnas relacionadas con el nodo fijado
MGR(v2,:)=0;  % ponemos ceros en la columnas relacionadas con el nodo fijado
MGR(v2,v2)=1;  % ponemos ceros en la columnas relacionadas con el nodo fijado

indicefil = zeros(1,2*S);
indicecol = zeros(1,2*S);

for i=1:2*S
    if MGR(i,:)==0 %si toda la fila es igual a cero
        indicefil(i)=i; %Guardo posición
    end
    if MGR(:,i)==0 %Si toda la col es cero
        indicecol(i)=i;
    end
end
% Eliminar filas y columnas con ceros para tener la matriz global reducida
MGR(indicefil~=0,:)=[];    
MGR(:,indicecol~=0)=[];

% Eliminar filas y columnas con ceros de las fuerzas (vector del lado derecho)
% le llamamos Fuerzas a este vector

Fuerzas(indicefil~=0)=[];  

%seteamos las fuerzas conocidas
Fuerzas(v2)=Desplaz(v2);

% Calculamos los desplazamientos por nodo
d = MGR\Fuerzas' % los calculamos con el modelo directo de Octave    
    
k = 1;
d2 = zeros(2*S,1);

% Desplazamientos calculados en el vector de desplazamientos original
for i=1:length(Desplaz) 
    if Desplaz(i)==0
        d2(i,1)=0;
    else
        d2(i,1)=d(k);
        k=k+1;
    end
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~Resultados Pedidos~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Esfuerzos (tensiones)
Esfuerzos =zeros(1,Nele);
for i=1:Nele     %Calcular los esfuerzos por barra/elemento
    indice = icone(i,:);
    c = cos(deg2rad(angulo(i))); s = sin(deg2rad(angulo(i)));
    C = [-c -s c s]; 
    Esfuerzos(i)=(E(i)./L(i))*C*[d2(2*indice(1,1)-1);d2(2*indice(1,1));d2(2*indice(1,2)-1);d2(2*indice(1,2))];
    
end

% Mostramos resultados
% vector completo con los desplazamientos
d2 

% Tensiones en cada barra     
Esfuerzos

% Calcular las reacciones por barra/elemento (ver teoria)
Reacciones = K*d2               

