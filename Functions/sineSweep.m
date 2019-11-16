function [SineSweep, SampleRate] = sineSweep(f1,f2,Time)
%%  Funcion sineSweep
%
%   sineSweep(f1,f2,Time)
%
%   Esta funcion genera un SineSweep logaritmico, y el mismo con su filtro
%   inverso.
%
%   Inputs:
%          f1: Frecuencia Inicial
%          f2: Frecuencia Final
%          Time: tiempo en segundos 

%% Parametros Iniciales
w1 = 2*pi*f1;
w2 = 2*pi*f2;
SampleRate = 44100;

%% Generación de Sine Sweep

        N = Time*SampleRate;
        T = linspace(0,Time,N); 

        k = (Time*w1)/log(w2/w1);
        l = Time/log(w2/w1);

        SineSweep = sin(k*(exp(T./l)-1));  
        SineSweep = SineSweep.*0.7; %Ajuste por clipeo
        %SineSweep = normalize(SineSweep);

        audiowrite('Sine Sweep.wav',SineSweep,SampleRate);
        
%% Inversion

        w = (k/l)*exp(T./l);
        m = w1./(2*pi*w);

        InvertedFilt = m.*wrev(SineSweep);
        InvertedFilt = InvertedFilt*0.8;

        audiowrite('inverted.wav',InvertedFilt,SampleRate);


end

