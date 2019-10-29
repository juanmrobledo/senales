function [SuavizadodB] = suavizado(Signal)
%% Info
% Suaviza la señal para poder ser analizada por la función AllParameters. 
%Entrada:
%   Audio = Archivo de audio. 
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
    SuavizadodB = 20*log(Shroeder/max(Shroeder));
end