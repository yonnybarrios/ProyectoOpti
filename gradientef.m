function Fgrand = gradientef(f, var, x0)
    % Función para calcular el gradiente de una función en un punto específico.
    %{
        Parámetros de entrada:
            f:       Función en formato string.
            var:     Variables de la función en forma de vector fila [x y].
            x0:      Punto inicial en forma de vector fila.

        Salida:
            Fgrand: El gradiente evaluado en el punto.
    %}

    grad = gradient(f, var); % Calcula el gradiente de la función

    n = numel(var); % Obtiene el número de variables

    Fgrand = zeros(n, 1); % Inicializa una matriz para almacenar el gradiente evaluado en el punto

    % Ciclo para calcular el gradiente evaluado en el punto para cada variable
    for i = 1:n
        fun = grad(i, 1); % Obtiene la derivada parcial de la función para la variable i
        Fgrand(i, 1) = subs(fun, var, x0); % Evalúa la derivada parcial en el punto x0
    end

end
