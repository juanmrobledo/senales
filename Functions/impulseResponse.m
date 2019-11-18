function [IR] = impulseResponse()
%%   Función impulseResponse
%
%   [IR] = impulseResponse()
%
%   Devuelve la respuesta al impulso de un recinto
%   a partir de la señal obtenida con playrec.

%%
    RecSineSweep = audioread("Recorded Signal.wav");
    InvertedFilt = audioread("inverted.wav");
    
    IR = conv(RecSineSweep, InvertedFilt);
    
end

