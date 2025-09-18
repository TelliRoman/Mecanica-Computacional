%xi yi
ptos = [
    0 0; %1
    0.1 0; %2
    0 0.1 %3
];
p = [0.5 0.5];

%temperatura en nodos
T = [
    0; %1
    0; %2
    1  %3
];

%conductividad términica
k = 7;

%términos independiente
ti = [ %matriz de vectores columna
    1 0 0;
    0 1 0;
    0 0 1
];

%triángulos i = 1:3
% T = Σ Ti*Ni 
K = [
    [ptos(1,:) 1];
    [ptos(2,:) 1];
    [ptos(3,:) 1]
];
coefNi = inv(K)*ti; %matriz de vectores columna; [ai;bi;ci] 

%Ni = ai+bi*x+ci*y
%dNi/dx = bi
%dNi/dy = ci´

%flujo término
%qx = -k*dT/dx = -k* Σ Ti*dNi/dx = -k* Σ Ti*bi 
%qy = -k*dT/dy = -k* Σ Ti*dNi/dy = -k* Σ Ti*ci
%IGUAL PARA TODO EL ELEMENTO
q_p = -k*[
    coefNi(1,:)*T;
    coefNi(2,:)*T;
];

% %verificacion funciones de forma
% x = ptos(:,1);
% y = ptos(:,2);
N1 = @(x,y) coefNi(1,1).*x+coefNi(2,1).*y+coefNi(3,1);
N2 = @(x,y) coefNi(1,2).*x+coefNi(2,2).*y+coefNi(3,2);
N3 = @(x,y) coefNi(1,3).*x+coefNi(2,3).*y+coefNi(3,3);

phi_q= T(1)*N1(p(1),p(2))+T(2)*N2(p(1),p(2))+T(3)*N3(p(1),p(2));