function [F] = fem2d_heat_neumann(F,NEU,xnode)
% Descripción: módulo para calcular y ensamblar las contribuciones de nodos
% pertenecientes a fronteras de tipo Neumann.

% Entrada:
% * F: vector de flujo térmico.
% * NEU: matriz con la información sobre la frontera de tipo Neumann.
%   - Columnas 1-2: dos nodos contiguos formando un lado de un elemento.
%   - Columna 3: valor de flujo térmico (q) asociado al lado del elemento.
% * xnode: matriz de nodos con pares (x,y) representando las coordenadas de
%   cada nodo de la malla.

% Salida:
% * F: vector de flujo térmico. Presenta modificaciones luego de aplicar la condición de borde.
% ----------------------------------------------------------------------
  for e = 1:size(NEU, 1)
    nodos = NEU(e, [1 2]);
    dij = norm(xnode(nodos(1), :) - xnode(nodos(2), :));
    F(nodos) -= 0.5*NEU(e, 3)*dij;
  endfor
end
