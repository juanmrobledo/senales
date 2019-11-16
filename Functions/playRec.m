function playRec()

%   Funcion para Reproducir y Grabar en simultaneo. 

%% Seleccion de Dispositivo de Reproduccion/Grabacion a utilizar
    devices = getAudioDevices(audioPlayerRecorder);
        disp('Dispositivos disponibles con modo full-duplex');
        disp(devices);
    device = input('Seleccione dispositivo (ingrese nombre exacto): ','s');

%% Objetos
    fileReader = dsp.AudioFileReader('Sine Sweep.wav');
    Fs = fileReader.SampleRate;
    fileWriter = dsp.AudioFileWriter('Recorded Signal.wav','SampleRate',Fs);
    devicePlayRec = audioPlayerRecorder('Device',device,'SampleRate',Fs);

%% Bucle de Adquisicion
disp('Inicio de Adquisición')
while ~isDone(fileReader)  %corregir 1024 muestras perdidas 
    
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