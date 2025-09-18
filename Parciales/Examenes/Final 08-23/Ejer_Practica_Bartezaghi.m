#En primer lugar debemos generar funciones de forma que valgan 1 en el nodo y 0 en los demas nodos.
#Tenemos 3 puntos, generamos 3 funciones de forma.

#Usaremos funciones de forma lineales: Ni = ai*x + bi*y + ci
#A partir de las coordenadas de los nodos podemos generar las funciones de forma planteando un sistema
#que busque los valores de a,b y c que cumplan con la condicion de valer 1 en un nodo y 0 en los demas nodos


#Coordenadas de los puntos del triangulo
a = [0.2, 0.3];
b = [0.7, 0.4];
c = [0.5, 0.6];


#Calculamos coeficiente a,b,c para cada funcion de forma

# coeficientes funcion de forma nodo a
M = [b(1), b(2), 1; c(1), c(2), 1; a(1), a(2), 1];
coef_1 = M \ [0; 0; 1];

#coeficientes funcion de forma nodo b
M = [a(1), a(2), 1; c(1), c(2), 1; b(1), b(2), 1];
coef_2 = M \ [0; 0; 1];

#coeficientes funcion de forma nodo c
M = [a(1), a(2), 1; b(1), b(2), 1; c(1), c(2), 1];
coef_3 = M \ [0; 0; 1];


#Armamos las funciones de forma
N1 = @(x, y) coef_1(1) * x + coef_1(2) * y + coef_1(3);
N2 = @(x, y) coef_2(1) * x + coef_2(2) * y + coef_2(3);
N3 = @(x, y) coef_3(1) * x + coef_3(2) * y + coef_3(3);


#Para calcular el desplazamiento en un punto dentro del triangulo podemos interpolar
#utilizando las funciones de forma y los valores de desplazamientos en los nodos.

Ux = [0.1,0,0.2]*10^(-3);  #desplazamiento de x en metros
Uy = [0.2,0.1,0.4]*10^(-3); #desplazamiento de y en metros

#Punto a interpolar
xp = 0.6
yp = 0.5

Despl_px = Ux(1)*N1(xp,yp) + Ux(2)*N2(xp,yp) + Ux(3)*N3(xp,yp)
Despl_py = Uy(1)*N1(xp,yp) + Uy(2)*N2(xp,yp) + Uy(3)*N3(xp,yp)


#El vector de deformacion se puede obtener a partir de derivar las funciones de forma
#y multiplicar por los desplazamientos correspondientes.

#Calculo derivadas. Resulta en un solo coeficiente.
dN1x = coef_1(1);
dN2x = coef_2(1);
dN3x = coef_3(1);

dN1y = coef_1(2);
dN2y = coef_2(2);
dN3y = coef_3(2);


Ex = [dN1x*Ux(1) + dN2x*Ux(2) + dN3x*Ux(3)]
Ey = [dN1y*Uy(1) + dN2y*Uy(2) + dN3y*Uy(3)]
Exy = [dN1y*Ux(1) + dN2y*Ux(2) + dN3y*Ux(3) + dN1x*Uy(1) + dN2x*Uy(2) + dN3x*Uy(3)]

E = [Ex; Ey; Exy] #Vecto de deformaciones

#Debido a que las derivadas no dependen de x ni de y, el vector de deformaciones es el mismo para cualquier
#punto dentro del elemento. Lo mismo sucede con el vector de tensiones, ya que se calcula a partir de valores
#del vector de deformaciones y otros coeficientes.





