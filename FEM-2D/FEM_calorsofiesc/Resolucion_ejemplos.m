% ====================[ Ejemplo 1(EjercicioResuelto.pdf) ]======================
clear; clc;
xnode = [0 0; 0.5 0; 1 0; 0.25 0.433; 0.75 0.433; 0.5 0.866];
% Es re importante el orden de xnode, ya que gen_Be lo va a ocupar

% 2. Matriz elemento 2
nodes = xnode([4 2 5], :);

J = [ nodes(2, :) - nodes(1, :); ...
      nodes(3, :) - nodes(1, :)];

detJ = det(J);
xi = eta = 1; % no importa los valores, total son triangulos
Be = gen_Be_heat(nodes, xi, eta);

K2 = Be'*Be*detJ*0.5;

[localC] = fem2d_heat_genC(nodes);

% Area elemento
Ae = 0.5*det([ones(3, 1) nodes]);

% Temperatura nodal

Phi = [ 100;
        100;
        100;
        45.198;
        51.270;
        38.094] ;

% Vector flujo de elemneto 2
% es importante el orden, pues Be esta compuesto de este orden tambien

nodes = xnode([4 2 5], :);
xi = eta = 1; % no importa los valores, total son triangulos
Be = gen_Be_heat(nodes, xi, eta);
flux = Be*Phi([4 2 5]);

% estaba cambiado del orden, y me daba iguales resultados
nodes = xnode([2 5 4], :);
xi = eta = 1; % no importa los valores, total son triangulos
Be = gen_Be_heat(nodes, xi, eta);
flux = Be*Phi([2 5 4]);

N = blerp_cartes(nodes, 0.5, 0.5);







