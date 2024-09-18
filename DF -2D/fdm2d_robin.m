function [K,F] = fdm2d_robin(K,F,xnode,neighb,ROB)
  M = size(ROB,1);
  for n=1 : M
    P=ROB(n,1);
    S = neighb(P,1); #Vecino sur
    E = neighb(P,2);
    N = neighb(P,3);
    W = neighb(P,4);

    h = ROB(n,2);
    phiinf = ROB(n,3);

    if ROB(n,4) == 1 #Flujo en sentido sur
      dy = abs(xnode(N,2) - xnode(P,2));
      F(P) = F(P) + h*2*phiinf / dy;
      K(P,P) = K(P,P) + 2*h/dy;
    endif
    if ROB(n,4) == 2 #Flujo en sentido este
      dx = abs(xnode(W,1) - xnode(P,1));
      F(P) = F(P) + h*2*phiinf / dx;
      K(P,P) = K(P,P) + 2*h/dx;
    endif
    if ROB(n,4) == 3 #Flujo en sentido norte
      dy = abs(xnode(S,2) - xnode(P,2));
      F(P) = F(P) + h*2*phiinf / dy;
      K(P,P) = K(P,P) + 2*h/dy;
    endif
    if ROB(n,4) == 4 #Flujo en sentido Oeste
      dx = abs(xnode(E,1) - xnode(P,1));
      F(P) = F(P) + h*2*phiinf / dx;
      K(P,P) = K(P,P) + 2*h/dx;
    endif
  endfor

