function x0 = Newton(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy)
    % Función para ejecutar el algoritmo de Newton.
    %{
        Parámetros de entrada:
            fx: Función en formato string.
            initial: Punto inicial en forma de vector fila.
            tolerance: Tolerancia aceptada.
            maxIter: Cantidad máxima de iteraciones.
            busquedaLineal: Tipo de búsqueda lineal como string;
                Aurea
                Wolfe.
                Biseccion
            xx: Intervalo del eje x en forma de vector fila.
            yy: Intervalo del eje y en forma de vector fila.
    %}

    % Declaración de variables simbólicas
    syms x y;

    % Conversión de la función de formato string a función simbólica
    f = str2sym(fx);
    var = symvar(f); % Extracción de las variables de la función

    % Inicialización de variables
    x0 = initial;
    xi = x0;
    tol = tolerance;
    alfa = 1;
    a = 0;
    b = inf;
    k = 0;

    % Cálculo y evaluación del gradiente y la matriz Hessiana en el punto inicial
    gradientf_k = gradientef(f, var, x0);
    hessianf_k = hessianof(f, var, x0);

    % Verificación de la convergencia inicial
    if norm(gradientf_k) == 0
        foptimal = subs(f, var, x0); % Evaluación del punto inicial en la función
        fprintf('\nel punto optimo es el punto inicial: (%1.3f,%1.3f) \n', x0(1), x0(2));
        fprintf('\nel valor optimo es %1.3f \n', foptimal);
    else
        % Inicio del ciclo iterativo
        while norm(gradientf_k, 'inf') >= tol && k <= maxIter
            % Cálculo de la dirección de descenso
            d = -hessianf_k \ gradientf_k;

            % Selección del método de búsqueda lineal
            switch busquedaLineal
                case 'Aurea'
                    alfa = 1;
                case 'Biseccion'
                    d2 = transpose(d);
                    alfa = biseccion(f, var, x0, d2, tol, maxIter);
                case 'Wolfe'
                    alfa = Wolfe(f, x0, d, a, b, tol, maxIter);
            end

            % Actualización del punto actual
            x1 = transpose(x0) + alfa * d;
            x0 = transpose(x1);

            % Actualización del gradiente y la matriz Hessiana en el nuevo punto
            gradientf_k = gradientef(f, var, x0);
            hessianf_k = hessianof(f, var, x0);

            % Incremento del contador de iteraciones
            k = k + 1;
        end

        % Evaluación del punto óptimo y su valor
        foptimal = subs(f, var, x0);
        fprintf('\nel punto optimo es (%1.3f,%1.3f) \n', x0(1), x0(2));
        fprintf('\nel valor optimo es %1.3f \n', foptimal);
    end

    % Generación de la gráfica de la función objetivo
    graph = graphf(f, xx, yy, xi, x0);

    % Creación de una tabla de resultados
    f = figure;
    t = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', 'd1', 'd2'});
    drawnow;
    set(t, 'Data', table);

    % Mensajes con el punto óptimo y el valor óptimo de la función
    msgbox(['El punto óptimo x* es: ', num2str(double(x0))])
    msgbox(['Y el valor óptimo es: f(x*) : ', num2str(double(subs(str2sym(fx), var, x0)))])
end
