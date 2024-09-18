close all; clear all;

% L1 y L2: extremos izquierdo y derecho respectivamente
% N: cantidad de puntos
% cb: condiciones de borde [tipo valor1 valor2]
  % tipo==1 -> Dirichet -- valor1 = Temp. impuesta
  % tipo==2 -> Neumann -- valor1 = q (flujo impuesto)
  % tipo==3 -> Robin -- valor1 = h (conveccion) -- valor2 = Temp. ext.
% model: struct con los parametros del modelo incluida la fuente
%        punto a punto
% et: esquema temporal [tipo val1 val2 val3]
  % tipo==0 -> Estacionario
  % tipo==1 -> Explicito
  % tipo==2 -> Implicito
  % Si tipo==1 o tipo==2: val1=maxIt, val2=tolError
  % Si tipo==2 val3=dt

% Cualquier ejercicio puede ser resuelto en su versión transiente o estacionaria
###EJERCICIO 1
##l1=0; l2=1;
##N=40;
##dx = (l2-l1)/N;
##xnode = l1:dx:l2;
##cb = [1 0 -1; 2 0 -1];
##model.rho = 1; model.cp = 1;
##model.k = 1; model.c = 0;
##model.G = 100 .* (1 - xnode);
##dt = 4.20 * dx^2;
###et=[2 1500 0.001 dt];
##et=[0 0 0 0];
##Tini = 5 .* xnode .* (2 - xnode);
##T = difFinitas(xnode, model, cb, et,Tini);
##disp(T(xnode == 1/2))
# EJERCICIO 2.a
## L1=0; L2=1;
## N = 100;
## dx = (L2-L1)/N;
## xnode = L1:dx:L2;
## cb = [1 10 -1;1 50 -1];
## model.rho = 1; model.cp = 1;
## model.k = 2; model.c = 0;
## model.G = 100*ones(length(xnode),1); et = [0 -1 -1 -1];
## Tex = -25*(xnode.*xnode)+65*xnode+10;
## T = difFinitas(xnode, model, cb, et);

# EJERCICIO 2.b
# L1=0; L2=2;
# N = 100;
# dx = (L2-L1)/N;
# xnode = L1:dx:L2;
# cb = [1 100 -1;2 0 -1];
# model.rho = 1; model.cp = 1;
# model.k = 1; model.c = 1;
# model.G = zeros(length(xnode),1); et = [0 -1 -1 -1];
# Tex = (100*exp(-xnode).*(exp(2*xnode)+exp(4)))/(1+exp(4));
# T = difFinitas(xnode, model, cb, et);

# EJERCICIO 2.c
# L1=1; L2=5;
# N = 100;
# dx = (L2-L1)/N;
# xnode = L1:dx:L2;
# cb = [2 2 -1;1 0 -1];
# model.rho = 1; model.cp = 1;
# model.k = 1; model.c = 0;
# model.G = 100*((xnode-3).^2); et = [0 -1 -1 -1];
# Tex = (-25*(xnode.^4)+300*(xnode.^3)-1350*(xnode.^2)+1906*xnode+2345)/3;
# T = difFinitas(xnode, model, cb, et);

# EJERCICIO 2.d
# L1=0; L2=1;
# N = 10;
# dx = (L2-L1)/N;
# xnode = L1:dx:L2;
# cb = [1 10 -1;3 0.2 50];
# model.rho = 1; model.cp = 1;
# model.k = 1; model.c = 1;
# model.G = 50*ones(length(xnode),1); et = [0 -1 -1 -1];
# Tex = -36.6897*exp(-xnode)-3.3103*exp(xnode)+50;
# T = difFinitas(xnode, model, cb, et);

# EJERCICIO 2.e
# L1=5; L2=10;
# N = 20;
# dx = (L2-L1)/N;
# xnode = L1:dx:L2;
# cb = [3 2 100;1 50 -1];
# model.rho = 1; model.cp = 1;
# model.k = 2; model.c = 0;
# model.G = xnode.^3; et = [2 5 1e-11 1];
# Tex = -(xnode.^5)./40+(1225*xnode)./3-4600/3;
# T = difFinitas(xnode, model, cb, et);

# EJERCICIO 2.f
# L1=0; L2=1;
# N = 100;
# dx = (L2-L1)/N;
# xnode = L1:dx:L2;
# cb = [1 0 -1;3 2 10];
# model.rho = 1; model.cp = 2;
# model.k = 2; model.c = 2;
# model.G = 75*ones(length(xnode),1); et = [0 -1 -1 -1];
# Tex = (-5/4)*exp(-(xnode+1))*(exp(xnode)-1)*(11*exp(xnode)+11-30*exp(1));
# T = difFinitas(xnode, model, cb, et);

# EJERCICIO 2.g
# L1=0; L2=1;
# N = 100;
# dx = (L2-L1)/N;
# xnode = L1:dx:L2;
# cb = [1 50 -1;2 5 -1];
# model.rho = 1; model.cp = 1;
# model.k = 2; model.c = -2;
# model.G = zeros(length(xnode),1); et = [0 -1 -1 -1];^
# Tex = 73.2433*sin(xnode)+50*cos(xnode);
# T = difFinitas(xnode, model, cb, et);

hold on
plot(xnode, Tex, 'r')
xlabel('x'); ylabel('Temp')
legend('Aproximada', 'Exacta')
