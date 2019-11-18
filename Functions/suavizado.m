function [SuavizadodB] = suavizado(Signal)
%%  Funcion suavizado
%
%   [SuavizadodB] = suavizado(Signal)
%
%   Suaviza la se�al para poder ser analizada por la función AllParameters. 
%
%   Entrada:
%       Audio = Estructura de la se�al. 
%   Salida:
%       SuavizadodB = Envolvente suavizada con amlitud normalizada en dB



%% Hilbert
    Audio = Signal.amplitudvector;
    myHilbert = hilbert(Audio);
    Analitica = Audio + i*myHilbert;   %Funcion Analitica
    Suavizado = abs(Analitica);
    
%% Límite de Loundby
Lim = lundeby(Signal);
    %% Shroeder
    Shroeder = cumsum(Suavizado(1:Lim).^2,'reverse');

%% Salida Normalizada
    SuavizadodB = 20*log10(Shroeder/max(Shroeder));


end