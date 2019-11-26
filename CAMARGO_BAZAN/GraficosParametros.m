function [plot_EDT,plot_T10,plot_T20,plot_T30,plot_schroeder] = GraficosParametros(banda)
%% GraficosParametros
%   Inputs:
%       banda = Banda que se desea graficar
%   Outputs:
%       plot_EDT = Elemento ploteo del EDT
%       plot_T10 = Elemento ploteo del T10
%       plot_T20 = Elemento ploteo del T20
%       plot_T30 = Elemento ploteo del T30
%       plot_schroeder = Elemento ploteo de Schroeder

global z t_plot_shroeder Titulo w a
[EDT,T10,T20,T30] = calcular_parametros(z{banda},t_plot_shroeder{banda});

TituloBanda = ['Señal filtrada en ',Titulo];
length(t_plot_shroeder{banda})
length(w{banda})
cla
plot(t_plot_shroeder{banda},w{banda});title(TituloBanda);xlabel('Tiempo [s]','Interpreter','latex'); ylabel('Amplitud [dB]','Interpreter','latex');
hold on
t = a{banda};

hold on
global a_0 a_1

recta_EDT = a_0.EDT + a_1.EDT * t;
plot_EDT = plot(t,recta_EDT,'g','LineWidth',1.5);
recta_T10 = a_0.T10 + a_1.T10 * t;
plot_T10 = plot(t,recta_T10,'y','LineWidth',1.5);
recta_T20 = a_0.T20 + a_1.T20 * t;
plot_T20 = plot(t,recta_T20,'r','LineWidth',1.5);
recta_T30 = a_0.T30 + a_1.T30 * t;
plot_T30 = plot(t,recta_T30,'m','LineWidth',1.5);
% plot(suavizadoporbanda{banda}.t_plot,suavizadoporbanda{banda}.h_t_MAF,'LineWidth',1);
plot_schroeder = plot(t,z{banda},'k','LineWidth',2);
legend('E(t)','EDT','T10','T20','T30','Schroeder')
ylim([-150 0]);
end