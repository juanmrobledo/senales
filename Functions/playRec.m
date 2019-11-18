function playRec(f1,f2,Time)
%%   Funcion para Reproducir y Grabar en simultaneo. playRec.
%
%   playRec()
%
%   Esta funcion permite reproducir un sine sweep y al mismo tiempo grabar
%   como un recinto responde a dicho sine sweep. Una vez terminada la
%   grabacion, se guarda un archivo con el nombre "Recorded Signal.wav" en
%   la carpeta del programa.

%% Objetos

devices = getAudioDevices(audioPlayerRecorder);
        disp('Dispositivos disponibles con modo full-duplex');
        disp(devices);
    device = input('Seleccione dispositivo (ingrese nombre exacto): ','s');
    
    [Sine, Fs] = sineSweep(f1,f2,Time); clear Sine
    
    fileReader = dsp.AudioFileReader('Sine Sweep.wav');
    fileWriter = dsp.AudioFileWriter('Recorded Signal.wav','SampleRate',Fs);
    devicePlayRec = audioPlayerRecorder('Device',device,'SampleRate',Fs);

%% Bucle de Adquisicion
disp('Inicio de Adquisición')
while ~isDone(fileReader)  
    
    audioToPlay = fileReader();
    [audioRecorded,nUnderruns,nOverruns] = devicePlayRec(audioToPlay);
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
end