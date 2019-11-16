function impulseresponsewav(y_t,f_min,f_max)
%%  Funcion impulseresponsewav
%   
%   impulseresponsewav(y_t,f_min,f_max)
%
%   Inputs:
%     y_t = La respuesta del sistema a una exitación impulsiva
%     f_min = Frecuencia minima de la exitación impulsiva (Sinesweep)
%     f_max = Frecuencia maxima de la exitación impulsiva (Sinesweep)
%
%   Nota: La señal 'y_t' debe ser cargada en formato .wav
%   Por ejemplo:
%           impulseresponsewav('nombre_del_audio.wav')

[y,Fs] = audioread(y_t); % Procesamiento del audio como vector de valores
Fs = 44100;
t_audio = numel(y)/Fs ; % Duración del audio
[k,K] = finvsinesweep_mute(f_min,f_max,(t_audio-1)/2); % Filtro inverso
k = [zeros(1,Fs) k zeros(1,Fs*((t_audio-1)/2))] ; % Se rellena el filtro inverso para que las dimensiones
convolution = conv(y,k,'same');                   % sean iguales entre la señal entrante y el filtro inverso 
convolution = convolution./(max(abs(convolution))) ;
t_plot = 0:1/Fs:(t_audio-1/Fs); % Vector tiempo para el ploteo
n_plot = 0:1/t_audio:(Fs - 1/t_audio); % Vector frecuencia para el ploteo
%%
subplot(2,1,1)
plot(t_plot,convolution); title('Respuesta al impulso') ; ylabel('Amplitud normalizada');xlabel('Tiempo [s]')

% subplot(2,1,2)
% Y = abs(fft(y));
% K = abs(K);               % Me tira error 'Out of memory'
% H = K.*Y ;                % Me tira error 'Out of memory'
% H = abs(H./max(H))
% semilogx(n_plot,20*log10(H))

subplot(2,1,2)
fftconvolution = fft(convolution);
fftconvolution = abs(fftconvolution./max(fftconvolution));
semilogx(n_plot,20*log10(fftconvolution));xlim([1 25000]);ylim([-100 0]); xlabel('Frecuencia [Hz]');ylabel('Amplitud normalizada [dB]')
grid on
%% Guardado de la respuesta al impulso en formato .wav
%name = ['IR'];
audiowrite('IR.wav',convolution,44100)

clear
%end