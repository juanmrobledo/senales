function [Signal,Prom] = playRec(f1,f2,Time,Device,Repetitions)
%%   Funcion para Reproducir y Grabar en simultaneo. playRec.
%
%   [Promedio] = playRec(f1,f2,Time,Device,Repetitions)
%
%   Esta funcion permite reproducir un sine sweep y al mismo tiempo grabar
%   como un recinto responde a dicho sine sweep. Una vez terminada la
%   grabacion, se guardan los archivos con el nombre "Recorded SignalX.wav" en
%   la carpeta del programa.
%
%     Entradas:
%     f1 = Frecuencia de inicio del Sweep
%     f2 = Frecuencia final del Sweep
%     Time = Duracion en segundos del Sweep
%     Device = Dispositivo de Audio ('Full Duplex')
%     Repetitions = Cantidad de veces que se ejecuta el playRec
% 
%     Salidas:
%     Promedio = Promedio de todas las se�ales obtenidas.


%% Objetos

 [Sine, Fs] = sineSweep(f1,f2,Time); clear Sine
 devicePlayRec = audioPlayerRecorder('Device',Device,'SampleRate',Fs);
 Matriz = zeros(44032*Time,Repetitions);
 
 
%% Adquisicion
    a = 1;
    for i = 1:Repetitions
        
        name = ['Recorded Signal'  num2str(a)  '.wav'];
        fileWriter = dsp.AudioFileWriter(name,'SampleRate',Fs);
        fileReader = dsp.AudioFileReader('Sine Sweep.wav');
        
        % Bucle de Adquisicion
        disp('Inicio de Adquisicion')
        while ~isDone(fileReader)  

            audioToPlay = fileReader();
            [audioRecorded,nUnderruns,nOverruns] = devicePlayRec(audioToPlay);
            fileWriter(audioRecorded)
            
            if nUnderruns > 0
                fprintf('La cola del reproductor de audio fue superado por %d muestras.\n',nOverruns);
            end
            if nOverruns > 0
                fprintf('La cola del grabador de audio fue superado por %d muestras.\n',nOverruns);
            end
        end
        disp('Adquisicion Finalizada')
       
         x = audioread(name);
         Matriz(:, a) = x;
         
         a = a + 1;  %Incremento de Contador para 'name'
    end
    
    Promedio = mean(Matriz,2); %Promedio de todas las tomas
    Duracion = length(Promedio)*(Fs^(-1));
    
    [InvertedFilt, fs] = audioread("inverted.wav");
    IR = conv(Promedio, InvertedFilt);
    
    Signal = struct('amplitudvector', IR ,'SampleRate',Fs,'Duracion', Duracion);
    Prom = struct('amplitudvector', Promedio ,'SampleRate',Fs,'Duracion', Duracion);
    
    release(fileReader)
    release(fileWriter)
    release(devicePlayRec)

end
