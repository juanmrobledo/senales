function [Filto] = Aplica_Filtro(Audio,Sr,TipoFiltro)
%Aplica los filtros a las señales, creando estructuras con los filtros aplicados
%   según si el audio se encuentra sampleado a 48000 o 44100 muestras/segundo
%   Los filtros aplicados son de octava o de tercio de octava
%   Los filtros ya fueron generados y se encentran en los archivos .mat
%   dentro de la carpeta contenedora del programa.
Signal = Audio;
Tipo = TipoFiltro;
%ord=2 es octava, y se separa según cual sea la frecuencia
%   de sampleo del audio
if Tipo == 8 && Sr==44100 %ord=2 es octava
    f0 = 1000;
    load('foct44100');
    H= H(2:9);
    for i = 1:8 %Creación de los elementos del cell
        y{i} = zeros(length(Signal),1);
        y{i} = filter(H(i),Signal);
    end
elseif Tipo == 8 && Sr==48000
    f0 = 1000;
    load('foct48000');
    H= H(2:9);
    for i = 1:8 %Creación de las señales filtradas dentro de un cell
        y{i} = zeros(length(Signal),1);
        y{i} = filter(H(i),Signal);
    end
%ord=3 es tercio de octava, y se separa según cual sea la frecuencia
%   de sampleo del audio
elseif Tipo == 3 && Sr==44100 
    f0 = 1000;
    load('fter44100');
    H=H(5:27);
    for i = 1:23
        y{i} = zeros(length(Signal),1);
        y{i} = filter(H(i),Signal);
    end
elseif Tipo == 3 && Sr==48000
    f0 = 1000;
    load('fter48000');
    H=H(5:27);
    for i = 1:23
        y{i} = zeros(length(Signal),1);
        y{i} = filter(H(i),Signal);
    end
end
%Guardado de los valores
Filto.Audio = y;
Filto.Sr = Sr;
end