function [SintIR] = SintIR(Time)
%Sintetizacion de respuesta al impulso
% 
%   fcen = Frecuencia Central
%   T60 = Tiempo de reverberacion
%   Time = Duracion del impulso
%   ri = Respuesta al impuslo
%   pii = Decamiento exponencial en funcion del tiempo de rev.

%Frecuencias centrales nominales por banda de octavas
fcen = [63 125 250 500 1000 2000 4000 8000];

%   T60 = Tiempo de Reverberacion (Referencia: Venturi,Farina. ArchitecturalAcoustics: Advanced Analysis ofRoom Acoustics:ISO 3382 ICA2013)
T60 = [1.02 1.07 1.34 1.39 1.22 1.17 1.08 0.76];

%% Ajuste de tiempo y frecuencia de muestreo
SampleRate = 44100;
N = Time*SampleRate;
t = linspace(0,Time,N);
n = length(fcen);

    %% Decamiento exponencial en funcion del tiempo de rev
for k=1:n

    pik = (-log(10^-3))./(T60(k)); 

    %Respuesta al impulso
    y_i(k,:) = (exp(pik*t)).*cos(2*pi* fcen(k)*t);
    %SintIR = flip(y_i);
    SumIR = cumsum(y_i);
    
    plot(t,SumIR); 
    title('Sintetizacion de Respuesta al Impulso');
    disp(SumIR);
end

clear n

for l=1:n
    
end

%% Guardado de la respuesta al impulso en formato .wav
%name = ['SintIR'];
%audiowrite('SintIR.wav',SintIR,44100)

end