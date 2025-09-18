function [localK] = fem2d_heat_genK(nodes,kx,ky)
% Descripción: módulo para calcular y evaluar de forma numérica la matriz de
% difusión K. Se utilizan funciones de forma en coordenadas naturales y se
% resuelve la integral de forma numérica utilizando cuadratura de Gauss.

% Entrada:
% * nodes: nodos (x,y) del elemento. Los elementos admisibles son de 3 o 4 nodos.
% * kx: conductividad térmica orientada en eje-x.
% * ky: conductividad térmica orientada en eje-y.

% Salida:
% * localK: matriz de difusión del elemento (local).
% ----------------------------------------------------------------------
  n = size(nodes, 1);
  localK = zeros(n);
  k = [kx 0; 0 ky];

  if n == 3
    J = [ nodes(2, :) - nodes(1, :);...
          nodes(3, :) - nodes(1, :)];
    detJ = det(J);
    invJ = [J(2, 2) -J(1, 2); -J(2, 1) J(1, 1)]/detJ;
    Be = invJ*[-1 1 0; -1 0 1];

    localK += 0.5* (Be'*k*Be)*detJ;

  else
    xi = sqrt(3)/3;
    p = [-xi, xi];
    for i = 1:2
      for j = 1:2
        s = p(i);
        t = p(j);
        dNi = 0.25*[ -(1-t) (1-t) (1+t) -(1+t);...
                -(1-s) -(1+s) (1+s) (1-s)];
        J = dNi*nodes;
        Be = J\dNi;%inv(J)*dNi;
        localK += (Be'*k*Be)*det(J);
      endfor
    endfor

  endif

end
