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
    
    Matriz = zeros(length(Signal{1}.amplitudvector),length(Signal));
    a = 1;
    
    for i=1:length(Signal)
        Matriz(:, a) = Signal{a}.amplitudvector;
        
        a = a + 1;
    end
    
    Audio = mean(Matriz,2);    
    myHilbert = hilbert(Audio);
    Analitica = Audio + 1i*myHilbert;   %Funcion Analitica
    Suavizado = abs(Analitica);
    
    
%% Limite de Loundeby
Lim = lundeby(Signal);
    %% Shroeder
    Shroeder(Lim:-1:1) = cumsum(Suavizado(1:Lim).^2,'reverse');

%% Salida Normalizada
    SuavizadodB = 10*log10(Shroeder/max(Shroeder));


end