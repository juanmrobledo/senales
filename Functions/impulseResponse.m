function [IR] = impulseResponse()
%   Función impulseResponse devuelve la respuesta al impulso de un recinto
%   a partir de la señal obtenida con playrec.

    RecSineSweep = audioread("Recorded Signal.wav");
    InvertedFilt = audioread("inverted.wav");
    
    IR = conv(RecSineSweep, InvertedFilt);
    
end

