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

%% Seteo Inicial
   Ans = 'S';
   a = 1;
  
%% Generación de DataSet

   while  or(Ans == 's',Ans == 'S')
        Archivo = input('Ingrese nombre de Archivo: ','s');
        
        [x,fs] = audioread(Archivo);
        info = audioinfo(Archivo);
        
        AudioDataSet{a,1} = 'Ir' + string(a);
        AudioDataSet{a,2} = struct('amplitudvector',x','SampleRate',fs,'Duracion', info.Duration);
        
        a = a + 1;
        Ans = input('Desea añadir mas archivos de audio? (S/N)','s');
    end
    
end

   