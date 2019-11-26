function [a_0 , a_1] = cuad_min(t_plot_shroeder,shroeder)
%   Inputs: 
%       t_plot_shroeder = Vector de valores en la abscisa x
%       shroeder = Vector de valores en la abscisa y
%   Outputs:
%       a_0 = Termino independiente de la regresión lineal
%       a_1 = Termino lineal de la regresión lineal
%
% Referencia: Clase sobre Cuadrados Minimos - Miryam Sassano

x_i = t_plot_shroeder ;
y_i = shroeder;

if size(x_i) ~= size(y_i)
    y_i = y_i';
end

A = ones(length(x_i),2) ;
A (:,2) = (x_i)';
B = (y_i)' ;
vector = ((inv((A')*A)*(A'))*B)' ;
a_0 = vector(1);
a_1 = vector(2);

end