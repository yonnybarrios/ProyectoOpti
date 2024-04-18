function c = biseccion(f, var, x0, d2, tol, maxIter)
    % Implementación del método de bisección para la optimización de funciones.
    %{
        Parámetros de entrada:
            f:      Función objetivo a optimizar, en formato simbólico.
            var:    Variables de la función en forma de vector fila [x y].
            x0:     Punto inicial desde donde se inicia la búsqueda, en formato fila.
            d2:     Dirección de descenso en forma de vector.
            tol:    Tolerancia para la convergencia del algoritmo.
            maxIter: Número máximo de iteraciones permitidas.
    %}

    % Inicialización de variables para el método de bisección
    k = 0; % Contador de iteraciones
    a = 0; % Extremo inferior del intervalo
    b = 1; % Extremo superior del intervalo

    % Bucle principal del método de bisección
    while abs(b - a) >= tol && k <= maxIter
        % Cálculo del punto medio del intervalo [a, b]
        c = (a + b) / 2;

        % Cálculo del punto de evaluación en el intervalo [a, b]
        cal = x0 + c * d2;

        % Cálculo del gradiente de la función en el punto cal
        gradientf_k = gradientef(f, var, cal);

        % Cálculo de la dirección de descenso por el gradiente en el punto cal
        cond = d2 * gradientf_k;

        % Redefinición del intervalo basada en la condición calculada
        if cond > 0
            b = c; % Si la condición es positiva, redefinimos el extremo superior
        elseif cond < 0
            a = c; % Si la condición es negativa, redefinimos el extremo inferior
        end

        % Incremento del contador de iteraciones
        k = k + 1;
    end

end
