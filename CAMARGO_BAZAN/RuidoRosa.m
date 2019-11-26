function RuidoRosa(t,Sr)
%Funcion RuidoRosa
%Esta funcion genera un ruido rosa aleatorio con sus propiedades 1/f ( Caida de 3dB por octaba) y lo reproduce
%Variables de entrada:
%t = Tiempo en segundos
Tiempo = Sr*t;  % Numero de Samples a generar
B = [0.049922035 -0.095993537 0.050612699 -0.004408786]; %Vectores generadores de caida de 3dB por octaba
A = [1 -2.494956002   2.017265875  -0.522189400]; %Vectores generadores de caida de 3dB por octaba
nT60 = round(log(1000)/(1-max(abs(roots(A))))); % T60 est.
v = randn(1,Tiempo+nT60); % Genero Ruido Blanco
x = filter(B,A,v);    % Aplico filtro 1/F al ruido blanco
x = x(nT60+1:end);    % Salto respuesta transitoria
sound(x,Sr) %Reproduzco el Ruido Rosa generado
audiowrite('testaudio.wav',x,Sr)
