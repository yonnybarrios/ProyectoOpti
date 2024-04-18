function graph = graphf(f, xx, yy, xi, x0)
    % Función para mostrar gráfica de una función de dos variables.
    %{
        Parámetros de entrada:
            f:      Función en formato simbólico. Ejemplo: @(x,y) sin(x)+cos(y).
            xx:     Intervalo del eje x en forma de vector fila.
            yy:     Intervalo del eje y en forma de vector fila.
            xi:     Punto inicial en forma de vector fila.
            x0:     Punto óptimo en forma de vector fila.
    %}

    % Calcula el dominio con los intervalos ingresados por parámetro
    domain = [xx yy];

    % Grafica la función en el dominio especificado
    graph = fsurf(f, domain);

    % Muestra el nombre de los ejes
    xlabel('Eje x');
    ylabel('Eje y');
    zlabel('Eje z');

    % Muestra el título de la gráfica con la función incluida
    fstr = string(f);
    title(['Función: ' fstr], 'FontSize', 12);

    % Muestra el contorno del cuadro alrededor de los ejes
    box on;

    % Permite rotar la gráfica
    rotate3d;

    % Muestra las líneas de cuadrícula para los ejes
    grid on;

    % Conserva la gráfica y permite graficar sobre ella los puntos
    hold on;

    % Grafica el punto inicial
    plot3(xi(1), xi(2), 0, 'o', 'MarkerFaceColor', [0.9290 0.6940 0.1250], 'MarkerSize', 12);

    % Grafica el punto óptimo
    plot3(x0(1), x0(2), 0, 'o', 'MarkerFaceColor', [0.6350 0.0780 0.1840]);

    % Muestra la leyenda de la gráfica
    legend('Función', 'Punto inicial', 'Punto óptimo', 'FontSize', 12);

    % Muestra el título de la leyenda
    title(legend, 'Leyenda', 'FontSize', 12);

end
