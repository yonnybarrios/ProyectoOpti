function Fhessian = hessianof(f, var, x0)
    % Función para calcular la matriz Hessiana de una función en un punto específico.
    %{
        Parámetros de entrada:
            f:          Función en formato string.
            var:        Variables de la función en forma de vector fila [x y].
            x0:         Punto inicial en forma de vector fila.

        Salida:
            Fhessian: La matriz Hessiana evaluada en el punto.
    %}

    h = hessian(f, var); % Calcula la matriz Hessiana de la función

    n = numel(var); % Obtiene el número de variables

    Fhessian = zeros(n, n); % Inicializa una matriz para almacenar la matriz Hessiana evaluada en el punto

    % Ciclo para calcular la matriz Hessiana evaluada en el punto para cada par de variables
    for i = 1:n
        for j = 1:n
            fun = h(i, j); % Obtiene el elemento (i, j) de la matriz Hessiana
            Fhessian(i, j) = subs(fun, var, x0); % Evalúa el elemento en el punto x0
        end
    end

end
