function [SuavizadodB] = suavizado(Signal)
%% Info
% Suaviza la seÒal para poder ser analizada por la funci√≥n AllParameters. 
%Entrada:
%   Audio = Estructura de la seÒal. 
%Salida:
%   SuavizadodB = Envolvente suavizada con amlitud normalizada en dB

%% Hilbert
    Audio = Signal.amplitudvector;
    myHilbert = hilbert(Audio);
    Analitica = Audio + i*myHilbert;   %Funci√≥n Anal√≠tica
    Suavizado = abs(Analitica);
    
    %% Shroeder
    Shroeder = cumsum(Suavizado.^2,'reverse');

%% Salida Normalizada
    SuavizadodB = 20*log10(Shroeder/max(Shroeder));
end

