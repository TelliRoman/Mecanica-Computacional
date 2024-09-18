function [K,F] = fdm2d_gen_system(K,F,xnode,neighb,k,c,G)
  N = size(xnode,1);
  for i=1 : N
    S = neighb(i,1);
    E = neighb(i,2);
    N = neighb(i,3);
    W = neighb(i,4);
    ds = 0; de = 0; dn = 0; dw = 0;
    if (E ~= -1)
    % Distancia entre P y E
        de = abs(xnode(E,1) - xnode(i,1));
    end
    if (S ~= -1)
        ds = abs(xnode(S,2) - xnode(i,2));
    end
    if (N ~= -1)
        dn = abs(xnode(N,2) - xnode(i,2));
    end
    if (W ~= -1)
        dw = abs(xnode(W,1) - xnode(i,1));
    end
    if E == -1 #
      ax = 0;
      bx = -2/ (dw*dw);
      cx= 2/ (dw*dw);
    elseif W == -1
      ax = 2 / (de*de);
      bx = -2/ (de*de);
      cx=0;
    else
      ax = 2/(de* (de+dw));
      bx = -2/(de*dw);
      cx = 2/(dw* (dw+de));
    endif

    if N == -1
      cy = 2/(ds*ds);
      by = -2/(ds*ds);
      ay=0;
    elseif S == -1
      ay = 2/(dn*dn);
      by = -2/(dn*dn);
      cy=0;
     else
       ay = 2/(dn * (ds+dn));
       by = -2/(ds * dn);
       cy = 2/(ds * (ds+dn));
     endif

     K(i,i) = c(i) - k(i)*bx - k(i)*by;
     F(i) = G(i);

     if E != -1
       K(i,E) = -k(i)*ax;
     endif
     if S != -1
       K(i,S) = -k(i)*cy;
     endif
     if W != -1
       K(i,W) = -k(i)*cx;
     endif
     if N != -1
       K(i,N) = -k(i)*ay;
     endif
  endfor

