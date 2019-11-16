function [SuavizadodB] = suavizado(Signal)
%% Info
% Suaviza la se�al para poder ser analizada por la función AllParameters. 
%Entrada:
%   Audio = Estructura de la se�al. 
%Salida:
%   SuavizadodB = Envolvente suavizada con amlitud normalizada en dB

%% Hilbert
    Audio = Signal.amplitudvector;
    myHilbert = hilbert(Audio);
    Analitica = Audio + i*myHilbert;   %Función Analítica
    Suavizado = abs(Analitica);
    
    %% Shroeder
    Shroeder = cumsum(Suavizado.^2,'reverse');

%% Salida Normalizada
    SuavizadodB = 20*log10(Shroeder/max(Shroeder));
end

