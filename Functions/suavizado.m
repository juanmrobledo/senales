function [SuavizadodB] = suavizado(Signal)
%%  Funcion suavizado
%
%   [SuavizadodB] = suavizado(Signal)
%
%   Suaviza la señal para poder ser analizada por la funciÃ³n AllParameters. 
%
%   Entrada:
%       Audio = Estructura de la señal. 
%   Salida:
%       SuavizadodB = Envolvente suavizada con amlitud normalizada en dB

%% Hilbert
    Audio = Signal.amplitudvector;
    myHilbert = hilbert(Audio);
    Analitica = Audio + i*myHilbert;   %Funcion Analitica
    Suavizado = abs(Analitica);
    
    %% Shroeder
    Shroeder = cumsum(Suavizado.^2,'reverse');

%% Salida Normalizada
    SuavizadodB = 20*log10(Shroeder/max(Shroeder));
end

