clc; clear all; clf;

Nele = 2;                             % N�mero de elementos
E = [1e9 1e9];        % M�dulo de elasticidad por barra/elemento
area = [pi/100 pi/100];        % Areas de cada elemento
xnod = [0 ; 0.2 ; 1];         % Coordenadas de cada nodo
icone = [1 2 ; 2 3];            % conectividad de cada barra
Desplaz = [0 1 1];                  % Desplazamientos por nodo s cond. borde
Fuerzas = [0 400 1000];              % Fuerzas aplicadas por nodo
L = [0.2 0.8];                    % Longitud de cada barra en un vector.

% Definimos las matrices de rigidez por cada barra/elemento
A = zeros(2,2,Nele);
for i = 1:Nele
    % Matrices de rigidez por elemento
    A(:,:,i) = ((E(i).*area(i))./L(i))*[1 -1 ; -1 1]; 
end
% Las visualizamos 
format short g
% Vemos cada una de las matrices
A

% Ensamblamos las matrices de rigidez de cada elemento en la matriz global
% que denominamos MG

S = size(xnod,1);  % Cantidad de nodos.
MG=zeros(S,S);     % Matriz global vac�a
% Recorremos las barras
for i = 1:Nele
    m = icone(i,1);
    n = icone(i,2);
    % Incorporamos las matrices de cada barra en la matriz global
    MG([m n],[m n],i) = A(:,:,i);
end
MG
% Proceso de ensamble de todas las matrices (globales) de cada barra en una unica
% matriz

MG = sum(MG,3)                        

% Para el calculo podemos seguir un `proceso de reduccion de la matriz global

v = find(Desplaz==0); % buscamos los valores nulos donde pusimos las condiciones
                      % de contorno (fijaciones)    
% Formamos la matriz reducida               
MGR=MG;
MGR(v,:)=0;  % ponemos ceros en la filas relacionadas con el nodo fijado
MGR(:,v)=0;  % ponemos ceros en la columnas relacionadas con el nodo fijado

indicefil = zeros(1,S);
indicecol = zeros(1,S);

for i=1:S
    if MGR(i,:)==0
        indicefil(i)=i;
    end
    if MGR(:,i)==0
        indicecol(i)=i;
    end
end
% Eliminar filas y columnas con ceros para tener la matriz global reducida
MGR(indicefil~=0,:)=[];    
MGR(:,indicecol~=0)=[]

% Eliminar filas y columnas con ceros de las fuerzas (vector del lado derecho)
% le llamamos Fuerzas a este vector

Fuerzas(indicefil~=0)=[]  


% Calculamos los desplazamientos por nodo
d = MGR\Fuerzas' % los calculamos con el modelo directo de Octave    
    
k = 1;
d2 = zeros(S,1);

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
    Esfuerzos(i)=(E(i)./L(i))*[-1 1]*[d2(indice(1,1));d2(indice(1,2))];
end

% Mostramos resultados
% vector completo con los desplazamientos
d2 

% Tensiones en cada barra     
Esfuerzos

% Calcular las reacciones por barra/elemento (ver teoria)
Reacciones = MG*d2  

% Desplazamientos:
eps = Esfuerzos/E

%~~~~~~~~~~~~~~~~~~~~Gr�ficamos el dominio con resultados~~~~~~~~~~~~~~~~~~~~~~%

figure(1)
line([xnod(1) xnod(end)],[0 0],'Color','k','LineWidth',2);
hold on
plot(xnod',zeros(1,length(xnod)),'or','MarkerSize',6,'MarkerFaceColor','r');
grid on
grid minor

NodosDesp = xnod' + d2';
Nocero = find(d2~=0);
hold on

plot(NodosDesp(Nocero),zeros(1,length(Nocero)),'og','MarkerSize',6,'MarkerFaceColor','g');
axis([xnod(1)-10 xnod(end)+10 -1 1]);
title('Ejercicio Resuelto(Hacer zoom en cada nodo hasta ver el desplazamiento');

legend({'Barra';'Nodos empotrados' ; 'Nodos desplazados'});


