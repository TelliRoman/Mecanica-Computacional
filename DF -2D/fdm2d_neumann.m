function [F] = fdm2d_neumann(F,xnode,neighb,NEU)
  M = size(NEU,1);
  for n=1 :M
    P = NEU(n,1); #Centro
    S = neighb(P,1); #Vecino sur
    E = neighb(P,2);
    N = neighb(P,3);
    W = neighb(P,4);

    q = NEU(n,2); #Calor impuesto
    if E == -1 #Si es frontera este
      dx = abs(xnode(W,1) - xnode(P,1)); #dx es la dif entre el punto a la izq y el punto en el q estoy
    endif
    if NEU(n,3) == 2 #Si la condicion neuman esta apuntando para el lado este
      F(P) = F(P) - 2* q/dx;
    endif
    if W == -1
      dx = abs(xnode(E,1) - xnode(P,1));
    endif
    if NEU(n,3) == 4
      F(P) = F(P) - 2 * q/dx;
    endif
    if N == -1
      dy = abs(xnode(S,2) - xnode(P,2));
    endif
    if NEU(n,3) == 3
      F(P) = F(P) - 2* q/dy;
    endif
    if S==-1
      dy = abs(xnode(N,2) - xnode(P,2));
    endif
    if NEU(n,3) == 1
      F(P) += -2* q/dy;
    endif
  endfor

