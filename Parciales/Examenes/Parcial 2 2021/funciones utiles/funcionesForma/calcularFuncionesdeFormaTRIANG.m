function [coeficientes N1 N2 N3]= calcularFuncionesdeFormaTRIANG(ptos)
% ptos: matriz de puntos cómo si fuera un xnode de 3 filas
%términos independiente
ti = [ %matriz de vectores columna
    1 0 0;
    0 1 0;
    0 0 1
];


%triángulos i = 1:3
% T = Σ Ti*Ni 
K = [
    ptos(1,:) 1;
    ptos(2,:) 1;
    ptos(3,:) 1
];
coeficientes = K\ti; %matriz de vectores columna; [ai;bi;ci] N= ax+by+c

N1 = @(x,y) coeficientes(1,1).*x+coeficientes(2,1).*y+coeficientes(3,1);
N2 = @(x,y) coeficientes(1,2).*x+coeficientes(2,2).*y+coeficientes(3,2);
N3 = @(x,y) coeficientes(1,3).*x+coeficientes(2,3).*y+coeficientes(3,3);

end