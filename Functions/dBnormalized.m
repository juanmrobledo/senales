function [AmplituddB] = dBnormalized(AudioFile)
%Normaliza la amplitud en dB
% Input : Archivo de audio 
%

%%NOTES
%Solucion: sumar constante, luego restar (dB)

%%
    SampleRate = 44100;
    FileAudio = audioread(AudioFile);
    FileInfo = audioinfo(AudioFile);
    Time= FileInfo.Duration;

%%
    FileAudio =abs(FileAudio)/max(FileAudio);
    zeros = find(FileAudio == 0);
    Filea(zeros) = 0.000001;
    AmplituddB = 20*log10(FileAudio);

    Tiempo = 0:seconds(1/SampleRate):seconds(Time);
    Tiempo = Tiempo(1:end-1);



%plot(Time,AmplituddB)
end
