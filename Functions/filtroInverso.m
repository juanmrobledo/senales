function [A] = filtroInverso(A)
%Funcion que genera y aplica el filtro inverso al vector de amplitudes
%   contenido en la estructura A, pertenecientes a una Sine Sweep. La
%   respuesta de la funci�n es una se�al de tipo impulsiva que contiene la
%   informaci�n del recinto


%Entradas
    a = A.data;
    o = A.f;
    f1=str2num(o{1}); %freq minima
    f2=str2num(o{2}); %freq maxima
    clear o
    fs = A.fs;
%Proceso de generaci�n del sweep y el filtro inverso
    t = length(a)/fs;
    K = (t*2*pi*f1)/log(f2/f1);
    L = t/log(f2/f1);
    T = 0:1/fs:t-1/fs; 
    sineSweep = sin(K*(exp(T/L)-1));
%Proceso de aplicaci�n del filtro inverso a la se�al
    w = K/L*exp(T/L);
    m = f1./w;
    k = m.*(flip(sineSweep));
    padA = [a' zeros(1,length(k)-1)];
    padK = [k zeros(1,length(a)-1)];
    h = ifft(fft(padA).*fft(padK));
    j = max(abs((h)));
    h = h/j;
%Salidas
    A= rmfield(A, 'f');
    A.data=h';
    
end
