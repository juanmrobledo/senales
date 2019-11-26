function Tp1

%Genero interfaz grafica
P1 = figure('Position',[100 100 1000 500]);


%Defino paneles principales
Seccion2 = uipanel('Position',[.01 .31 .5 .69],...
                   'Title','Filtro');
Seccion1 = uipanel(Seccion2,'Position',[.02 .02 .96 .18],...
                   'Title','Datos de la se�al de entrada');
Seccion3 = uipanel('Position',[.01 .01 .98 .3],...
                   'Title','Tabla'); 
Seccion4 = uipanel('Position',[.515 .31 .475 .69],...
                   'Title','Tabla');
               
%Genero grafico
Grafico = axes('Parent',Seccion4,'position',[0.1 0.27  0.8 0.65],'Box','on');

%Genero panel deslizable de frecuencias para el grafico
Frecuencias = uicontrol(Seccion4,'Style','popupmenu',...
                        'Units','normalized',...
                        'Position',[0.35 0.02 0.3 0.1],...
                        'String', '',...
                        'Callback', @ActualizarGrafico);

%Defino datos principales  
f1 = uicontrol(Seccion1,'Style','edit',...
    'Units','normalized',...
    'String','88',...
    'Position',[.08 .1 .15 .4]);

f2 = uicontrol(Seccion1,'Style','edit',...
    'Units','normalized',...
    'String','11314',...
    'Position',[.31 .1 .15 .4]);

sr = uicontrol(Seccion1,'Style','edit',...
    'Units','normalized',...
    'String','44100',...
    'Position',[.54 .1 .15 .4]);

t = uicontrol(Seccion1,'Style','edit',...
    'Units','normalized',...
    'String','30',...
    'Position',[.77 .1 .15 .4]);
align([f1 f2 sr t],'distribute','bottom');

tf1 = uicontrol(Seccion1,'Style','text',...
    'Units','normalized',...
    'String','F minima',...
    'Position',[.08 .5 .15 .4]);
tf2 = uicontrol(Seccion1,'Style','text',...
    'Units','normalized',...
    'String','F maxima',...
    'Position',[.31 .5 .15 .4]);
tsr = uicontrol(Seccion1,'Style','text',...
    'Units','normalized',...
    'String','Sample Rate',...
    'Position',[.50 .5 .23 .4]);
tt = uicontrol(Seccion1,'Style','text',...
    'Units','normalized',...
    'String','Tiempo',...
    'Position',[.77 .5 .15 .4]);

%Lista de archivos%
Impulsos = dir(fullfile(pwd,'\Impulsos\*.wav') )
Impulsos = {Impulsos.name}

DirectorioImpulsos = uicontrol(Seccion2,'Style','text',...
    'Units','normalized',...
    'String','\Impulsos',...
    'Position',[.1 .472 .15 .4]);

%MI LISTA DE IMPULSOS 
ListaImpulsos = uicontrol(Seccion2,'Style','listbox',...
    'Units','normalized',...
    'String',Impulsos,...
    'Position',[.04 .42 .28 .4]);
%CARGO MI LISTA DE ARCHIVO
ImportarI = uicontrol(Seccion2,'Style','pushbutton',...
    'Units','normalized',...
    'String','Importar Impulso',...
    'CallBack',@ImportarImpulso,...
    'Position',[.04 .31 .28 .1]);

function ImportarImpulso(src,event)
        importarArchivos('Impulsos','Impulso');
        Impulsos = dir(fullfile(pwd,'\Impulsos\*.wav') )
        Impulsos = {Impulsos.name}
        ListaImpulsos.String = Impulsos
end

SsGrabados = dir(fullfile(pwd,'\Sweeps grabados y filtros inversos\Toma*.wav') )
SsGrabados = {SsGrabados.name}

DirectorioSsG = uicontrol(Seccion2,'Style','text',...
    'Units','normalized',...
    'String','\Sweeps grabados y filtros inversos',...
    'Position',[.41 .472 .5 .4]);
%CARGO MI LISTA DE SINE SWEEP
ListaSsG = uicontrol(Seccion2,'Style','listbox',...
    'Units','normalized',...
    'String',SsGrabados,...
    'Position',[.36 .42 .28 .4]);

ImportaSsGrabados = uicontrol(Seccion2,'Style','pushbutton',...
    'Units','normalized',...
    'String','Importar Sine Sweep',...
    'CallBack',@ImportarSineSweep,...
    'Position',[.36 .31 .28 .1]);
function ImportarSineSweep(src,event)
        importarArchivos('Sweeps grabados y filtros inversos','Toma');
        SsGrabados = dir(fullfile(pwd,'\Sweeps grabados y filtros inversos\Toma*.wav') )
       SsGrabados = {SsGrabados.name}
        ListaSsG.String = SsGrabados
end

FiGrabados = dir(fullfile(pwd,'\Sweeps grabados y filtros inversos\Filtro*.wav') )
FiGrabados = {FiGrabados.name}

%cARGO MI LISTA DE FILTROS
ListaFi = uicontrol(Seccion2,'Style','listbox',...
    'Units','normalized',...
    'String',FiGrabados,...
    'Position',[.68 .42 .28 .4]);
ImportarI = uicontrol(Seccion2,'Style','pushbutton',...
    'Units','normalized',...
    'String','Importar Filtro',...
    'CallBack',@ImportarFiltro,...
    'Position',[.68 .31 .28 .1]);

function ImportarFiltro(src,event)
        importarArchivos('Sweeps grabados y filtros inversos','Filtro');
        FiGrabados = dir(fullfile(pwd,'\Sweeps grabados y filtros inversos\Filtro*.wav') )
        FiGrabados = {FiGrabados.name}
        ListaFi.String = FiGrabados
end


%Tipo de analisis
Analisis = uibuttongroup(Seccion2,'Position',[0.04 0.89 0.922 0.095]);   %Defino Grupo de botones radio
Analisis1 = uicontrol(Analisis,'Style','radiobutton',...    %Genero boton radio Otaba
    'Units','normalized',...
    'String',{'Impulso'},...
    'CallBack',@Analisis1Seleccion,...
    'Position',[.09 .3 .9 .5]);
Analisis2 = uicontrol(Analisis,'Style','radiobutton',...    %Genero boton radio Tercio
    'Units','normalized',...
    'String',{'Sine Sweep con Fi'},...
    'CallBack',@Analisis2Seleccion,...
    'Position',[.38 .3 .9 .5]);
Analisis3 = uicontrol(Analisis,'Style','radiobutton',...    %Genero boton radio Tercio
    'Units','normalized',...
    'String',{'Sine Sweep sin Fi'},...
    'CallBack',@Analisis3Seleccion,...
    'Position',[.72 .3 .9 .5]);

Analisis1.Value = 0    %Apago los botones para que no esten seleccionados
Analisis2.Value = 0    %Apago los botones para que no esten seleccionados

%Filtros%
Filtros = uibuttongroup(Seccion4,'Position',[0.01 0.02 0.18 0.15]);   %Defino Grupo de botones radio
TipoOctaba = uicontrol(Filtros,'Style','radiobutton',...    %Genero boton radio Otaba
    'Units','normalized',...
    'String',{'Octaba'},...
    'Position',[.15 .1 .9 .5]);
TipoTercio = uicontrol(Filtros,'Style','radiobutton',...    %Genero boton radio Tercio
    'Units','normalized',...
    'String',{'Tercio'},...
    'Position',[.15 .5 .9 .5]);
TipoTercio.Value = 0    %Apago los botones para que no esten seleccionados
TipoOctaba.Value = 0    %Apago los botones para que no esten seleccionados



%Genero boton%
GenerarBoton = uicontrol(Seccion2,'Style','pushbutton',...
    'Units','normalized',...
    'String','Calcular datos',...
    'CallBack',@VerificadorDeAnalisis,...
    'Position',[.02 .2 .96 .1]);
%Genero tabla para %
Tabla1 = uitable(Seccion3,...
    'Units','normalized',...
    'Position',[0.015 0.05 0.98 0.95],...
    'RowName',{'Edt','Tr10','Tr20','Tr30'});

function VerificadorDeAnalisis(src,event)
    if (TipoTercio.Value==1) | (TipoOctaba.Value==1)
            if (Analisis3.Value == 1)
                Actualizar1;
            else
                if (Analisis2.Value == 1)
                    Actualizar2;
                else
                    if (Analisis1.Value == 1)
                        Actualizar3;
                    else
                        msgbox("Seleccionar que tipo de analisis desea realizar")
                    end
                end
            end
            
        else
            msgbox('Seleccionar el tipo de filtro a utilizar')
    end
end



%Funcion si ingreso Sine Sweep grabado y datos para generar el filtro inverso
    function Actualizar1(src,event)
		try
        %Carga el Sine Sweep grabado .wav
        Folder = 'Sweeps grabados y filtros inversos\'
		Signal.Name = ListaSsG.String{ListaSsG.Value}
        FileSs = [Folder,Signal.Name];
		Signal = audioinfo(FileSs);
		Signal.Audio = audioread(FileSs);
        
        %Obtiene datos del Filtro Inverso a generar
        Signal.Fmin = str2num(f1.String);
        Signal.Fmax = str2num(f2.String);
        Signal.Tiempo = str2num(t.String);
        Signal.SampleRate = str2num(sr.String);
        
        Datos = Generador_Ss_y_Fi(Signal) % .Fi (FIltro Inverso) / .Ss (Sine Sweep)
        ImpulsoSinNormalizar = Generador_Impulso(Datos,Signal); % Sale ImpulsoSinNormalizar = h
        AnalisisGeneral(ImpulsoSinNormalizar,Signal);
        catch
            msgbox("Parametros de entrada invaldos, revisar")
        end
        
    end
%Funcion si ingreso Sine Sweep grabado y filtro inverso
    function Actualizar2(src,event)
		try
        %Obtiene datos del la reproduccion del audio
		
        Folder = 'Sweeps grabados y filtros inversos\'
        Signal.SampleRate = str2num(sr.String);
        
        %Carga el Sine Sweep grabado .wav
        
        Signal.Name = ListaSsG.String{ListaSsG.Value}
        FileSs = [Folder,Signal.Name]
		Signal = audioinfo(FileSs);
		Signal.Audio = audioread(FileSs);
        length(Signal.Audio)
		
		Signal.NameFi = ListaFi.String{ListaFi.Value}
        FileFi = [Folder,Signal.NameFi];
		Datos.Fi = audioread(FileFi);
        Datos.Fi = Datos.Fi';
		
        ImpulsoSinNormalizar = Generador_Impulso(Datos,Signal); % Sale ImpulsoSinNormalizar = h
        AnalisisGeneral(ImpulsoSinNormalizar,Signal);
        catch
            msgbox("El filtro seleccionado no corresponde al audio, verificar las selecciones por favor")
        end
        
    end   
%Funcion si ingreso un impulso grabado
    function Actualizar3(src,event)
		%Carga el Impulso grabado .wav
        try
        Folder = 'Impulsos\'
        Audio = ListaImpulsos.String(ListaImpulsos.Value)
        File = [Folder,Audio{1}];
        Signal = audioinfo(File)
        ImpulsoSinNormalizar = audioread(File);
		
        
        AnalisisGeneral(ImpulsoSinNormalizar,Signal);
        catch
            msgbox("El impulso seleccionado no corresponde a un audio a analizar, verificar")
        end
        
        end

	
	
    function Analisis1Seleccion(src,event)
    ListaImpulsos.Visible = true
    ListaSsG.Visible = false
    ListaFi.Visible = false
    
    DirectorioImpulsos.Visible = true
    DirectorioSsG.Visible = false
    
    end
    function Analisis2Seleccion(src,event)
    ListaImpulsos.Visible = false
    ListaSsG.Visible = true
    ListaFi.Visible = true
    
    DirectorioImpulsos.Visible = false
    DirectorioSsG.Visible = true
    DirectorioSsG.Position = [.262 .472 .8 .4]
   
    end
    function Analisis3Seleccion(src,event)
    ListaImpulsos.Visible = false
    ListaSsG.Visible = true
    ListaFi.Visible = false
    
    DirectorioImpulsos.Visible = false
    DirectorioSsG.Visible = true
    
    DirectorioSsG.Position = [.11 .472 .8 .4]
    
    end
    function ActualizarGrafico(src,event)
        f = Frecuencias.Value;
        GraficosParametros(f);
        hold off

    end

    function AnalisisGeneral(ImpulsoSinNormalizar,Signal)
        Impulso = Normalizar(ImpulsoSinNormalizar,Signal.SampleRate); % Sale .Audio (Se�al Normalizada) / .SampleRate (SampleRate)
        
        %Reproduzco el impulso
		sound(Impulso.Audio,Impulso.SampleRate)
        
        %Defino los valores del filtro para poder hacer los calculos
        %finales
        global Titulo
        
        if (TipoTercio.Value==1)
            TipoFiltro = 3
            CantFiltros = 23-1
            Titulo = 'Tercio de Octaba'
            NombreFiltros = {'80 Hz','100 Hz','125 Hz','160 Hz','200 Hz','250 Hz','315 Hz','400 Hz','500 Hz','630 Hz','800 Hz','1000 Hz','1250 Hz','1600 Hz','2000 Hz','2500 Hz','3150 Hz','4000 Hz','5000 Hz','6300 Hz','8000 Hz','10000 Hz'}
        else
            if (TipoOctaba.Value==1)
                TipoFiltro = 8
                CantFiltros = 8-1
                Titulo = 'Octaba'
                NombreFiltros = {'125 Hz','250 Hz','500 Hz','1000 Hz','2000 Hz','4000 Hz','8000 Hz'}
            else
                msgbox('Seleccionar un filtro')
            end
        end

        
        %Aplico filtro segun TipoFiltro
        AudioFiltradoEnF = Aplica_Filtro(Impulso.Audio,Impulso.SampleRate,TipoFiltro); % Sale .Audio(1,1:f) (Audio filtrado en f) / .Sr (SampleRate)
        
        %Genero tabla para vaciarla%
        Tabla1 = uitable(Seccion3,...
            'Units','normalized',...
            'Position',[0.015 0.05 0.98 0.95],...
            'RowName',{'Edt','Tr10','Tr20','Tr30'});
        
		%Cargo tabla con nombre de filtros
        Tabla1.ColumnName = NombreFiltros
		%Cargo menu desplegable abajo del grafico
        Frecuencias.String = NombreFiltros


        for i = 1:CantFiltros 
            %Suaviso la se�al con Hilbert - MAF y Schroeder
            global z t_plot_shroeder w a
			
			
            [h_t,SignalDb,h_t_MAF,t_h_Schro,ImgSchroeder] = suavizadoconlim(AudioFiltradoEnF.Audio{1,i+1},AudioFiltradoEnF.Sr);
            z{i} = ImgSchroeder;
            t_plot_shroeder{i} = h_t;
            a{i} = t_h_Schro;
            w{i} = SignalDb;
			
			%Calculo EDT T10 T20 T30
            [EDT,T10,T20,T30] = calcular_parametros(ImgSchroeder,t_h_Schro);
            Tabla1.Data(1,i) = EDT
            Tabla1.Data(2,i) = T10
            Tabla1.Data(3,i) = T20
            Tabla1.Data(4,i) = T30
			
        end       
		GraficosParametros(1);
        Frecuencias.Value = 1
    end


end