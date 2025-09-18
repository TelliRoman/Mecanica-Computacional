
clc; clear all; clf;

#d1 = 0.2
#d2 = 0.3
#A_circ1 = pi*(0.2/2)^2

dx = 0.125
Nele = 8;                             #Particionamos barra en 8 elementos
E = [1e10 1e10 1e10 1e10 1e10 1e10 1e10 1e10];        #Modulo de elasticidad es constante

#Aumentar area de cada elemento linealmente modificando el radio de 0.2/2 a 0.3/2
area = [pi*(0.21/2)^2 pi*(0.22/2)^2 pi*(0.24/2)^2 pi*(0.25/2)^2 pi*(0.27/2)^2 pi*(0.28/2)^2 pi*(0.29/2)^2 pi*(0.3/2)^2];
xnod = [0 ; 1*dx ;2*dx ; 3*dx ; 4*dx ; 5*dx; 6*dx; 7*dx; 8*dx];       #Coordenada de cada nodo
icone = [1 2 ; 2 3 ; 3 4 ;4 5; 5 6;6 7;7 8;8 9];            #conectividad de los elementos
Desplaz = [0 1 1 1 1 1 1 1 1];                  #0 indica que el nodo esta fijo
Fuerzas = [0 0 0 125 375 500-500 -375 -125 1000];           #Fuerzas aplicadas por nodo
L = [dx dx dx dx dx dx dx dx];                    #Longitud de cada barra.

# Definimos las matrices de rigidez por cada barra/elemento
A = zeros(2,2,Nele);
for i = 1:Nele
    A(:,:,i) = ((E(i).*area(i))./L(i))*[1 -1 ; -1 1];
end
% Las visualizamos
format short g
% Vemos cada una de las matrices
A

% Ensamblamos las matrices de rigidez de cada elemento en la matriz global
% que denominamos MG

S = size(xnod,1);  % Cantidad de nodos.
MG=zeros(S,S);     % Matriz global vacia
% Recorremos las barras
for i = 1:Nele
    m = icone(i,1);
    n = icone(i,2);
    % Incorporamos las matrices de cada barra en la matriz global
    MG([m n],[m n],i) = A(:,:,i);  %Matriz "global" del elemento i
end
MG
% Proceso de ensamble de todas las matrices (globales) de cada barra en una unica
% matriz

MG = sum(MG,3)  %Ensamble final de todas las matrices "globales" de cada elemento


v = find(Desplaz==0); % buscamos los valores nulos donde pusimos las condiciones
                      % de contorno (fijaciones)
% Formamos la matriz reducida
MGR=MG;
MGR(v,:)=0;  % ponemos ceros en la filas relacionadas con el nodo fijado
MGR(:,v)=0;  % ponemos ceros en la columnas relacionadas con el nodo fijado

indicefil = zeros(1,S);
indicecol = zeros(1,S);

%Buscar que columnas y filas son todas ceros
for i=1:S
    if MGR(i,:)==0
        indicefil(i)=i;
    end
    if MGR(:,i)==0
        indicecol(i)=i;
    end
end
% Eliminar filas y columnas con ceros para tener la matriz global reducida.
% Como los valores en los nodos empotrados es conocido, se puede eliminar la fila y columna de ese nodo
MGR(indicefil~=0,:)=[];
MGR(:,indicecol~=0)=[]

% Eliminar filas y columnas con ceros de las fuerzas (vector del lado derecho)
% le llamamos Fuerzas a este vector

Fuerzas(indicefil~=0)=[]


% Calculamos los desplazamientos por nodo
d = MGR\Fuerzas' %Resolvemos el sistema para obtener los desplzamientos

k = 1;
d2 = zeros(S,1); %Inicializamos d2 para despues agregar los desplazamientos de nodos fijos

% Desplazamientos calculados en el vector de desplazamientos original
for i=1:length(Desplaz)
    if Desplaz(i)==0  %Nodo empotrado
        d2(i,1)=0;
    else
        d2(i,1)=d(k);
        k=k+1;
    end
end


% Esfuerzos (tensiones)
Esfuerzos =zeros(1,Nele);
for i=1:Nele     %Calcular los esfuerzos por barra/elemento
    indice = icone(i,:); %nodos barra i
    Esfuerzos(i)=(E(i)./L(i))*[-1 1]*[d2(indice(1,1));d2(indice(1,2))]; # N = E*(-u1+u2)/L
end


% Mostramos resultados
% vector completo con los desplazamientos
d2

% Tensiones en cada barra
Esfuerzos

% Calcular las reacciones por barra/elemento (ver teoria)
Reacciones = MG*d2 %Matriz global completa * desplazamientos --> A*x = b --> MG*d2 = F


#Deformaciones
% Calculamos las posiciones finales de los nodos
xnod_final = xnod + d2;

% Calculamos las deformaciones en cada elemento
Deformaciones = zeros(size(L));
for i = 1:length(L)
    Deformaciones(i) = (xnod_final(i+1) - xnod_final(i) - L(i)) / L(i);  %Deformacion por barra
end

Deformaciones

Deformaciones2 = Esfuerzos/E(1) %Otra forma de calcular las deformaciones

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

legend({'Barra';'Nodos empotrados y originales' ; 'Nodos desplazados'});



