
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lundeby.m
%
%Implements the Lundeby method, to determine the truncation point.
%
%[ponto,C]=lundeby(IR,Fs,flag)
%
%% The input are the room impulse response and its sampling frequency. Flag
%% specifies if the results should be ploted (1) or not(0).
%% The output are the truncation point (ponto) and the correction constant
%% C, used to compensate for the truncation effects in the Schroeder plots.
%% If no output variables are given, the function prints a grafic with the
%% evaluated values.

function cruce=lundeby(IR, SampleRate)


energia_impulso = IR.^2;


        %Calcula el nivel de ruido del ultimo 10% de la señal. Se asume que
        %alli domina el ruido de la señal
rms_dB = 10*log10(mean(energia_impulso(round(.9*length(energia_impulso)):end))/max(energia_impulso));


t = floor(length(energia_impulso)/SampleRate/0.01);
    %cantidad de intervalos de 10 ms

v = floor(length(energia_impulso)/t);

for n=1:t
    media(n) = mean(energia_impulso((((n-1)*v)+1):(n*v)));
    eixo_tempo(n) = ceil(v/2)+((n-1)*v);
end
mediadB = 10*log10(media/max(energia_impulso));

%obtem a regressao linear o intervalo de 0dB e a media mais proxima de rms+10dB
r = max(find(mediadB > rms_dB+10));
if any (mediadB(1:r) < rms_dB+10)
    r = min(find(mediadB(1:r) < rms_dB+10));
end
if isempty(r)
    r=10
elseif r<10
    r=10;
end

[A,B] = cuadMin(eixo_tempo(1:r),mediadB(1:r));
cruce = (rms_dB-A)/B;

if rms_dB > -20
    %Relacao sinal ruido insuficiente
    ponto=length(energia_impulso);
    if nargout==2
        C=0;
    end
else
    
    %% Seccion iterativa

    error=1;
    INTMAX=50;
    veces=1;
    while (error > 0.0001 & veces <= INTMAX)
    
        %Calcula novos intervalos de tempo para media, com aproximadamente p passos por 10dB
        clear r t v n media eixo_tempo;

        p = 5;                          %numero de passos por decada
        delta = abs(10/B);              %numero de amostras para o a linha de tendencia decair 10dB
        v = floor(delta/p);             %intervalo para obtencao de media
        t = floor(length(energia_impulso(1:round(cruce-delta)))/v);
        if t < 2                        %numero de intervalos para obtencao da nova media no intervalo
            t=2;                        %que vai do inicio ate 10dB antes do ponto de cruzamento.
        elseif isempty(t)
            t=2;
        end
    
        for n=1:t
            media(n) = mean(energia_impulso((((n-1)*v)+1):(n*v)));
            eixo_tempo(n) = ceil(v/2)+((n-1)*v);
        end
        mediadB = 10*log10(media/max(energia_impulso));
    
        clear A B noise energia_ruido rms_dB;
        [A,B] = cuadMin(eixo_tempo,mediadB);

        %nova media da energia do ruido, iniciando no ponto da linha de tendencia 10dB abaixo do cruzamento.
        noise = energia_impulso(round(cruce+delta):end);
        if (length(noise) < round(.1*length(energia_impulso)))
            noise = energia_impulso(round(.9*length(energia_impulso)):end); 
        end       
        rms_dB = 10*log10(mean(noise)/max(energia_impulso));

        %novo ponto de cruzamento.
        error = abs(cruce - (rms_dB-A)/B)/cruce;
        cruce = round((rms_dB-A)/B);
        veces = veces + 1;
    end
end
end
