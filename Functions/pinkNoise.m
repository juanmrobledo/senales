function [PinkNoise,Fs] = pinkNoise(Time)
% pinkNoise genera un ruido rosa, a partir de un ruido blanco filtrado con una caída de 3 dB/octava.
%   Inputs:
%       Time: Tiempo en segundos
%   Outputs:
%        archivo .wav con ruido rosa de duración "Time"
SamplingRate = 44100;
Nx= SamplingRate*Time; %muestras a sintetizar: frecuencia de muestreo * tiempo en segundos 

B=[0.049922035 -0.095993537 0.050612699 -0.004408786]; %coeficientes del filtro 3dB
A=[1 -2.494956002 2.017265875 -0.522189400];
nT60 = round(log(1000)/(1-max(abs(roots(A))))); %numero de muestras que tarda la señal en caer 60dB

v = randn(1,Nx+nT60); %Vector Aleatorio

x = filter(B,A,v); %filtro 1/f

PinkNoise = x(nT60+1:end);
PinkNoise = PinkNoise*0.8; 

audiowrite('Pink Noise.wav',PinkNoise,SamplingRate);
end

