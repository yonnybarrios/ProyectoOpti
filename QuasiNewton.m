function [x0, Fx] = QuasiNewton(f, x0, dom, tol, maxIter, linearSearch, met, xy)
    % Función para ejecutar el algoritmo de Quasi-Newton.
    %{
        Parámetros de entrada:
            f: Función en formato string.
            x0: Punto inicial en forma de vector fila.
            dom: Dominio permitido (se sugiere [0, Inf] para Wolfe.)
            tol: Tolerancia aceptada.
            maxIter: Cantidad máxima de iteraciones.
            linearSearch: Tipo de búsqueda lineal como string;
                Bisección (Hay que adaptar).
                Wolfe.
            met: Cuasi-Newton a implementar - entero.
                (1) BFGS
                (2) DFP
            xy: Intervalos para la gráfica de la función objetivo.
    %}

    % Limpieza de la pantalla
    clc

    % Indicación del tipo de actualización de Cuasi-Newton a utilizar
    if (met == 1)
        fprintf('Actualización BFGS\n');
    else
        fprintf('Actualización DFP\n');
    end

    % Lectura de la función a optimizar
    [f, vf, fs] = ReadFunction(f);

    % Inicialización de variables
    point = [x0(1); x0(2)];
    Fx = fs(point);
    Gx = gradient(f, vf);
    syms x y;
    Gf = subs(Gx, {x, y}, {x0(1), x0(2)});
    l = 1;
    k = 0;

    % Inicialización de la matriz de actualización y el vector de gradiente
    Grade = Gx;
    Hmet = eye(length(vf));
    Gx = Gf;
    d = -Gf;

    % Inicio del ciclo iterativo
    while norm(Gf) >= tol && k < maxIter
        fprintf('%3.0f \t (%1.3f,%1.3f) \t %1.3f \t %3.3f \t %1.5f \n', k, x0(1), x0(2), l, norm(Gf), Fx)

        % Selección del método de búsqueda lineal
        switch linearSearch
            case 'Aurea'
                l = 1;
            case 'Biseccion'
                d2 = transpose(d);
                l = biseccion(f, vf, x0, d2, tol, maxIter);
            case 'Wolfe'
                l = Wolfe(f, x0, d, a, b, 1/3, maxIter);
        end

        % Cálculo del nuevo punto
        x1 = x0 + l * transpose(d);

        % Evaluación de la función y el gradiente en el nuevo punto
        Fx1 = fs(x1);
        Gx1 = subs(Grade, {x, y}, {x1(1), x1(2)});

        % Actualización de la matriz de actualización
        yk = Gx1 - Gx;
        s = (x1 - x0)';
        switch met
            case 1 % BFGS
                Hmet = Hmet + ((1 + (yk' * Hmet * yk) / (s' * yk))' * ((s' * s) / (s' * yk))) - (((s * yk' * Hmet) + (Hmet * yk * s')) / (s' * yk));
            case 2 % DFP
                Hmet = inv(Hmet + ((1 + (s' * Hmet * s) / (yk' * s))' * (yk' * yk) / (yk' * s)) - (((yk * s' * Hmet) + (Hmet * s * yk')) / (yk' * s)));
        end

        % Actualización de variables para la siguiente iteración
        x0 = x1;
        Fx = Fx1;
        Gx = Gx1;
        Gf = subs(Grade, {x, y}, {x1(1), x1(2)});
        k = k + 1;
        d = -Hmet * Gf;

        % Graficación de los puntos
        plot3(x0(1), x0(2), Fx, 'o');
    end

    % Generación de la gráfica de la función objetivo
    graph = graphf(f, xy(1), xy(2), point, x0);

    % Creación de una tabla de resultados
    fig = figure;
    fig.Name = 'Tabla del método Cuasi-Newton';
    uiTable = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', '||g(x)||', 'f(x)'});
    drawnow;
    set(uiTable, 'Data', table);

    % Mensajes finales con el punto óptimo y el valor óptimo de la función
    msgbox(['El punto óptimo x* es: ', num2str(double(x0))])
    msgbox(['Y el valor óptimo es: f(x*) : ', num2str(double(subs(f, vf, x0)))])
end
