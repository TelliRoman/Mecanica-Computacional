function [K,F] = fdm2d_dirichlet(K,F,DIR)
  M = size(DIR,1);
  for i=1 : M
    p = DIR(i,1);
    temp = DIR(i,2);
    K(p,:)=0;
    K(p,p) = 1;
    F(p)=temp;
  endfor

