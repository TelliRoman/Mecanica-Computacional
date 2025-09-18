%Calculo de reacciones:
K = [ 
    cos(deg2rad(61.04)) -sin(deg2rad(43.43));
    sin(deg2rad(61.04)) cos(deg2rad(43.43));
];
F = [
        -363.09
        1343.75
    ];
R = K\F;

%barra 13
ten13 = R(1)*cos(deg2rad(61.04))+500*cos(deg2rad(43.43))*100/pi;

%barra 23
ten23 = @(x) (500*x-R(2)*sin(deg2rad(43.43)))/(pi/400);
