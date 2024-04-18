function [min_x, min_f] = Aurea(f, x0, tol, maxIter)
    % Implementación del método de la Sección Áurea para la optimización de funciones.
    %{
        Parámetros de entrada:
            f:      Función objetivo a optimizar, en formato simbólico.
            x0:     Punto inicial desde donde se inicia la búsqueda, en formato fila.
            tol:    Tolerancia para la convergencia del algoritmo.
            maxIter: Número máximo de iteraciones permitidas.
    %}

    % Inicialización de variables para el método de la Sección Áurea
    ak = x0(1);
    bk = x0(2);
    alpha = 0.618;
    lamdak = alpha*ak + (1-alpha)*bk;
    miuk = (1-alpha)*ak + alpha*bk;

    fl = f(lamdak);
    fm = f(miuk);

    iter = 0;

    % Bucle principal del método de la Sección Áurea
    while abs(bk - ak) >= tol && iter <= maxIter
        iter = iter + 1;
        
        if fl > fm
            ak = lamdak;
            lamdak = miuk;
            fl = fm;
            miuk = (1-alpha)*ak + alpha*bk;
            fm = f(miuk);
        elseif fl < fm
            bk = miuk;
            miuk = lamdak;
            fm = fl;
            lamdak = alpha*ak + (1-alpha)*bk;
            fl = f(lamdak);
        end
    end

    % Retorna el valor mínimo encontrado y su correspondiente x
    min_x = (ak + bk) / 2;
    min_f = f(min_x);
end
