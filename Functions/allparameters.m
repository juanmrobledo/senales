%%  Parametros
function [EDT,T20,T30,C80,D50] = allparameters(Suavizado)
% allparameters
%   Calcula los tiempos de reverberacion seg�n la norma ISO-3382
%   y los parametros energeticos de Claridad (C80) y Definicion (D50).
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

%% Configuración de Datos
    x = 0:1/fm:(length(Suavizado)-1)/fm;
    
    
    Max0 = find(Suavizado == max(Suavizado));              %Muestra del Pico Maximo
    
    myMax = find(round(Suavizado) == round(max(Suavizado)-5));    
    myMax = myMax(myMax > Max0);
    myMax = myMax(1);                                      %Muestra del Pico Máximo - 5dB
    
    %% EDT
    y1EDT = Max0;
    y2EDT = find(round(Suavizado) == round(max(Suavizado)-10));    
    y2EDT = y2EDT(y2EDT > myMax);
    y2EDT = y2EDT(1);
    
    x1EDT = x(y1EDT);
    x2EDT = x(y2EDT);
    
    EDT = 6*(x2EDT - x1EDT);
    
    %% T20
    y1T20 = myMax;
    
    y2T20 = find(round(Suavizado) == round(max(Suavizado)-25));
    y2T20 = y2T20(y2T20 > myMax);
    y2T20 = y2T20(1);
    
    x1T20 = x(y1T20);
    x2T20 = x(y2T20);

    T20 = x(3*(y2T20 - y1T20));

    %% T30
    y1T30 = myMax;

    y2T30 = find(round(Suavizado) == round(max(Suavizado)-35));
    y2T30 = y2T30(y2T30 > myMax);
    y2T30 = y2T30(1);

    x1T30 = x(y1T30);
    x2T30 = x(y2T30);

    T30 = 2*(x2T30 - x1T30);
    
    %% T60
    y1T60 = myMax;

    y2T60 = find(round(Suavizado) == round(max(Suavizado)-65));
    y2T60 = y2T60(y2T60 > myMax);
    y2T60 = y2T60(1);

    x1T60 = x(y1T60);
    x2T60 = x(y2T60);

    T60 = x2T60 - x1T60;
end

%%  Parametros energeticos
%       Calcula los par�metros energ�ticos de claridad y definici�n
%       seg�n ISO-3382. 
function [C80,D50] = energeticos(Suavizado,fm)
%Par�metros Energ�ticos

    p = Suavizado.^2;              %Respuesta al Impulso al Cuadrado
    Ms50 = 0.05*fm;  %Redondeo a 50ms 
    Ms80 = 0.08*fm;  %Redondeo a 80ms
    
    C80 = abs(10*log10(trapz(p(1:Ms80))/trapz(p(Ms80:end))));    %C80
    D50 = (cumsum(p(1:Ms50))/cumsum(p(1:end)));
    D50 = D50(end)*100  %D50
end

