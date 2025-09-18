% Nodos del elemento
xnode = [ 0.1 0.1;
          0.2 0.2;
          0.0 0.21
        ];
% Desplazamientos en cada nodo
d = 1e-6.*[0.1,0.1,-0.2, 0.1,0.1,-0.2]';
%Datos
E = 180*1e9;
poiss = 0.3;
%Tension plana
D = tension(E,poiss,1);
% Trabajomos con coordenadas isoparamétricas
dnphi = [-1 1 0; 
        -1 0 1];  

J = dnphi*xnode;

v = inv(J)*dnphi;
    
Bs = [
        v(1,1)   0  v(1,2) 0 v(1,3) 0;
            0   v(2,1)  0   v(2,2) 0 v(2,3);
        v(2,1) v(1,1) v(2,2) v(1,2) v(2,3) v(1,3)
];


e = Bs*d
t = D*e