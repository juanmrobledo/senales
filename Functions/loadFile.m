function [data] = loadFile(Audio)
%loadFile carga el archivo de auido y genera una estructura con 
%   Input: Archivo de audio. Se recomienda .wav
%   Output: Struct

[x,fs] = audioread(Audio);
info = audioinfo(Audio);

data = struct('amplitudvector',x,'SampleRate',fs,'Duracion', info.Duration);
end

