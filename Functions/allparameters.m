%%  Parametros
function [EDT,T20,T30,C50,C80,D50] = allparameters(Ir,fm)
% allparameters
%   Calcula los tiempos de reverberacion según la norma ISO-3382
%   y los parámetros energéticos de Claridad (C80) y Definicion (D50).
%   Entradas:
%       Ir = Respuesta al impulso.
%       fm = Frecuencia de muestreo.
%   Salidas:
%       EDT = Early Decay Time en [s]
%       T20 = Parámetro T20 [s]
%       T30 = Parámetro T30 [s]
%       C80 = Claridad Musical Media (C80) [dB]
%       C50 = Claridad de la Voz (C50) [dB]
%       D50 = Definición de la voz (D50) [Porcentaje]

    [EDT,T20,T30] = tr(Ir,fm);
    [C50,C80,D50] = energeticos(Ir,fm);q
end

%%  Tiempos de reverberacion
function [EDT,T20,T30] = tr(Ir,fm)
%  Tiempos de Reverberación
%       Calcula los tiempos de reverberación T20, T30 y EDT 
%       según norma ISO 3382.

    x = 0:1/fm:(length(Ir)-1)/fm;
    Max = find(Ir == max(Ir),1);    %Pico maximo de Ir
    
    %% EDT
    y1EDT = Ir(Max);
    y2EDT = find(Ir<max(Ir)-10);
    y2EDT = y2EDT(y2EDT > Max);
    y2EDT = y2EDT(1);
    y2EDT = Ir(y2EDT);
    x1EDT = x(find(Ir == y1EDT));
    x2EDT = x(find(Ir == y2EDT));
    EDT = 6*(x2EDT - x1EDT)
    
    %% T20
    y1T20 = find(Ir<max(Ir)-5);
    y1T20 = y1T20(y1T20 > Max);
    y1T20 = y1T20(1);
    y1T20 = Ir(y1T20);
    y2T20 = find(Ir<max(Ir)-25);
    y2T20 = y2T20(y2T20 > Max);
    y2T20 = y2T20(1);
    y2T20 = Ir(y2T20);
    x1T20 = x(find(Ir == y1T20));
    x1T20 = x1T20(1);
    x2T20 = x(find(Ir == y2T20));
    x2T20 = x2T20(1);
    T20 = 3*(x2T20 - x1T20)

    %% T30
    y1T30 = find(Ir<max(Ir)-5);
    y1T30 = y1T30(y1T30 > Max);
    y1T30 = y1T30(1);
    y1T30 = Ir(y1T30);
    y2T30 = find(Ir<max(Ir)-35);
    y2T30 = y2T30(y2T30 > Max);
    y2T30 = y2T30(1);
    y2T30 = Ir(y2T30);
    x1T30 = x(find(Ir == y1T30));
    x1T30 = x1T30(1);
    x2T30 = x(find(Ir == y2T30));
    x2T30 = x2T30(1);
    T30 = 2*(x2T30 - x1T30)
end

%%  Parametros energeticos
%       Calcula los parámetros energéticos de claridad y definición
%       según ISO-3382. 
function [C50,C80,D50] = energeticos(Ir,fm)
%Parámetros Energéticos

    p = Ir.^2;              %Respuesta al Impulso al Cuadrado
    Ms50 = 0.05*fm;  %Redondeo a 50ms 
    Ms80 = 0.08*fm;  %Redondeo a 80ms
    
    C50 = 10*log10(trapz(p(1:Ms50))/trapz(p(Ms50:end)))  %C50
    C80 = 10*log10(trapz(p(1:Ms80))/trapz(p(Ms80:end)))  %C80
    D50 = (trapz(p(1:Ms50))/trapz(p(1:end)))*100         %D50
end

