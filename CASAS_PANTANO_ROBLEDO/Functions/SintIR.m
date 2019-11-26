function [SintIR] = SintIR(Time,OctOrTer)
%%  Funcion Sintetizacion de respuesta al impulso, SintIR
% 
%   [SintIR] = SintIR(Time,OctOrTer)
%
%   fcen = Frecuencia Central
%   T60 = Tiempo de reverberacion
%   Time = Duracion del impulso
%   ri = Respuesta al impuslo
%   pii = Decamiento exponencial en funcion del tiempo de rev.
%   OctOrTer = Seleccion de Frecucuencias en Banda de octavas(oct) o tercio de
%   octava(ter)
%  


%% Seleccion de Frecucuencias en Banda de octavas(oct) o tercio de octava(ter)
    if OctOrTer == 'oct'

        %Frecuencias centrales nominales por banda de octavas
        fcen = [63 125 250 500 1000 2000 4000 8000];

        %   T60 = Tiempo de Reverberacion (Referencia: Venturi,Farina. ArchitecturalAcoustics: Advanced Analysis ofRoom Acoustics:ISO 3382 ICA2013)
        T60 = [1.02 1.07 1.34 1.39 1.22 1.17 1.08 0.76];
    
    elseif OctOrTer == 'ter'
        %Frecuencias centrales nominales por banda tercio de octavas
        fcen =[20 25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2250 3150 4000 5000 6000 8000 10000 12500 16000 20000];

        %   T60 = Tiempo de Reverberacion 
        T60 = [1.02 1.07 1.34 1.39 1.22 1.17 1.08 0.76 1.02 1.07 1.34 1.39 1.22 1.17 1.08 0.761 1.07 1.34 1.39 1.22 1.17 1.08 0.76 1.02 1.07 1.34 1.39 1.22 1.17 1.08];

    end
     
    
%% Ajuste de tiempo y frecuencia de muestreo
SampleRate = 44100;
N = Time*SampleRate;
t = linspace(0,Time,N);

SintIR = cell(1,length(fcen)) %Banco de RI por fcen


%% Decamiento exponencial en funcion del tiempo de rev
for k=1:length(fcen)
    pik = (-log(10^-3))./(T60(k)); 

    %Respuesta al impulsoaudiowrite('SintIR.wav',SintIR,44100)
    y_i = (exp(pik*t)).*cos(2*pi*fcen(k)*t);
    SintIR{k} = flip(y_i);
    SumIR = sum(SintIR);
    
%     subplot(2,1,1);
%     plot(seconds(t),SintIR);
%     title('Sintetizacion de Respuesta a UN Impulso');
%     
%     subplot(2,1,2); 
%     plot(seconds(t),SumIR);
%     title('Sintetizacion de Respuesta al Impulso');
%    rplot(t,SumIR);
end

%% Sumatoria de IR
for i = 1:length(fcen)
%% Guardado de la respuesta al impulso en formato .wav
%name = ['SintIR'];
%audiowrite('SintIR.wav',SintIR,44100)

end