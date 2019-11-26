function ReproducirAudio(Ss,Ns,Placa,SR)
%Script para la reproduccion y grabacion de un ruido en simultaneo
%Variables de entrada:
%Ss = Ruta del signal sweep generado con extencion de pista de audio
%Ns = Nombre del fichero de salida donde sera guardada la grabacion.
%Placa = Placa con la cual se va a realizar la grabacion (Anteriormente
%seleccionada en la GUI)
%SR = Sample Rate
fileReader = dsp.AudioFileReader(Ss, ...
    'SamplesPerFrame',512); %Creo un objeto con el archivo a leer y sus propiedades. Por defecto 16 bit para reducir la latencia de la placa minimizando su buffer

fileWriter = dsp.AudioFileWriter(Ns, ...
    'SampleRate',SR); %Creo un objeto con el archivo de salida y sus propiedades.

aPR =audioPlayerRecorder('Device',Placa{1}); % Defino la placa a utilizar

while ~isDone(fileReader)
    audioToPlay = fileReader();

    [audioRecorded,nUnderruns,nOverruns] = aPR(audioToPlay); %Comienza la reproduccion del auido y su grabacion

    fileWriter(audioRecorded) %Guardo el auido grabado en el archivo de salida


end

release(fileReader);
release(fileWriter);
release(aPR);