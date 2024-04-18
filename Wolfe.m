function t = Wolfe(f, x0, d, a, b, tol, maxIter)
    % Función para evaluar las condiciones de Wolfe.
    %{
        Parámetros de entrada:
            f: Función. Ejemplo: @(x,y) sin(x)+cos(y) - sym
            x0: Punto inicial en forma de vector fila.
            d: Dirección de descenso.
            a: Extremo inferior (Alpha). Se sugiere 0.
            b: Extremo superior (Beta). Se sugiere Inf.
            tol: Tolerancia aceptada.
            maxIter: Cantidad máxima de iteraciones.
        Salidas:
            t: Punto óptimo para minimizar la función.
    %}

    % Declaración de variables simbólicas
    syms x y;

    % Inicialización de variables
    k = 0;
    c1 = 0.5;
    c2 = 0.75;
    alpha = a;
    beta = b;
    t = 1;

    % Cálculo del gradiente de la función y su transpuesta
    grad = gradient(f, symvar(f));
    gtrasp = transpose(grad);

    % Inicio del ciclo iterativo
    while true
        % Evaluación de la función y su transpuesta en el punto actual
        fp = subs(f, {x,y}, {x0(1), x0(2)});
        gtp = subs(gtrasp, {x,y}, {x0(1), x0(2)});

        % Cálculo del punto siguiente
        ptd = x0 + t * d;

        % Evaluación de la función y su gradiente en el punto siguiente
        fnext = subs(f, {x,y}, {ptd(1), ptd(2)});
        gnext = subs(grad, {x,y}, {ptd(1), ptd(2)});

        % Evaluación de las condiciones de Wolfe
        if (fnext > (fp + (c1 * t * gtp * d)))
            beta = t;
            t = (1/2) * (alpha + beta);
        else
            if ((gnext' * d) < (c2 * gtp * d))
                alpha = t;
                if (beta == Inf)
                    t = 2 * alpha;
                else
                    t = (1/2) * (alpha + beta);
                end
            else
                t = double(t);
                break;
            end
        end

        % Actualización del contador de iteraciones
        k = k + 1;

        % Verificación de la tolerancia y el número máximo de iteraciones
        if (t < tol || k > maxIter)
            t = double(t);
            break;
        end

        x0 = ptd;
    end
end
