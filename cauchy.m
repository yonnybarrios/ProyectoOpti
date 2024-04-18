function point = cauchy(fx, initial, tolerance, maxIter, bl, xx, yy)
    % Implementación del método de Cauchy para la optimización de funciones.
    %{
        Parámetros de entrada:
            fx:         Función objetivo a optimizar, en formato string.
            initial:    Punto inicial desde donde se inicia la búsqueda, en formato vector columna.
            tolerance: Tolerancia para la convergencia del algoritmo, en formato float.
            maxIter:    Número máximo de iteraciones permitidas, en formato int.
            bl:         Método de búsqueda de alpha ('Despeje', 'Bisección', 'Wolfe').
            xx, yy:     Intervalos para la gráfica de la función objetivo.
    %}

    syms('z');
    dom = [0, Inf]; % Dominio para aplicar Wolfe
    do = true; % Bandera para controlar el bucle
    sf = str2sym(fx); % Convierte la función en formato string a simbólico
    variables = symvar(sf); % Obtiene las variables de la función
    grad = gradient(sf, variables); % Calcula el gradiente de la función
    point = initial; % Inicializa el punto actual
    iter = 0; % Inicializa el contador de iteraciones

    while do
        x = point(1); % Extrae la coordenada X del punto actual
        y = point(2); % Extrae la coordenada Y del punto actual
        Fgrad = [subs(grad(1)); subs(grad(2))]; % Evalúa el gradiente en el punto actual
        d = -Fgrad; % Calcula la dirección de descenso

        % Verifica las condiciones de parada
        if norm(Fgrad) == 0
            fprintf('¡Punto Obtenido!')
            break
        elseif norm(Fgrad) <= tolerance
            break
        elseif iter >= maxIter
            break
        else
            % Busqueda del valor de alpha utilizando el método especificado
            switch bl
                case 'Despeje'
                    alpha = solve(diff(sf), z); % Despeje de la variable alpha
                case 'Bisección'
                    alpha = biseccion(sf, variables, transpose(point), transpose(d), tolerance, maxIter + 10);
                case 'Wolfe'
                    a = dom(1);
                    b = dom(2);
                    alpha = Wolfe(sf, transpose(point), d, a, b, tolerance, maxIter + 10);
                otherwise
                    alpha = solve(diff(sf), z); % Despeje de la variable alpha
            end

            % Actualiza el punto actual
            S = point + (alpha * d);
            point = S;
        end

        % Construcción de la tabla de iteraciones
        fila = [iter, double(transpose(point)), double(alpha), double(transpose(d))];
        if iter == 0
            table = fila;
        else
            table = [table; fila];
        end
        iter = iter + 1; % Incrementa el contador de iteraciones
    end

    % Generación de la gráfica de la función objetivo
    graph = graphf(sf, xx, yy, transpose(initial), transpose(point));
    tab = TableBuilder(table);

    % Mensajes con el punto óptimo y el valor óptimo de la función
    msgbox(['El punto óptimo x* es: ', num2str(double(transpose(point)))])
    msgbox(['Y el valor óptimo es: f(x*)    : ', num2str(double(subs(sf, variables, transpose(point))))])
end
