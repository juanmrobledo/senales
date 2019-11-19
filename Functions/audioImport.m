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
        
        if class(filename) == 'char'
            
            [x,fs] = audioread(filename);
            info = audioinfo(filename);
            AudioDataSet{1} = struct('FileName',filename ,...
                'amplitudvector',x ,'SampleRate',fs,'Duracion', info.Duration);
            
        elseif class(filename) == 'cell'
            %% Seteo de Datos
            i = 1;
            MAX = 99999999999999999999999999999;
            %% Inicio de Bucle
        
            while i<=length(filename)
                
                Filename = filename{i}; %Variable con nombre del Archivo
            
                [x,fs] = audioread(Filename);
                info = audioinfo(Filename);
                
                MaxX = length(x);
                
                if MaxX < MAX
                    MAX = MaxX;
                end
                

                
                AudioDataSet{i} = x;
                
                i = i + 1;
            end
        end     % if linea 18
        % Buscar longitud maxima del archivo externo
        
for i=1:length(filename)
    
    memoTemp = AudioDataSet{i};
    memoTemp((length(memoTemp)+1):MAX) = zeros(1,((MAX-length(memoTemp)+1)));
    Matriz(:, i) = memoTemp;
    
end
    Promedio = mean(Matriz,2); %Promedio de todas los archivos externos
    Duracion = length(Promedio)*(fs^(-1));
    
                    Signal = struct('amplitudvector',Promedio ,...
                    'SampleRate',fs,'Duracion', Duracion);
end

   