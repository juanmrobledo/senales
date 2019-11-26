function [t_plot,w,h_t_MAF,t_plot_shroeder,z] = suavizadoconlim(h_t,Fs)

%   Inputs:
%       h_t = Respuesta al impulso
%       Fs = Frecuencia de muestreo
%   Outputs:
%       t_plot = Vector tiempo
%       w = Señal normalizada en [dB]
%       h_t_MAF = Señal filtrada por media movil
%       t_plot_shroeder = Vector tiempo para Schroeder
%       z = Vector imagen de Schroeder

t_ir = numel(h_t)/Fs ; % Duración del audio
t_plot = 0:1/Fs:t_ir-1/Fs;
%% Señal normalizada en dB
w = 20*log10(abs(h_t)/max(abs(h_t)));
%% Hilbert 
% Referencias: --> https://la.mathworks.com/matlabcentral/answers/114442-how-to-design-a-moving-average-filter
%              -->https://dsp.stackexchange.com/questions/17121/calculation-of-reverberation-time-rt60-from-the-impulse-response/17123

A_t = abs(hilbert(h_t));%A(t)
E_t = 20*log10(A_t/max(A_t)); %E(t) Envolvente de hilbert en log scale

%% Moving Average Filter
windowWidth = 5000; %Ventana de integracion (A mayor valor, mayor suavisado)
kernel = ones(windowWidth,1) / windowWidth;
h_t_MAF = filter(kernel, 1, E_t);
 %% Limite de Shroeder
encuentro = Lundeby(t_plot,h_t_MAF,Fs);
%% Shroeder
lim_shroeder = encuentro;
shroeder(lim_shroeder:-1:1) = (cumsum(h_t(lim_shroeder:-1:1).^2)/(sum(h_t(1:length(h_t))).^2));   
z = 10 * log10(shroeder./max(abs(shroeder)));
t_plot_shroeder = 0:1/Fs:((encuentro-1)/Fs);

end
