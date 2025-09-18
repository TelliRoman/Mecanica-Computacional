function [coeficientes N1 N2 N3 N4]= calcularFuncionesdeFormaCuad(ptos)
% ptos: matriz de puntos cómo si fuera un xnode de 3 filas
%términos independiente
ti = [ %matriz de vectores columna
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1 
];

%triángulos i = 1:3
% T = Σ Ti*Ni 
K = [
    ptos(1,:) ptos(1,1)*ptos(1,2) 1;
    ptos(2,:) ptos(2,1)*ptos(2,2) 1;
    ptos(3,:) ptos(3,1)*ptos(3,2) 1;
    ptos(4,:) ptos(4,1)*ptos(4,2) 1;
];
coeficientes = K\ti; %matriz de vectores columna; [ai;bi;ci] N= ax+by+c

N1 = @(x,y) coeficientes(1,1).*x+coeficientes(2,1).*y + coeficientes(3,1).*y*x+coeficientes(4,1);
N2 = @(x,y) coeficientes(1,2).*x+coeficientes(2,2).*y + coeficientes(3,2).*y*x+coeficientes(4,2);
N3 = @(x,y) coeficientes(1,3).*x+coeficientes(2,3).*y + coeficientes(3,3).*y*x+coeficientes(4,3);
N4 = @(x,y) coeficientes(1,4).*x+coeficientes(2,4).*y + coeficientes(3,4).*y*x+coeficientes(4,4);

end