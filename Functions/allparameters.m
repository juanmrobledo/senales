%%  Parametros
function [EDT,T20,T30,C80,D50] = allparameters(Suavizado)
% allparameters
%   Calcula los tiempos de reverberacion seg�n la norma ISO-3382
%   y los par�metros energ�ticos de Claridad (C80) y Definicion (D50).
%   Entradas:
%       Ir = Respuesta al impulso.
%       fm = Frecuencia de muestreo.
%   Salidas:
%       EDT = Early Decay Time en [s]
%       T20 = Par�metro T20 [s]
%       T30 = Par�metro T30 [s]
%       C80 = Claridad Musical Media (C80) [dB]
%       C50 = Claridad de la Voz (C50) [dB]
%       D50 = Definici�n de la voz (D50) [Porcentaje]
    fm = 44100;
    [EDT,T20,T30] = tr(Suavizado,fm);
    [C80,D50] = energeticos(Suavizado,fm);
end

%%  Tiempos de reverberacion
function [EDT,T20,T30] = tr(Suavizado,fm)
%  Tiempos de Reverberaci�n
%       Calcula los tiempos de reverberaci�n T20, T30 y EDT 
%       seg�n norma ISO 3382.

    x = 0:1/fm:(length(Suavizado)-1)/fm;
    Max = find(Suavizado == max(Suavizado),1);    %Pico maximo de Ir
    
    %% EDT
    y1EDT = Suavizado(Max);
    y2EDT = find(Suavizado<max(Suavizado)-10);
    y2EDT = y2EDT(y2EDT > Max);
    y2EDT = y2EDT(1);
    y2EDT = Suavizado(y2EDT);
    x1EDT = x(find(Suavizado == y1EDT));
    x2EDT = x(find(Suavizado == y2EDT));
    EDT = 6*(x2EDT - x1EDT)
    
    %% T20
    y1T20 = find(Suavizado<max(Suavizado)-5);
    y1T20 = y1T20(y1T20 > Max);
    y1T20 = y1T20(1);
    y1T20 = Suavizado(y1T20);
    y2T20 = find(Suavizado<max(Suavizado)-25);
    y2T20 = y2T20(y2T20 > Max);
    y2T20 = y2T20(1);
    y2T20 = Suavizado(y2T20);
    x1T20 = x(find(Suavizado == y1T20));
    x1T20 = x1T20(1);
    x2T20 = x(find(Suavizado == y2T20));
    x2T20 = x2T20(1);
    T20 = 3*(x2T20 - x1T20)

    %% T30
    y1T30 = find(Suavizado<max(Suavizado)-5);
    y1T30 = y1T30(y1T30 > Max);
    y1T30 = y1T30(1);
    y1T30 = Suavizado(y1T30);
    y2T30 = find(Suavizado<max(Suavizado)-35);
    y2T30 = y2T30(y2T30 > Max);
    y2T30 = y2T30(1);
    y2T30 = Suavizado(y2T30);
    x1T30 = x(find(Suavizado == y1T30));
    x1T30 = x1T30(1);
    x2T30 = x(find(Suavizado == y2T30));
    x2T30 = x2T30(1);
    T30 = 2*(x2T30 - x1T30)
end

%%  Parametros energeticos
%       Calcula los par�metros energ�ticos de claridad y definici�n
%       seg�n ISO-3382. 
function [C80,D50] = energeticos(Suavizado,fm)
%Par�metros Energ�ticos

    p = Suavizado.^2;              %Respuesta al Impulso al Cuadrado
    Ms50 = 0.05*fm;  %Redondeo a 50ms 
    Ms80 = 0.08*fm;  %Redondeo a 80ms
    
    C80 = 10*log10(trapz(p(1:Ms80))/trapz(p(Ms80:end)))  %C80
    D50 = (trapz(p(1:Ms50))/trapz(p(1:end)))*100         %D50
end

