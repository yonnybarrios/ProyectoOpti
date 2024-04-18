function [f, vf, Fx] = ReadFunction(f)
    % Función para dar formato a una función.
    %{
        Parámetros de entrada:
            f: Función escrita en tipo string. Ejemplo: 'x^2+y^2+1'
        Salidas:
            f: Función en formato simbólico.
            vf: Variables de la función en vector fila. Ejemplo: [x y]
            Fx: Función en formato de función anónima. Ejemplo: @(x) x(1)^2+x(2)^2+1
    %}
    fs = f;    
    Fx = strrep(fs, 'x', 'x(1)');
    Fx = strrep(Fx, 'y', 'x(2)');
    Fx = strcat('@(x)', Fx);
    Fx = str2func(Fx);
    f = str2sym(fs);
    vf = symvar(f);
end
