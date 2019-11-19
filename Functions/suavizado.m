function [SuavizadodB] = suavizado(Signal)
%%  Funcion suavizado
%
%   [SuavizadodB] = suavizado(Signal)
%
%   Suaviza la se�al para poder ser analizada por la funcion AllParameters. 
%
%   Entrada:
%       Audio = Estructura de la se�al. 
%   Salida:
%       SuavizadodB = Envolvente suavizada con amlitud normalizada en dB
    
    

Ir = Signal.amplitudvector;

%% Hilbert    
    
    myHilbert = hilbert(Ir);
    Analitica = Ir + 1i*myHilbert;   %Funcion Analitica
    Suavizado = abs(Analitica);

%% Media Movil
    Suavizado = medMov(Suavizado);
    
    %% Shroeder
    Shroeder = cumsum(Suavizado.^2,'reverse');

%% Salida Normalizada
    SuavizadodB = 10*log10(Shroeder/max(Shroeder));


end
function htmm = medMov(Ir)

    movavgWindow = dsp.MovingAverage(19);
    htmm = movavgWindow(Ir);

end