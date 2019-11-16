function [PinkNoise,Fs] = pinkNoise(Time)
%%
%   Funcion de Ruido Rosa, pinkNoise. 
%
%   [PinkNoise,Fs] = pinkNoise(Time)
%
%   Se genera una señal de Ruido Rosa a partir del filtrado de  un ruido 
%   blanco con caida de 3 dB/octava.
%
%   Inputs:
%       Time: Tiempo en segundos
%   Outputs:
%        archivo .wav con ruido rosa de duraciÃ³n "Time"

%% Creacion de Objetos 

SamplingRate = 44100;
Nx= SamplingRate*Time; %muestras a sintetizar: frecuencia de muestreo * tiempo en segundos 

B=[0.049922035 -0.095993537 0.050612699 -0.004408786]; %coeficientes del filtro 3dB
A=[1 -2.494956002 2.017265875 -0.522189400];
nT60 = round(log(1000)/(1-max(abs(roots(A))))); %numero de muestras que tarda la señal en caer 60dB

v = randn(1,Nx+nT60); %Vector Aleatorio
x = filter(B,A,v); %filtro 1/f

%% Funcion PinkNoise
PinkNoise = x(nT60+1:end);
PinkNoise = normalize(PinkNoise); 

audiowrite('Pink Noise.wav',PinkNoise,SamplingRate);
end

