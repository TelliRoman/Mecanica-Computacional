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
  f1 = f(p);  #
  f2 = f(p+dx(i));
  f3 = f(p+2*dx(i));
  f4 = f(p+3*dx(i));
  der2 = (2*f1-5*f2+4*f3-f4)/(dx(i)*dx(i)); #Aproximacion de la derivada segunda
  Der2 = [Der2 der2];  #Vector con los valores de la derivada segunda en el punto p
end



#Analitica
Der2_analitica = [];
#d2f = @(x) -3/2 * x * e^(-0.25 * x^3) + 9/16 * x^5 * e^(-0.25 * x^3);
d2f = @(x) e^(-0.25*x^3)*(-1.5*x + 0.5625*x^4);

for i=1:length(dx)
  Der2_analitica = [Der2_analitica d2f(p)];  #Generamos un vector con los valores de la derivada analitica
end
#df = @(x) e^(-0.25*x^3)*(-3*0.25*x^2);

error = sqrt((Der2_analitica-Der2).^2);  #Calculamos el error entre la derivada aproximada y la analitica

plot(log(dx),log(error))  #Vemos la evolucion del error a medida que se redujo el espacio entre nodos.
xlabel('log(dx)')
ylabel('log(error)')
hold on
x = linspace(-10, 3, 100); # Rango de valores de x
y = 2*(x+3) - 8;       # Ecuación de la recta
plot(x, y);

#Para calcular el orden del error se debe plantear:
#Que el error de aproximacion sea de orden p, es equivalente a:
#E = C*dx^p --> log E = log C + p*log(dx)
#Lo que es la ecuacion de una recta de la forma y = a*x + b
#Sabemos que el orden de aproximacion de la derivada utilizada en este caso es de orden 2,
#Por lo que se debe cumplir que: log E = log C + 2log(dx).
#Esto se puede ver graficamente al comparar con una recta con pendiente 2

#Otra forma de obtener la pendiente y por ende el orden
#p = (y2-y1)/(x2-x1) -->
p = (log(error(6))-log(error(5)))/(log(dx(6))-log(dx(5)))


taylorDF([0,1,2,3],2)




