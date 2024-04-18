function output = ControllerNonLinear(fx, initial, maxIter, busquedaLineal, method, xx, yy)
    % Controlador para la ejecución de algoritmos de optimización no lineal.
    %{
        Parámetros de entrada:
            fx:             Función objetivo a optimizar, en formato string.
            initial:        Punto inicial desde donde se inicia la búsqueda, en formato vector columna. Ejemplo: [x; y].
            maxIter:        Número máximo de iteraciones permitidas para los algoritmos.
            busquedaLineal: Método de búsqueda no lineal a ejecutar, en formato string.
                                - Aurea
                                - Biseccion
                                - Wolfe
                               
            method:         Método de búsqueda lineal a utilizar, en formato string.
                                - Newton Puro
                                - Cauchy
                                - Casi newton - DFP
                                - Casi newton BFGS
            xx, yy:         Intervalos para la gráfica de la función objetivo.
    %}

    if ~isempty(fx)
        f = str2sym(fx); % Convierte la función en formato string a simbólico
        vf = symvar(f); % Obtiene las variables de la función
        if numel(vf) == 2
            dom = [0, Inf]; % Dominio para aplicar Wolfe
            tolerance = 1e-6; % Tolerancia para la convergencia
            switch method
                case "Cauchy"
                    cauchy(fx, initial, tolerance, maxIter, busquedaLineal, xx, yy);
                case "Newton Puro"
                    Newton(fx, transpose(initial), tolerance, maxIter, busquedaLineal, xx, yy);
                case "Casi newton DFP"
                    QuasiNewton(fx, transpose(initial), dom, tolerance, maxIter, busquedaLineal, 2, [xx, yy]);
                case "Casi newton BFGS"
                    QuasiNewton(fx, transpose(initial), dom, tolerance, maxIter, busquedaLineal, 1, [xx, yy]);
                otherwise
                    warndlg('Método de búsqueda lineal no reconocido', 'Error');
            end
        else
            warndlg('La función debe tener exactamente 2 variables independientes', 'Error');
        end
    else
        warndlg('Debe proporcionar una función objetivo', 'Error');
    end
end
