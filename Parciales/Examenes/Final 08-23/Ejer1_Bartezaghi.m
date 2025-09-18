clc
clear all;
close all;

p = 0.1  #Punto a evaluar
dx=1  #Espacio entre nodos
#En cada iteracion reducimos dx en un factor de 2
for i=1:20
  dx = [dx dx(end)/2];
endfor


Der2 =[];
#Aproximacion
for i=1:length(dx)
  f=@(x) e^(-0.25*x.^3);  #Definimos la funcion analitica
  f1 = f(p-dx(i));  #Punto anterior en la malla
  f2 = f(p);
  f3 = f(p+dx(i));  #Punto posterior
  der2 = (f1-2*f2+f3)/(dx(i)*dx(i));  #Aproximacion centrada de la derivada segunda
  Der2 = [Der2 der2];  #Vector con los valores de la derivada segunda en el punto p
end

#Analitica
Der2_analitica = [];
d2f = @(x) -3/2 * x * exp(-0.25 * x^3) + 9/16 * x^5 * exp(-0.25 * x^3);
for i=1:length(dx)
  Der2_analitica = [Der2_analitica d2f(p)];  #Generamos un vector con los valores de la derivada analitica
end
#df = @(x) e^(-0.25*x^3)*(-3*0.25*x^2);

error = abs(Der2_analitica-Der2);  #Calculamos el error entre la derivada aproximada y la analitica

plot(error)  #Vemos la evolucion del error a medida que se redujo el espacio entre nodos.

#Para calcular el orden del error se debe plantear:
#log C + p*log (dx). Donde p determina el orden (en este caso debe ser p=2 --> orden dx^2)






