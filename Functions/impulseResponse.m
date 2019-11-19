function [IR, fs] = impulseResponse(Signal)
%%   Función impulseResponse
%
%   [IR, fs] = impulseResponse(Signal)
%
%   Devuelve la respuesta al impulso de un recinto
%   a partir de la señal obtenida con playrec.

    %%
    
    Matriz = zeros(length(Signal{1}.amplitudvector),length(Signal));
    a = 1;
    for i=1:length(Signal)
        Matriz(:, a) = Signal{a}.amplitudvector;
        a = a + 1;
    end
    
    Audio = mean(Matriz,2);    
    [InvertedFilt, fs] = audioread("inverted.wav");
    
    
    IR = conv(Audio, InvertedFilt);
    
end

