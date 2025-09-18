% Codigo para resolver sistemas de elementos tipo barra en 2D
% Barra2D.m

% Variables:
% Nele = Es un escalar que define el número de barras que tiene el sistema.

% E =  Módulo de elasticidad de las barras. Nota: Lo usamos asi por si tenemos
% diferentes valores en cada barra. Si todos tienen el mismo usa
% índices en E para definir el mismo valor n veces en un vector 
% (por ejemplo: E(1:Nele) = X)
% Si algunas o todas la barras tienen diferentes valores para E, escribe
% cada uno en un vector (E = [E1 E2 E3 ...]). Luego direccionamos a ese vector

% area = Area de la sección transversal de cada barra. Al igual que con E,
% si todas las barras tienen la misma área usa índices 
% (por ejemplo: area(1:Nele) = X)
% Si algunas o todas la barras tienen diferentes valores de area, escribe
% cada uno en un vector (area = [area1 area2 area3 ...])

% xnod = Son las coordenadas(X,Y)de cada nodo en las unidades que se defina el
% problema. Es importante poner el origen en el primer nodo(mas facil). Ejemplo:
% [x1 y1 ; x2 y2 ; ...]

% icone = Son los indices de los nodos que conforman a cada barra. Cada
% barra se forma por una li­nea que va de un nodo a otro.

% Desplaz = Condiciones de frontera para cada componente XY de cada nodo 
% (0 si el nodo esta empotrado y 1 si el nodo puede moverse). Por ejemplo:
% [dx1 dy1 dx2 dy2 dx3 dy3 ...]

% Fuerzas = Vector de fuerzas del sistema (0 si no hay una fuerza actuando
% en dicho nodo y un valor cualquiera si hay una fuerza. Dependiendo del
% sentido de cada fuerza, se debera usar un signo negativo o positivo).
% [Fx1 Fy1 Fx2 Fy2 Fx3 Fy3 ...

% L = Longitud de cada barra
% Nomenclatura de matrices
% MG Matriz global
% MGR Matriz global reducida

% limpiamos la ventana
clc; clear all; clf;

%% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Configuracion~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%%
% Problema 1 Bidimensionales
% En este ejemplo tenemos los valores en unidades inglesas o metricas
% Fuerza en libra (lb) o Newtons (N), desplazamiento en pulgadas (in) o (mm), 
% Tension en (psi) o (N/m^2)(Pa)

%Nele = 3;                                % Numero de elementos
%E(1:Nele) = 30*10^6;                     % Modulo de elasticidad por ele/^barra
%area(1:Nele) = 2;                        % areas de cada elemento/barra
% Arreglo bidimensional por ser 2D
%xnod = [0 0 ; 0 120; 120 120; 120 0];    % Coordenadas de cada nodo
%icone = [1 2;1 3;1 4];                   % Conectividad de los Nodos 
% estos vectores manejan pares de valores por ser 2D
%Desplaz = [1 1 0 0 0 0 0 0];             % Desplazamientos por nodo
%Fuerzas = [0 -10000 0 0 0 0 0 0 ];       % Fuerzas por nodo


% problema 2

%  Nele=3;
%  E(1:Nele)=210*10^9;
%  area(1:Nele)=0.0004;
%  xnod=[0 0 ; 0 2 ; -3 0 ; -5*sind(30) -5*sind(60)];
%  icone=[1 2 ; 1 3 ; 1 4];
%  Desplaz =[1 1 0 0 0 0 0 0];
%  Fuerzas=[0 -40000 0 0 0 0 0 0];

% problema 3

% Nele=3;
% E(1:Nele)=10*10^6;
% area(1:Nele)=1;
% xnod=[0 0 ; -100 100*tand(60); -100  0 ;-100 -100*tand(30)];
% icone=[1 2;1 3;1 4];
% Desplaz = [1 1 0 0 0 0 0 0 ];
% Fuerzas = [1000 1000 0 0 0 0 0 0];
 
%% Ejemplo 2 Apunte
Nele=2;
E(1:Nele)=210*10^6;
area(1:Nele)=0.0006;
xnod=[0 0 ; 4 0 ; 0 3];
icone=[1 2 ; 3 2 ];
Desplaz =[0 0 1 1 0 0];
Fuerzas=[0 0 -1000 0 0 0];
 

% Definimos las matrices de rigidez por cada barra/elemento

L = zeros(1,Nele);       % Inicializamos el vector de longitudes
% Inicializamos el vector de inclinaciones (angulos) de cada barra
% facilita la optimizacion del codigo
grados = zeros(1,Nele); 

for i=1:Nele
    indice = icone(i,:);      % generamos indices para las barras
    b = xnod(indice(2),:);    % Tomamos los valores de Y2 y Y1
    a = xnod(indice(1),:);    % Tomamos los valores de X2 y X1
    % calculamos la longitud de cada barra como norma Euclideana
    % usando la distancia entre dos puntos
    
    L(i)=norm(b-a);  
    
    % Determinamos el angulo del elemento con respecto a la horizontal
    % por convencion
    dx = xnod(indice(2),1) - xnod(indice(1),1);
    dy = xnod(indice(2),2) - xnod(indice(1),2);   
    % Importante:
    % Determinamos en que cuadrante se encuentra el elemento/barra
    
    grados(i) = atand(dy/dx);        % Cuadrante 1
    if sign(dy)==1 && sign(dx)==-1   % Cuadrante 2
        grados(i) = 180 + grados(i);
    elseif dy==0 && sign(dx)==-1 % Sobre la horizontal pero en el cuadrante 2
        grados(i)=180;
    elseif sign(dy)==-1 && sign(dx)==-1   %Cuadrante 3
        grados(i) = 180 + grados(i);
    elseif sign(dy)==-1 && sign(dx)==1    %Cuadrante 4
        grados(i) = 360 + grados(i);
    end  
end
format short g
% longitud de cada barra.
L
% Angulo de cada barra con la horizontal
grados

% Calculo de la constante AE/L para cada elemento/barra
k =(E.*area)./L        

% Ensamble de la matriz global de rigidez.
% Inicializamos las matrices de rigidez de cada elemento/barra

A = zeros(4,4,Nele);   

for i=1:Nele
    % Calculo de la matriz de rigidez de cada elemento (AE/L)*k_local
    
    % la transformada lineal la calculamos aparte
    [M] = transformadalineal(grados(i));
    A(:,:,i) = k(i)*M;  
    
    % Convertimos el arreglo A en celdas pero las matrices de 4x4 de A las
    % dividimos en 4 paquetes de 2x2
    j = icone(i,:);   % Par de i­ndice de cada elemento
    B(:,:,i) = mat2cell(A(:,:,i),[2 2],[2 2]);
    
    % Asignamos cada paquete en los i­ndices correspondientes de la matriz
    % global de rigidez
    C(j(1),j(1),i) = B(1,1,i);
    C(j(1),j(2),i) = B(1,2,i);
    C(j(2),j(1),i) = B(2,1,i);
    C(j(2),j(2),i) = B(2,2,i);
end
A

S = 2*size(xnod,1);    %Dimensiones de la matriz global
m = cell(S/2,S/2);

for i=1:size(xnod,1)
    for j=1:size(xnod,1)
        % En cada vuelta tomamos todos los elementos con el mismo indice
        % (i,j),los superponemos y sumamos entre si.
        clear x
        x(:,:,:)=cell2mat(reshape(C(i,j,:),1,[],Nele));
        m(i,j)={sum(x,3)};
        
        % Si en ese indice(i,j) no se asigna ningun paquete, 
        % metemos un paquete de ceros de 2x2
        if size(m{i,j})==[0 0]  
            m(i,j)={zeros(2,2)};
        end
    end
end
MG=cell2mat(m)   % Convertimos la matriz global en un arreglo numerico

% Reducimos la matriz global, es decir sacamos los desplazamientos nulos en 
% filas y columnas
% buscamos donde se encuentran
v = find(Desplaz==0)  
                 
MGR=MG;
MGR(v,:)=0;     
MGR(:,v)=0;
indicefil=zeros(1,S);  % indices para las filas
indicecol=zeros(1,S);  % indices para las columnas

for i=1:S
    if MGR(i,:)==0
        indicefil(i)=i;
    end
    if MGR(:,i)==0
        indicecol(i)=i;
    end
end
% Eliminar filas y columnas de ceros para tener la matriz global reducida
MGR(indicefil~=0,:)=[];    
MGR(:,indicecol~=0)=[];
MGR
% Ponemos los valores de la matriz reducida con ceros y un 1 donde conocemos el desplaz
%MGR(2,1)=0; MGR(2,2)=1;
%MGR
%Eliminar filas y columnas de ceros de las fuerzas
Fuerzas(indicefil~=0)=[] 
% Redistribuimos las fuerzas con desplazamientos
%Fuerzas(1,2)=-0.05

% Calculamos los desplazamientos nodales en ambas direcciones, por un metodo
% directo de Octave

d = MGR\Fuerzas'  

% vector o arreglo con los valores finales calculados del desplazamiento       
dfinal = zeros(S,1);
k=1;
%Insertamos los desplazamientos calculados en el vector original
for i=1:length(Desplaz) 
    if Desplaz(i)==0
        dfinal(i,1)=0;
    else
        dfinal(i,1)=d(k);
        k=k+1;
    end
end

% Vector de coeficientes [-C -S C S] para calcular los esfuerzos (teoria)
Ve = @(x) [-cosd(x)  -sind(x)  cosd(x)  sind(x)];
Ve(1)
esfuerzosC = zeros(Nele,4)


for i=1:Nele
  esfuerzosC(i,:) = Ve(grados(i));
end
esfuerzosC 



%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Resultados~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

d2 = mat2cell(dfinal,2*ones(1,size(xnod,1)),1); %Dividimos dfinal en paquetes de 2x1
Esfuerzos=zeros(1,Nele);
Flocal=zeros(Nele,4);
j=1;
for i=1:Nele    %Calcular los esfuerzos por elemento
    indice=icone(i,:);
    Esfuerzos(i)=(E(i)./L(i))*esfuerzosC(i,:)*[d2{indice(1,1)};d2{indice(1,2)}];
    Flocal(i,:)=A(:,:,i)*[d2{indice(1,1)};d2{indice(1,2)}]; 
    j=j+2;
end

dfinal                             %Imprimir resultados
Esfuerzos
Reacciones=MG*dfinal               % Reacciones globales
Flocal                             % Reacciones locales por elemento


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Plot~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

d3=reshape(dfinal,[2,size(xnod,1)])';
NodosDesp=xnod + d3;

for j=1:Nele
    indice=icone(j,:);
    line([xnod(indice(1),1) xnod(indice(2),1)],...
        [xnod(indice(1),2) xnod(indice(2),2)],...
        'LineWidth',1.5,'Color','k');
    hold on
    line([NodosDesp(indice(1),1) NodosDesp(indice(2),1)],...
        [NodosDesp(indice(1),2) NodosDesp(indice(2),2)],...
        'LineWidth',1,'Color','b');
end

for i=1:size(xnod,1)
    plot(xnod(i,1),xnod(i,2),'ro','MarkerSize',6,'MarkerFaceColor','r');
    hold on
end
axis([min(xnod(:,1))-10 max(xnod(:,2))+10 min(xnod(:,1))-10 max(xnod(:,2)+10)])
grid on
grid minor
zoom on
NodosDespx=NodosDesp(:,1);
NodosDespy=NodosDesp(:,2);
Nocerox=find(d3(:,1)~=0);
Noceroy=find(d3(:,2)~=0);
plot(NodosDespx(Nocerox),NodosDespy(Noceroy),'og','MarkerSize',6,'MarkerFaceColor','g');










































