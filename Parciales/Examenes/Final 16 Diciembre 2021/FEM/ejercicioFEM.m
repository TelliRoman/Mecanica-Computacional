c = 25;
k = 1e-3;
rhoCp = 1;
%Elemento 1
N1_e1 = @(x)(x-0.5)/(-0.5);
N2_e1 = @(x)(x)/(0.5);
%Elemento 2
N1_e2 = @(x)(x-1.25)/(-0.75);
N2_e2 = @(x)(x-0.5)/(0.75);

%MATRIZ DE TERMINO TEMPORAL Y MASA
B1 = [
    integral(@(x) N1_e1(x).^2,0,0.5)              integral(@(x) N1_e1(x).*N2_e1(x),0,0.5)
    integral(@(x) N1_e1(x).*N2_e1(x),0,0.5)     integral(@(x) N2_e1(x).^2,0,0.5)      
];

B2 = [
    integral(@(x) N1_e2(x).^2,0,0.5)              integral(@(x) N1_e2(x).*N2_e2(x),0,0.5)
    integral(@(x) N1_e2(x).*N2_e2(x),0,0.5)     integral(@(x) N2_e2(x).^2,0,0.5)
        
];

%Termino difusivo
K1 = k*[-2 1; 2 0]'*[-2 1; 2 0]*0.5;
K2 = k*[-1/-0.75 -1.25/-0.75; 1/0.75 -0.5/0.75]'*[-1/-0.75 -1.25/-0.75; 1/0.75 -0.5/0.75]*0.75;

%TODO JUNTO
%ELEMENTO 1:
deltaT1 = (K1-c*B1)/rhoCp*B1
%ELEMENTO 2:
deltaT2 =(K2-c*B2)/rhoCp*B2

