function Temporizador(Tiempo_temporizador)
%Funcion que realiza cuenta regresiva con un pitido de aviso 
%Tiempo_temporizador: Tiempo que va a durar el temporadizado
Fs=44100;
t=[0:1/Fs:0.1];
y=sin(pi*2000*t);
for i=0:Tiempo_temporizador-1;
        sound(y,Fs);
        pause(1)
    if i==Tiempo_temporizador ;
    end 
end