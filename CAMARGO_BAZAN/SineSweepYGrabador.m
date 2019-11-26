function SineSweepYGrabador(f1,f2,T,s,Rep,TEspera,PosMic,Placa)
%Funcion SineSweepYGrabador
%Genera un funcion Sine Sweep con la frecuencia minima y maxima ingresada, el la duracion establecida por T y el Sample Rate.
%Luego de generarlo, guarda un audio .wav en el directorio de la toma con sus parametros 
%Ademas, reproduce el audio y lo graba, de igual manera y con la posicion
%de microfono PosMic, Rep veces con un tiempo de espera en segundos de TEspera mediante la placa seleccionada como Placa.
%Tambien, genera el filtro inverso de su respectivo Sine Sweep y lo almacena en el directorio de la toma.
%Variables de entrada:
%f1 = Frecuencia Minima
%f2 = Frecuencia Maxima
%T = Duracion del Ss (en segundos)
%Rep = cantidad de repeticiones de la reproduccion y grabacion del Ss.
%PosMic = indicador de posicion del microfono (Ej: A - B - C)
%Placa = Placa de sonido mediante la cual se realizaran las reproducciones y grabaciones.

%Genero W1 y W2 respecto a las frecuencias
w1 = f1*2*pi;
w2 = f2*2*pi;

%Defino mi tiempo de duracion del Sine Sweep y la cantidad de muestras que
%este tiempo tiene

t=[0:1/s:T];

%Genero L y K y finalmente genero el Sine Sweep
L=T/(log(w2/w1)); %Coeficiente que divide al tiempo
K=(T*w1)/(log(w2/w1)); %Coeficiente que mutiplica mi exponencial
Ss = sin(K*(exp(t/L)-1)); %Señal Sine Sweep de tiempo T

folder = 'Sweeps grabados y filtros inversos' %Establece el nombre del directorio general por la toma.
mkdir(folder) %Generación del directorio
mkdir('tmp')
fichero = ['tmp','\Toma ',PosMic,' - Sine Sweep de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.wav'] %Guardo el Ss en la ruta con sus caracteristicas
audiowrite(fichero,Ss,s)

%Repito la cantidad Rep de veces la señal con tiempo TEspera entre cada repeticion

for n = 1:Rep
    FGrabado  = [folder,'\Toma ',PosMic,' - ',num2str(n),'° muestra - ',num2str(f1),' a ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.wav'] %nombre del archivo de salida
    ReproducirAudio(fichero,FGrabado,Placa,s) %Inicio la reproduccion y grabacion
    pause(T + TEspera) % Wait hasta la proxima ejecucion
end
delete [folder,'\',fichero];
%Exportar filtro inverso del sine sweep generado
p = flip(Ss);
w = (K/L)*exp(t/L); %Genero la relación del filtro inverso
m = (f1*2*pi)./(2*pi*w); %Genero el filtro inverso/modulación
k = m.*p; %Se aplica el filtro inverso al Sine Sweep
%save([folder,'\Filtro de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.mat'],'k') %se exporta el vector del filtro inverso.
fichero = [folder,'\Filtro de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.wav'];
audiowrite(fichero,k,s);
end

