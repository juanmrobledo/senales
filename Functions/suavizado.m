function [SuavizadodB] = suavizado(Ir)
%%  Funcion suavizado
%
%   [SuavizadodB] = suavizado(Signal)
%
%   Suaviza la señal para poder ser analizada por la funcion AllParameters. 
%
%   Entrada:
%       Audio = Estructura de la señal. 
%   Salida:
%       SuavizadodB = Envolvente suavizada con amlitud normalizada en dB
    
    %% Correccion para tipo de variable Cell
    if class(Ir)=='cell'
    Ir = Ir{1}.amplitudvector;
    end

%% Hilbert    
    
    myHilbert = hilbert(Ir);
    Analitica = Ir + 1i*myHilbert;   %Funcion Analitica
    Suavizado = abs(Analitica);
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