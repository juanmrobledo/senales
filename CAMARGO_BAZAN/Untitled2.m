Genero interfaz grafica

P1 = figure('Position',[100 100 1000 500]);
Seccion2 = uipanel('Position',[.01 .31 .5 .69],...
                   'Title','Filtro');
Seccion1 = uipanel(Seccion2,'Position',[.02 .02 .96 .18],...
                   'Title','Datos de la se�al de entrada');

ImportarImpulso = uicontrol(Seccion1,'Style','pushbutton',...
    'Units','normalized',...
    'String','Importar',...
    'CallBack','importarArchivos(Sweeps grabados y filtros inversos)',...
    'Position',[.56 .3 .3 .45]);
%          
% ImportarSweepconFiltro = uicontrol(Seccion2,'Style','pushbutton',...
%     'Units','normalized',...
%     'String','Importar',...
%     'CallBack',@Analisis,...
%     'Position',[.56 .3 .3 .45]);
%           
% ImportarSweepsinFiltro = uicontrol(Seccion2,'Style','pushbutton',...
%     'Units','normalized',...
%     'String','Importar',...
%     'CallBack',@Analisis,...
%     'Position',[.56 .3 .3 .45]);
% 
% %% Para exportar tabla
% tabla_exportar = uicontrol('parent',dspfigure,'style','pushbutton','string','Exportar tabla',...
%         'units','normalized','position',[0.48 0.02 0.1 0.05],'callback',{@exportar_csv,tabladsp});
    
% A�adir IR externo
%     [file,path] = uigetfile('*.wav','Seleccione Impulso que desea importar','','MultiSelect','on');
%     file = string(file);
%     for i=1:length(file)
%         copyfile([path char(file(i))],'Sweeps grabados y filtros inversos')
%     end
%     
%    ['[file,path] = uigetfile(''*.wav'',''Seleccione Impulso que desea importar'','',''MultiSelect'',''on''),',...
%        'file = string(file),','for i=1:length(file),','copyfile([path char(file(i))],''Impulsos''),','end']