function [PHI,Q] = fem2d_heat(xnode,icone,DIR,NEU,ROB,PUN,model)
    % Inicialización de las variables principales del Sistema
    [K,C,F] = fem2d_heat_initialize(model.nnodes);

    % Ensamble de las matrices y vectores del sitema
    [K,C,F] = fem2d_heat_gen_system(K,C,F,xnode,icone,model);
% ======================[ display ]=====================
    Faux = F;
% ======================[ end_disp ]=====================

    % Ensamble de nodos frontera Neumann
    [F] = fem2d_heat_neumann(F,NEU,xnode);
% ======================[ display ]=====================
    disp("F de NEUMANN"); % Es Fg - Fq, eso hace que el signo se invierte
    Faux = Faux - F
    disp("F despues de NEUMANN");
    F

    Kaux = K;
    Faux = F;
% ======================[ end_disp ]=====================

    % Ensamble de nodos frontera Robin
    [K,F] = fem2d_heat_robin(K,F,ROB,xnode);
% ======================[ display ]=====================
    disp("K de ROBIN");
    full(K-Kaux)
    disp("K despues de ROBIN");
    full(K)

    disp("F de ROBIN");
    Faux = F - Faux
    disp("F despues de ROBIN");
    F
% ======================[ end_disp ]=====================

    % Ensamble de nodos con fuentes puntuales
    [F] = fem2d_heat_pcond(F,xnode,icone,PUN);

    % Ensamble de nodos frontera Dirichlet
    [K,F] = fem2d_heat_dirichlet(K,F,DIR);

    % Resolución del sistema lineal de ecuaciones
    [PHI,Q] = fem2d_heat_solve(K,C,F,xnode,icone,model);
end
