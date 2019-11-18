function [IR, fs] = impulseResponse(Signal)
%%   Funci�n impulseResponse
%
%   [IR, fs] = impulseResponse(Signal)
%
%   Devuelve la respuesta al impulso de un recinto
%   a partir de la se�al obtenida con playrec.

%%
    [InvertedFilt, fs] = audioread("inverted.wav");
    
    IR = conv(Signal, InvertedFilt);
    
end

