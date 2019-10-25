function [SintRI] = SintRI(fcen, T60, t)

% Sintetizacion de respuesta al impulso
%   fcen = Frecuencia Central
%   T60 = Tiempo de reverberacion
%   t = Duracion del impulso
%   ri = Respuesta al impuslo
%   pii = Decamiento exponencial en funcion del tiempo de rev.

ri = 0;
n = length(fcen);

%SampleRate = 44100;
for i=1:n
    %Decamiento exponencial en funcion del tiempo de rev.
    pii = (-log(10^-3))/(T60(i)); 

    %Respuesta al impulso
    ri = (exp(pii*t))*cos(2*pi* fcen(i)*t);
    yt = sum(ri)
    
    
end