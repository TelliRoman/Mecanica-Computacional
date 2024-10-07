% Resolucion de un problema de conduccion de calor por FEM
% COORDENADAS CARTESIANAS - Funciones de forma lineales
% PDE a resolver: k*(d2T_dx2) + G = 0
% Cond. de borde Dirichlet: T(0) = Ti; T(1) = Td
% Parametros de entrada: 
%   xnode: conjuntos de nodos
%   sp: bandera para trabajar o no con matrices sparse
%       sp != 0 --> matriz sparse
%       sp == 0 --> matriz llena
%   k: difusion; G: fuente; Ti: temp a izquierda; Td: temp a derecha
function [T] = FuncLineales(xnode,sp,k,G,Ti,Td)
    % Cantidad de nodos y elementos
    Nnod = length(xnode);
    Nelem = Nnod - 1;
            
    % Derivadas de funciones de forma para cada elemento 
    dN_dx = @(h)[-1/h,1/h];

    Kele = zeros(Nelem,2,2);
    fele = zeros(Nelem,2);
    % Calculo de cada elemento: matriz y termino derecho
    for ele=1:Nelem
        h = xnode(ele+1)-xnode(ele);
        Kele(ele,:,:) = (k*h)*(dN_dx(h)'*dN_dx(h));
        fele(ele,:) = G*(h/2);
    end
    
    if sp
        rows = [];
        cols = [];
        coef = [];
    else
        Kg = zeros(Nnod,Nnod);
    end
    fg = zeros(Nnod,1);
    for ele=1:Nelem
        in_gl = [ele ele+1];
        if sp
            for il=1:2
                ig = in_gl(il);
                for jl=1:2
                    jg = in_gl(jl);
                    rows = [rows;ig];
                    cols = [cols;jg];    
                    coef = [coef;Kele(ele,il,jl)];
                end
            end
            Kg = sparse(rows,cols,coef);
            fg(in_gl) = fg(in_gl) + fele(ele,:)';
        else
            Klocal = reshape(Kele(ele,:,:),2,2);
            Kg(in_gl,in_gl) = Kg(in_gl,in_gl) + Klocal;
            fg(in_gl) = fg(in_gl) + fele(ele,:)';
        end
    end

    % CB Dirichlet
    % x = 0
    Kg(1,:) = 0;
    Kg(1,1) = 1;
    fg(1) = Ti;
    % x = 1
    Kg(Nnod,:) = 0;
    Kg(Nnod,Nnod) = 1;
    fg(Nnod) = Td;

    % Resolucion del sist. de ecuaciones
    T = Kg\fg;
    
    % Grafica de comparacion: analitica vs FEM
    aux = G/(2*k);
    a = Td-Ti+aux;
    xref=0:0.01:1;
    T_an = (-aux)*(xref.^2)+a*xref+Ti;
    figure(1);clf;plot(xnode,T,'o-',xref,T_an,'r');   
end
