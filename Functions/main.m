function vargout = main (Signal)

%Se obtiene un array de la señal promediada
%Se crea un handle con la señal:
%  Signal.amplitudvector = array digital
%  Signal.SampleRate = Frecuencia de muestreo
%  Signal.Time = Duracion de IR

%%%%%%%%%%%%%%%%%%%%%%%   ADQUISICION   %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%   FILTRADO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SenalSuavizada = suavizado(Signal);

load('Coeficientesdefiltros.mat')

Filtro = struct('None', Signal.amplitudvector, 'Tercio', [0], 'Octava', [0]);
Filtro.Tercio = cell(1,29);
Filtro.Octava = cell(1,10);

%% Se aplican los filtros

for i=1:29
    Filtro.Tercio{1,i} = filtfilt(terFiltBank{i,2},Signal.amplitudvector);
end


for i=1:10
    Filtro.Octava{1,i} = filtfilt(octFiltBank{i,2},Signal.amplitudvector);
end


%% %%%%%%%%%%%%%%%%    SUAVIZADO   %%%%%%%%%%%%%%%

Filtro.None = suavizado(Signal);
memoTemp = Signal.amplitudvector; %se salva archivo sin procesar

for i=1:10
    Signal.amplitudvector = Filtro.Octava{1,i};
    Filtro.Octava{1,i} = suavizado(Signal);
end

for i=1:29
    Signal.amplitudvector = Filtro.Tercio{1,i};
    Filtro.Tercio{1,i} = suavizado(Signal);
end

Signal.amplitudvector = memoTemp;
clear memoTemp

%%%%%%%%%%%    PARAMETROS ACUSTICOS  %%%%%%%%%%%%%%


end


