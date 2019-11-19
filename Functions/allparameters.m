
function [EDT,T10,T20,T30,T60,C80,D50] = allparameters(Suavizado,Signal)
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
    [EDT,T10,T20,T30,T60] = tr(Suavizado);
    [C80,D50] = energeticos(Signal);
end


%%  Tiempos de reverberacion
function [EDT,T10,T20,T30,T60] = tr(Suavizado)
%       Esta funcion es una adaptacion de la funcion calcular_parametros,
%       creada para la asignatura Se�ales y Sistemas durante 
%       el 2do cuatrimestre de 2018.
%       Autoria: Corina Castelli, Nahuel Passano, Agustin Espindola, Matias
%       Lareo

    fm = 44100;
    x_i = 0:1/fm:(length(Suavizado)-1)/fm;
    y_i = Suavizado;

    %% EDT
    x1 = find(y_i <= (max(y_i)-5),1,'first');
    x2 = find(y_i <= (max(y_i)-35),1,'first');
    x_i = x_i(x1:x2);
    y_i = y_i(x1:x2);
    [~,a1] = cuadMin(x_i,y_i);
    EDT = (-60)/a1;

    %% T10
    x1 = find(y_i <= (max(y_i)-5),1,'first');
    x2 = find(y_i <= (max(y_i)-35),1,'first');
    x_i = x_i(x1:x2);
    y_i = y_i(x1:x2);
    [~,a1] = cuadMin(x_i,y_i);
    T10 = (-60)/a1;

    %% T20
    x1 = find(y_i <= (max(y_i)-5),1,'first');
    x2 = find(y_i <= (max(y_i)-35),1,'first');
    x_i = x_i(x1:x2);
    y_i = y_i(x1:x2);
    [~,a1] = cuadMin(x_i,y_i);
    T20 = (-60)/a1;

    %% T30
    x1 = find(y_i <= (max(y_i)-5),1,'first');
    x2 = find(y_i <= (max(y_i)-35),1,'first');
    x_i = x_i(x1:x2);
    y_i = y_i(x1:x2);
    [~,a1] = cuadMin(x_i,y_i);
    T30 = (-60)/a1;
    
    %% T60
    x1 = find(y_i <= (max(y_i)-5),1,'first');
    x2 = find(y_i <= (max(y_i)-65),1,'first');
    x_i = x_i(x1:x2);
    y_i = y_i(x1:x2);
    [~,a1] = cuadMin(x_i,y_i);
    T60 = (-60)/a1;
end

function [C80,D50] = energeticos(Signal)
%%  Parametros energeticos
%       Calcula los parametros energ?ticos de claridad y definici?n
%       seg?n ISO-3382.
    fm = 44100;
    
    p = Signal.^2;         %Respuesta al Impulso al Cuadrado
    Ms50 = (0.05*fm);  %Redondeo a 50ms 
    Ms80 = (0.08*fm);  %Redondeo a 80ms
    
    C80 = 10*log10(trapz(p(1:Ms80))/trapz(p(Ms80:end)));    
    D50 = 100*(sum(p(1:Ms50))/sum(p(1:end))); 
end
