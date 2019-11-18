function [IR] = impulseResponse()
%%   Funci�n impulseResponse
%
%   [IR] = impulseResponse()
%
%   Devuelve la respuesta al impulso de un recinto
%   a partir de la se�al obtenida con playrec.

%%
    RecSineSweep = audioread("Recorded Signal.wav");
    InvertedFilt = audioread("inverted.wav");
    
    IR = conv(RecSineSweep, InvertedFilt);
    
end

