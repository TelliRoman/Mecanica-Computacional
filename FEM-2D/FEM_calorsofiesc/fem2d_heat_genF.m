function [localF] = fem2d_heat_genF(nodes,G)
% Descripción: módulo para calcular el vector de flujo térmico F para cada
% elemento, producto de la presencia de una fuente de calor en dicho elemento.
% La integral se resuelve mediante cuadratura de punto medio, y se requiere
% evaluar el área del elemento.

% Entrada:
% * nodes: nodos (x,y) del elemento. Los elementos admisibles son de 3 o 4 nodos.
% * G: fuente de calor.

% Salida:
% * localF: vector de flujo térmico (local).
% ----------------------------------------------------------------------

    n = size(nodes, 1);

    if n == 3
      Ae = 0.5*det([ones(3, 1), nodes]);
      localF = (Ae*G)*ones(3, 1)/3;
    else
      % Ni idea como se calcula el area de un cuadrangulo lol
      Ae1 = 0.5*det([ones(3, 1), nodes([1 2 3], :)]);
      Ae2 = 0.5*det([ones(3, 1), nodes([1 3 4], :)]);
      Ae = Ae1 + Ae2;
      localF = (Ae*G)*ones(4, 1)*0.25;
    endif

end
