function playRec(f1,f2,Time,Device)
%%   Funcion para Reproducir y Grabar en simultaneo. playRec.
%
%   playRec()
%
%   Esta funcion permite reproducir un sine sweep y al mismo tiempo grabar
%   como un recinto responde a dicho sine sweep. Una vez terminada la
%   grabacion, se guarda un archivo con el nombre "Recorded Signal.wav" en
%   la carpeta del programa.


%% Objetos


    [Sine, Fs] = sineSweep(f1,f2,Time); clear Sine
    
    fileReader = dsp.AudioFileReader('Sine Sweep.wav');
    fileWriter = dsp.AudioFileWriter('Recorded Signal.wav','SampleRate',Fs);
    devicePlayRec = audioPlayerRecorder('Device',Device,'SampleRate',Fs);
<<<<<<< HEAD
=======
   
>>>>>>> 8f92122552ab8964fddb0c876e02fe473bfc30c5

%% Bucle de Adquisicion
disp('Inicio de Adquisición')
while ~isDone(fileReader)  
    
    audioToPlay = fileReader();
<<<<<<< HEAD
    [audioRecorded,nUnderruns,nOverruns] = devicePlayRec(audioToPlay);
=======
    [audioRecorded,nOverruns] = devicePlayRec(audioToPlay);
>>>>>>> 8f92122552ab8964fddb0c876e02fe473bfc30c5
    fileWriter(audioRecorded)
    
    if nUnderruns > 0
        fprintf('La cola del reproductor de audio fue superada por %d muestras.\n',nUnderruns);
    end
    if nOverruns > 0
        fprintf('La cola del grabador de audio fue superado por %d muestras.\n',nOverruns);
    end
end

    disp('Adquisición Finalizada')

release(fileReader)
release(fileWriter)
release(devicePlayRec)
<<<<<<< HEAD
end

=======
end
>>>>>>> 8f92122552ab8964fddb0c876e02fe473bfc30c5
