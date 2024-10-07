f = @(x) exp(-x.^2);
d2f = @(x) exp(-x.^2) * (4*x^2 -2);
dx_izq = 1;
dx_der = dx_izq *1.1;
x_k = 0.5;
x_ki = x_k + dx_der;
x_kmenosi = x_k - dx_izq;
c = 2/(dx_izq*(dx_der+dx_izq));
b = 2/(dx_der*dx_izq);
a = 2/(dx_der*(dx_der+dx_izq));
disp('Deric Real')
d2real = d2f(x_k)
disp('Con paso inicial 0.1')
d2aprox = a * f(x_ki) - b *f(x_k) + c *f(x_kmenosi)
error1 = abs(d2real - d2aprox)
dx_izq = 0.5;
dx_der = dx_izq *1.1;
x_k = 0.5;
x_ki = x_k + dx_der;
x_kmenosi = x_k - dx_izq;
c = 2/(dx_izq*(dx_der+dx_izq));
b = 2/(dx_der*dx_izq);
a = 2/(dx_der*(dx_der+dx_izq));
disp('Con paso inicial 0.05')
d2aprox = a * f(x_ki) - b *f(x_k) + c *f(x_kmenosi)
error2 = abs(d2real - d2aprox)

