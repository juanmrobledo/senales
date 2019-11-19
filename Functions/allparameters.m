
function [EDT,T20,T30,C80,D50] = allparameters(Suavizado)
%%  Funcion allparameters
%
%   [EDT,T20,T30,C80,D50] = allparameters(Suavizado)
%
%   Calcula los tiempos de reverberacion segun la norma ISO-3382
%   y los parametros energeticos de Claridad (C80) y Definicion (D50).
%
%   Entradas:
%       Ir = Respuesta al impulso.
%       fm = Frecuencia de muestreo.
%
%   Salidas:
%       EDT = Early Decay Time en [s]
%       T20 = Parametro T20 [s]
%       T30 = Parametro T30 [s]
%       C80 = Claridad Musical Media (C80) [dB]
%       C50 = Claridad de la Voz (C50) [dB]
%       D50 = Definicion de la voz (D50) [Porcentaje]
    
    fm = 44100;
    [EDT,T20,T30] = tr(Suavizado,fm);
    [C80,D50] = energeticos(Suavizado,fm);
end


function [EDT,T20,T30] = tr(Suavizado,fm)
%%  Tiempos de Reverberacionn
%
%   [EDT,T20,T30] = tr(Suavizado,fm)
%
%   Calcula los tiempos de reverberaci�n T20, T30 y EDT 
%	segunn norma ISO 3382.

%% Configuracion de Datos
    x = 0:1/fm:(length(Suavizado)-1)/fm;
    
    
    Max0 = find(round(Suavizado) == max(Suavizado));
    Max0 = max(Max0);               %Muestra del Pico Maximo
    
    myMax = find(round(Suavizado) == round(max(Suavizado)-5));    
    myMax = myMax(myMax > Max0);
    myMax = myMax(1);                                      %Muestra del Pico Máximo - 5dB
    
    %% EDT
    y1EDT = Max0;
    y2EDT = find(round(Suavizado) == round(max(Suavizado)-10),1,'first');    
%     y2EDT = y2EDT(y2EDT > myMax);
%     y2EDT = y2EDT(1);
    
    x1EDT = x(y1EDT);
    x2EDT = x(y2EDT);
    
    EDT = 6*(x2EDT - x1EDT);
    
    %% T20
    
    y2T20 = find(round(Suavizado) == round(max(Suavizado)-25),1,'first');
%     y2T20 = y2T20(y2T20 > myMax);
%     y2T20 = y2T20(1);
    
    x1T20 = x(myMax);
    x2T20 = x(y2T20);

    T20 = 3*(x2T20 - x1T20);

    %% T30
    y2T30 = find(round(Suavizado) == round(max(Suavizado)-35),1, 'first');
%     y2T30 = y2T30(y2T30 > myMax);
%     y2T30 = y2T30(1);

    x1T30 = x(myMax);
    x2T30 = x(y2T30);

    T30 = 2*(x2T30 - x1T30);
    
    %% T60
%     T60 = 'lpm';
    
end

function [C80,D50] = energeticos(Suavizado,fm)
%%  Parametros energeticos
%       Calcula los parametros energ�ticos de claridad y definici�n
%       seg�n ISO-3382. 

    p = Suavizado.^2;         %Respuesta al Impulso al Cuadrado
    Ms50 = (0.05*fm);  %Redondeo a 50ms 
    Ms80 = (0.08*fm);  %Redondeo a 80ms
    
    C80 = 10*log10(trapz(p(1:Ms80))/trapz(p(Ms80:end)));    
    D50 = (sum(p(1:Ms50))/sum(p(1:end))); 
end

