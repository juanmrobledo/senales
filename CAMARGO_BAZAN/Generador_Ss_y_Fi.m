function [Datos] = Generador_Ss_y_Fi(Signal)
%f1 = Frecuencia Minima
%f2 = Frecuencia Maxima
%T = Duracion del Ss (en segundos)
%s = Sample Rate
%FolderOut = Carpeta de destino

f1 = Signal.Fmin
f2 = Signal.Fmax
T = Signal.Tiempo
s = Signal.SampleRate

%Genero W1 y W2 respecto a las frecuencias
w1 = f1*2*pi;
w2 = f2*2*pi;

%Defino mi tiempo de duracion del Sine Sweep y la cantidad de muestras que
%este tiempo tiene
t=[0:1/s:T-1/s];
lt=length(t);
f=[w1:(w2-w1+1)/lt:w2-1];

L=T/(log(w2/w1)); %Coeficiente que divide al tiempo
K=(T*w1)/(log(w2/w1)); %Coeficiente que mutiplica la exponencial
Ss = sin(K*((exp(t/L))-1)); %Señal Sine Sweep de tiempo T
Datos.Ss = Ss;

%Genero el folder de salida temporal
folder = ['tmp']
mkdir(folder)

%Guardo el Ss en la ruta con sus caracteristicas
fichero = [folder,'\Sine Sweep de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.wav'] 
audiowrite(fichero,Ss,s)
%save([folder,'\Sine Sweep de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.mat'],'Ss')

%Genero el filtro inverso de mi Ss
p = flip(Ss);
w = (K/L)*exp(t/L); %Genero la relación del filtro inverso
m = (f1*2*pi)./(2*pi*w); %Genero el filtro inverso/modulación
k = m.*p; %Se aplica el filtro inverso al Sine Sweep

Datos.Fi = k;
%Guardo el Fi en la ruta con sus caracteristicas
%save([folder,'\Filtro de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.mat'],'k')
fichero = [folder,'\Filtro de ',num2str(f1),' hasta ',num2str(f2),' Hz - Duracion ',num2str(T),' Segundos.wav'] 
audiowrite(fichero,k,s)

