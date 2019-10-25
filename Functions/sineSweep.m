function  sineSweep()
%SineSweep Summary of this function goes here
%   Detailed explanation goes here

%% Parametros Iniciales
w1 = 2*pi*20;
w2 = 2*pi*20000;
Time = 5;
SampleRate = 44100;

%% Generación de Sine Sweep

    T = Time*SampleRate;
    S = linspace(0,Time,T); %Eje Temporal
    K = (Time*w1)/(log(w2/w1));
    L = (Time/(log(w2/w1)));

SineSweep = sin(K*(exp(S/L)-1));
SineSweep = SineSweep*0.9;  %Ajuste por clipeo

audiowrite('Sine Sweep.wav',SineSweep,SampleRate);

%% Inversion

    W = K/L*exp(T/L);
    M = w1./(2*pi*W);

invertedSineSweep = M.*(flip(SineSweep));
    
audiowrite('Inverted Sine Sweep.wav',invertedSineSweep,SampleRate);
    

end

