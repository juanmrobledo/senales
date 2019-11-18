function [IR, fs] = impulseResponse(Signal)
%%   Función impulseResponse
%
%   [IR, fs] = impulseResponse(Signal)
%
%   Devuelve la respuesta al impulso de un recinto
%   a partir de la señal obtenida con playrec.

%%
    [InvertedFilt, fs] = audioread("inverted.wav");
    
    IR = conv(Signal, InvertedFilt);
    
end

