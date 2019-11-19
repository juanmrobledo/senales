function [Signal] = audioImport()
%%  Funcion audioImport 
% 
%     [AudioDataSet] = audioImport()
% 
%   Crea una matriz de almacenado de archivos de audio.
%   El audio se guarda en formato doble (array numerico).
%
%   Input: n Archivos de audio
%
%   Output: Celda de n filas, y 2 columnas


        %% Generacion de DataSet

        [filename] = uigetfile('*.wav','Select the INPUT DATA FILE(s)','MultiSelect','on');
        MAX = 99999999999999999999999999999;
        
        if class(filename) == 'char'
            
            [x,fs] = audioread(filename);
            AudioDataSet{1} = x;
            
            filename = 1;       %Seteo Para Promedio
            MAX = length(x);    %Seteo Para Promedio
            
        elseif class(filename) == 'cell'
            %% Seteo de Datos
            i = 1;
            
            %% Inicio de Bucle
            while i<=length(filename)
                
                Filename = filename{i}; %Variable con nombre del Archivo
            
                [x,fs] = audioread(Filename);
                AudioDataSet{i} = x;
                
                MaxX = length(x);   %Seteo Para Promedio
                if MaxX < MAX       %Seteo Para Promedio
                    MAX = MaxX;
                end
                
                i = i + 1;
            end
        end     % if linea 18
        
        % Buscar longitud maxima del archivo externo
        Matriz = zeros(MAX,length(filename));   %Matriz de ceros
        
        for i=1:length(filename)
            memoTemp = AudioDataSet{i};
            memoTemp((length(memoTemp)+1):MAX) = zeros(1,((MAX-length(memoTemp))-1));
            Matriz(:, i) = memoTemp;
        end
        
            Promedio = mean(Matriz,2); %Promedio de todas los archivos externos
            Duracion = length(Promedio)*(fs^(-1));
    
        Signal = struct('Filename','Audio Imported','amplitudvector',Promedio ,...
                    'SampleRate',fs,'Duracion', Duracion);
end