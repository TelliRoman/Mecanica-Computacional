function N = blerp_cartes(nodos, xp, yp)
  A = det([ones(3, 1) nodos])*0.5;
  idx = [2 3 1 2];
  a = b = c = zeros(3, 1);
  for i = 1:3
    j = idx(i);
    k = idx(i+1);
    a(i) = det(nodos([j k], :)); % /(2*A)
    b(i) = (nodos(j, 2) - nodos(k, 2)); % /(2*A)
    c(i) = (nodos(k, 1) - nodos(j, 1)); % /(2*A)
  endfor
  Ni = [a b c]/(2*A);
  printf("  [   a   |   b   |   c   ]")
  Ni
  N = Ni*[1 xp yp]';

endfunction

