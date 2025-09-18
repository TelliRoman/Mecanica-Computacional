function [PHI_vec,Q_vec] = fem2d_heat_explicit(K,C,F,xnode,icone,model,dt)
% Descripción: módulo para resolver el sistema lineal de ecuaciones utilizando
% esquema temporal explícito.

% Entrada:
% * K: matriz del sistema (difusión + reacción).
% * C: matriz de masa del sistema (sin escalar por la constante de reacción).
% * F: vector de flujo térmico.
% * xnode: matriz de nodos con pares (x,y) representando las coordenadas de
%   cada nodo de la malla.
% * icone: matriz de conectividad. Indica los 3 ó 4 nodos que integran el
%   elemento, recorridos en cualquier orden pero en sentido antihorario.
%   En caso de elementos triangulares, la cuarta columna siempre es -1.
% * model: struct con todos los datos del modelo (constantes, esquema numérico, etc.)
% * dt: paso temporal crítico para método explícito.

% Salida:
% * PHI: matriz solución. Cada elemento del vector representa un valor
%   escalar asociado a cada nodo de la malla, y su posición dentro del vector
%   depende de cómo se especificó cada nodo en xnode. Cada columna representa
%   una iteración del esquema temporal (en total nit columnas).
% * Q: matriz de flujo de calor. Para cada nodo se halla un vector bidimensional
%   de flujo de calor, representado por un par (Qx,Qy). Cada par de columnas
%   representa una iteración del esquema temporal (en total 2×nit columnas).
% ----------------------------------------------------------------------
    
    PHI_now = PHI_next = model.PHI_n;
    PHI_vec = PHI_now;
    [Q_vec] = fem2d_heat_flux(xnode,icone,model,PHI_next);

    alpha = dt/(model.rho*model.cp);
    for i = 1:model.maxit
      PHI_next = C\(alpha*(F - K*PHI_now) + C*PHI_now);

      err = norm(PHI_next - PHI_now, 2)/norm(PHI_next, 2);
      % Actualizar
      PHI_now = PHI_next;
      PHI_vec = [PHI_vec PHI_next];
      Q = fem2d_heat_flux(xnode,icone,model,PHI_next);
      Q_vec = [Q_vec, Q];

      if err < model.tol
          disp(cstrcat("Metodo explicito terminado por tolerancia de error en ", ...
                num2str(i), " pasos. "));
          return;
      endif
    endfor
    disp("Metodo ha llegado su maxima iteracion.");

endfunction




