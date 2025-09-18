addpath 'C:\Users\Usuario\Downloads\peobE\parcial2\Para rendir\funciones utiles\funcionesForma'
syms xi yi xj yj xk yk
ptos = [0 0; 1 0.5; 0.25 1];
% ptos = [0 0; 1 0; 0 1]; %ptos master
[coeficientes N1 N2 N3]= calcularFuncionesdeFormaTRIANG(ptos)

B = coeficientes(1:2,1:3);
A = 0.5*det([ones(3,1) ptos]);
k = [1 0;0 1];
K = B'*k*B*A

%Para coordenadas normales:
J = [
    ptos(2,1)-ptos(1,1) ptos(2,2)-ptos(1,2);
    ptos(3,1)-ptos(1,1) ptos(3,2)-ptos(1,2);
    ];
DN = [-1 1 0; -1 0 1];

V = inv(J)*DN;
Kn = V'*k*V*det(J)*0.5;

%Matriz de masa:
w = 1/6;
pospg = [0.5 0;0 0.5;0.5 0.5];
mMasa = zeros(3);
for i=1:3
    s = pospg(i,1);
    t = pospg(i,2);
    Nnum = [1-s-t, s, t];
    mMasa = mMasa + w*Nnum'*Nnum*det(J);
end
mMasa