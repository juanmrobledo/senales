function [AmplituddB] = dBnormalized(AudioFile)
%Normaliza la amplitud en dB
% Input : Archivo de audio 
%
SampleRate = 44100;
FileAudio = audioread(AudioFile);
FileInfo = audioinfo(AudioFile);
Time= FileInfo.Duration;

%%
Tiempo = 0:seconds(1/SampleRate):seconds(Time);
Tiempo = Tiempo(1:end-1);

FileAudio =abs(FileAudio)/max(FileAudio);
AmplituddB = 20*log10(FileAudio);

end
