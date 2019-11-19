function [AudioDataSet] = audioImport()
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
        
            %% Inicio de Bucle
            i = 1;
            while i<=length(filename)
                
                Filename = filename{i}; %Variable con nombre del Archivo
            
                [x,fs] = audioread(Filename);
                info = audioinfo(Filename);

                AudioDataSet{i} = struct('FileName',Filename ,'amplitudvector',x ,...
                    'SampleRate',fs,'Duracion', info.Duration);
           
                i = i + 1;
            end
end

   