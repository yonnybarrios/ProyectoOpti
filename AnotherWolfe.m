function [xn, fval] = AnotherWolfe(f, x0, a, b, tol, maxIter)
    % Implementación del método de Wolfe alternativo para optimización.
    %{
        Parámetros de entrada:
            f:      Función objetivo a optimizar, en formato simbólico.
            x0:     Vector inicial desde donde se inicia la búsqueda, en formato fila.
            a:      Límite inferior para la búsqueda.
            b:      Límite superior para la búsqueda.
            tol:    Tolerancia para la convergencia del algoritmo.
            maxIter: Número máximo de iteraciones permitidas.
    %}

    % Definición de variables simbólicas para el cálculo del gradiente
    syms x y z;
    xn = x0; % Inicialización del punto de inicio
    
    % Cálculo del gradiente de la función objetivo en el punto inicial
    g = gradient(f, [x y]);
    gx = subs(g,{x,y},{xn(1),xn(2)});
    
    % Definición de constantes para las condiciones de Wolfe
    c1 = 1e-4;
    c2 = 0.9;

    % Inicialización del contador de iteraciones
    iter = 0;

    % Bucle principal del algoritmo
    while iter < maxIter && norm(gx) > tol
        % Inicialización del tamaño del paso
        alpha = 1;

        % Cálculo de la dirección de descenso
        p = -gx;

        % Cálculo del nuevo punto de evaluación
        x1 = xn + alpha * p;

        % Evaluación de la función objetivo en los puntos actual y nuevo
        fxn = subs(f,{x,y},{xn(1),xn(2)});
        fx1 = subs(f,{x,y},{x1(1),x1(2)});

        % Verificación de la condición de Armijo
        if fxn - fx1 >= c1 * alpha * dot(gx, p)
            % Cálculo del gradiente en el nuevo punto
            gx1 = g(x1);

            % Verificación de la condición de Wolfe
            if dot(gx1, p) >= c2 * dot(gx, p)
                % Si ambas condiciones se cumplen, se acepta el nuevo punto
                xn = x1;
                gx = gx1;
                break;
            else
                % Si no se cumple la condición de Wolfe, se reduce el tamaño del paso
                alpha = alpha * b;
                x1 = xn + alpha * p;
                fx1 = subs(f,{x,y},{x1(1),x1(2)});
                gx1 = subs(g,{x,y},{x1(1),x1(2)});
            end
        else
            % Si no se cumple la condición de Armijo, se reduce el tamaño del paso
            alpha = alpha * b;
            x1 = xn + alpha * p;
            fx1 = subs(f,{x,y},{x1(1),x1(2)});
            gx1 = subs(g,{x,y},{x1(1),x1(2)});
        end

        % Actualización del punto de inicio y del gradiente
        xn = x1;
        gx = gx1;
        fval = fxn;

        % Incremento del contador de iteraciones
        iter = iter + 1;
        
        % Evaluación de la tolerancia
        if norm(gx) <= tol
            xn = x1;
            fval = fxn;
            break
        end
    end
    
end
