function [localC] = fem2d_heat_genC(nodes)
% Descripción: módulo para calcular y evaluar de forma numérica la matriz de
% masa C. Se utilizan funciones de forma en coordenadas naturales y se
% resuelve la integral de forma numérica utilizando cuadratura de Gauss.

% Entrada:
% * nodes: nodos (x,y) del elemento. Los elementos admisibles son de 3 o 4 nodos.

% Salida:
% * localC: matriz de masa para elemento (local).
% ----------------------------------------------------------------------
  n = size(nodes, 1);
  localC = zeros(n);

  if n == 3
    J = [ nodes(2, :) - nodes(1, :);...
          nodes(3, :) - nodes(1, :)];
    detJ = det(J);
    p = [0.5 0; 0 0.5; 0.5 0.5];
    w = 1/6;
    for i = 1:3
      s = p(i, 1);
      t = p(i, 2);
      N = [1-s-t; s; t];
      localC += w*(N*N')*detJ;
    endfor
  else
    xi = sqrt(3)/3;
    p = [-xi, xi];

    for i = 1:2
      for j = 1:2
        s = p(i);
        t = p(j);
        N = 0.25*[(1-s)*(1-t) (1+s)*(1-t)...
                  (1+s)*(1+t) (1-s)*(1+t)];
        Dnum = 0.25* [-(1-t) (1-t) (1+t) -(1+t);...
                      -(1-s) -(1+s) (1+s) (1-s)];
        J = Dnum*nodes;
        localC += N'*N*det(J);
      endfor
    endfor

  endif
endfunction





