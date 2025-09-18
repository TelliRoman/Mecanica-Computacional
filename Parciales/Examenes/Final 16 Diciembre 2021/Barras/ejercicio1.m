%Calculo de la reaccion
% R = -(P+b(x))
r = 0.1;
P = 1000;
L = 1;
b = @(x) 500*(x-0.25*L)/(0.75*L);
B = integral(@(x) b(x),0.25*L,L);
R = -(1000+B);
E = 1e9;

A = pi*r^2;


%Estado de tensión en toda la bara, sigma(x) = F/A;
x = linspace(0,L,30);
[~,barra1]=  find(x<=0.25);
[~,barra2]=  find(x>0.25);

tension = ones(size(x));
tension(barra1) = tension(barra1)*R/A; 
tension(barra2) = tension(barra2).*(R+b(x(barra2))+1000)/A;

%Estado de deformaciones:
deformacion = tension/E;

%Desplazamiento en el punto L; deformación = deltaU/deltaL
desplazamiento = deformacion*L;
desplazamiento(end)
