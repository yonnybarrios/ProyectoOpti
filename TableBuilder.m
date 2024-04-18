function t = TableBuilder(table)
    % Función para dar formato a una tabla.
    %{
        Parámetros de entrada:
            table: Componente de tabla a la que se dará formato.
        Salidas:
            t: Componente de tabla con formato establecido.
    %}

    f = figure;
    t = uitable('ColumnName', {'iteración', 'x1', 'x2', 'alfa', 'd1', 'd2'});
    drawnow;
    % Establece las unidades de la tabla como porcentajes
    set(t, 'Units', 'normalized');
    % Define el nuevo tamaño de la tabla en porcentajes
    newPosition = [0 0 1 1];
    % Establece el nuevo tamaño de la tabla
    set(t, 'Position', newPosition);
    % Establece los datos
    set(t, 'Data', table);
end
