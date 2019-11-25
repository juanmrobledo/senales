
function [EDT,T10,T20,T30,C80,D50] = allparameters(Suavizado,Signal)
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
    
    [EDT,T10,T20,T30] = tr(Suavizado);
    [C80,D50] = energeticos(Signal);
end


%%  Tiempos de reverberacion
function [EDT,T10,T20,T30] = tr(Suavizado)
%% Configuracion de Datos
    fm = 44100;
    x = 0:1/fm:(length(Suavizado)-1)/fm;


    Max0 = find(round(Suavizado) == max(Suavizado));
    Max0 = max(Max0);               %Muestra del Pico Maximo

    myMax = find(round(Suavizado) == round(max(Suavizado)-5));    
    myMax = myMax(myMax > Max0);
    myMax = myMax(1);                                      %Muestra del Pico M�ximo - 5dB

    %% EDT
    y1EDT = Max0;
    y2EDT = find(round(Suavizado) <= round(max(Suavizado)-10),1,'first');    

    x1EDT = x(y1EDT);
    x2EDT = x(y2EDT);

    EDT = 6*(x2EDT - x1EDT);

    %% T10

    y2T10 = find(round(Suavizado) <= round(max(Suavizado)-15),1,'first');    

    x1T10 = x(myMax);
    x2T10 = x(y2T10);

    T10 = 6*(x2T10 - x1T10);

    %% T20

    y2T20 = find(round(Suavizado) <= round(max(Suavizado)-25),1,'first');

    x1T20 = x(myMax);
    x2T20 = x(y2T20);

    T20 = 3*(x2T20 - x1T20);

    %% T30
    y2T30 = find(round(Suavizado-5) == round(max(Suavizado)-35),1, 'first');

    x1T30 = x(myMax);
    x2T30 = x(y2T30);

    T30 = 2*(x2T30 - x1T30);
end

function [C80,D50] = energeticos(Signal)
%%  Parametros energeticos
%       Calcula los parametros energ?ticos de claridad y definici?n
%       seg?n ISO-3382.

    fm = 44100;
    
    MaxSignal = max(Signal);            %M�ximo del Impulso
    MaxSignal = find(Signal == MaxSignal);
    
    p = Signal.^2;                  %Respuesta al Impulso al Cuadrado
    Ms50 = (0.05*fm);               %Redondeo a 50ms 
    Ms80 = (0.08*fm);               %Redondeo a 80ms
    
    C80 = 10*log10(trapz(p(MaxSignal:MaxSignal + Ms80))/trapz(p(MaxSignal + Ms80:end)));    
    D50 = 100*(sum(p(MaxSignal:MaxSignal + Ms50))/sum(p(MaxSignal:end))); 
end
