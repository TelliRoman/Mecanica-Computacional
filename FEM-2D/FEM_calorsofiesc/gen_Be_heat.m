% Rutina que se despeja la expresion de Be segun el parametro xi, eta dado
% donde el intervalo es xi = eta = [-1  1].
% Sirve mas que nada para el cuadrangulo, pues el triangulo Be es constante
function Be = gen_Be_heat(nodes, xi, eta)
  if size(nodes, 1) == 3
    J = [ nodes(2, :) - nodes(1, :); ...
          nodes(3, :) - nodes(1, :)];
    Be = J\[-1 1 0; -1 0 1];

  else
    % Generar la derivada segun el valor de xi y eta dado
    s = xi; t = eta;
    dNi = 0.25*[ -(1-t) (1-t) (1+t) -(1+t);...
                 -(1-s) -(1+s) (1+s) (1-s)];
    J = dNi*nodes;
    Be = J\dNi;%inv(J)*dNi;
  endif

endfunction
