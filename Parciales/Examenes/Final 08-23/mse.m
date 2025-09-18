function ecm = error_cuadratico_medio(y_verdadero, y_estimado)
  % Asegurarse de que los vectores sean del mismo tamaño
  if length(y_verdadero) != length(y_estimado)
    error('Los vectores deben tener la misma longitud');
  end

  % Calcular la diferencia al cuadrado
  diferencia_cuadrada = (y_verdadero - y_estimado).^2;

  % Calcular el promedio de la diferencia al cuadrado
  ecm = mean(diferencia_cuadrada);
end

