
function [Suavizada, Regresion, Parametros] = main (Signal)

%Se ingresa con un array de la señal promediada
%Se crea un handle con la señal:
%  Signal.amplitudvector = array digital
%  Signal.SampleRate = Frecuencia de muestreo
%  Signal.Time = Duracion de IR


%%%%%%%%%%%%%%%%   FILTRADO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%



[Suavizada,Filtrado]= filtSuav(Signal);
Regresion = regLin(Suavizada);
Parametros = calcPar(Suavizada,Filtrado);


end

    function [Suavizada,Filtrado] = filtSuav(Signal)

    load('Coeficientesdefiltros.mat')
    
        Filtrado = struct('General', Signal.amplitudvector, 'Tercio', [0], 'Octava', [0]);
        Filtrado.Tercio = cell(1,29);
        Filtrado.Octava = cell(1,10);

for i=1:29
    Filtrado.Tercio{1,i} = filtfilt(terFiltBank{i,2},Signal.amplitudvector);
    Filtrado.Tercio{1,i} = Filtrado.Tercio{1,i}';
end


for i=1:10
    Filtrado.Octava{1,i} = filtfilt(octFiltBank{i,2},Signal.amplitudvector);
    Filtrado.Octava{1,i} = Filtrado.Octava{1,i}';
end


%% %%%%%%%%%%%%%%%%    SUAVIZADO   %%%%%%%%%%%%%%%


memoTemp = Signal.amplitudvector; %se salva archivo sin procesar

        Suavizada = struct('General', suavizado(Signal), 'Tercio', [0], 'Octava', [0]);
        Suavizada.Tercio = cell(1,29);
        Suavizada.Octava = cell(1,10);

for i=1:10
    Signal.amplitudvector = Filtrado.Octava{1,i};
    Suavizada.Octava{1,i} = suavizado(Signal);

end

for i=1:29
    Signal.amplitudvector = Filtrado.Tercio{1,i};
    Suavizada.Tercio{1,i} = suavizado(Signal);
end    
    
Signal.amplitudvector = memoTemp;
clear memoTemp
clear octFiltBank terFiltBank

    end

    function Regresion = regLin(Suavizada)


%general
    x = 1:length(Suavizada.General);
    [A,B] = cuadMin(x,Suavizada.General);
    coefGeneral = [A B];
    
%tercio
    coefTercio = zeros(length(Suavizada.Tercio),2);
    for i=1:29
        x = 1:length(Suavizada.Tercio{1,i});
        [A,B] = cuadMin(x,Suavizada.Tercio{1,i});
        coefTercio(i,:) = [A B];
    end   
    
%octava
    coefOctava = zeros(length(Suavizada.Octava),2);
    for i=1:10
        x = 1:length(Suavizada.Octava{1,i}); 
        [A,B] = cuadMin(x,Suavizada.Octava{1,i});
        coefOctava(i,:) = [A B];
    end
    
    
    Regresion = struct('General', coefGeneral, 'Tercio', coefTercio, 'Octava', coefOctava);

    end

    function Parametros = calcPar(Suavizada,Filtrado)

%Ajuste de dimension de matriz
%     Tempo = Signal.Duracion*Signal.SampleRate;
%     Tempo = zeros(1,Tempo);
    
    
%general 

% minDB = min(Suavizada.General);
% Tempo = Tempo-abs(minDB);
% Tempo(1:length(Suavizada.General)) = Suavizada.General;
% Suavizada.General = Tempo;

[EDT,T20,T30,C80,D50] = allparameters(Suavizada.General,Filtrado.General);
ParametrosGeneral = table(EDT,T20,T30,C80,D50,'RowNames',{'General'});

%tercio

Bandas = {'25','31.5','40','50','63','80','100','125','160','200','250','315',...
         '400','500','630','800','1000','1250','1600','2000','3500','3150',...
         '4000','5000','6300','8000','10000','12500','16000'};
        EDT = zeros(1,29);
        T20 = zeros(1,29);
        T30 = zeros(1,29);
%        T60 = zeros(1,29);
        C80 = zeros(1,29);
        D50 = zeros(1,29);
    for i=1:29
%         
%         minDB = min(Suavizada.Tercio{i});
%         Tempo = Tempo-abs(minDB);
%         Tempo(1:length(Suavizada.Tercio{1,i})) = Suavizada.Tercio{i};
%         Suavizada.Tercio{1,i} = Tempo;
%         
        [a_EDT,b_T20,c_T30,e_C80,f_D50] = allparameters(Suavizada.Tercio{i},Filtrado.Tercio{i});
        EDT(i) = a_EDT;
        T20(i) = b_T20;
        T30(i) = c_T30;
%        T60(i) = d_T60;
        C80(i) = e_C80;
        D50(i) = f_D50;
        
    end   
        EDT = EDT';
        T20 = T20';
        T30 = T30';
%        T60 = T60';
        C80 = C80';
        D50 = D50';
     ParametrosTercio = table(EDT,T20,T30,C80,D50,'RowNames',Bandas');




% octava

     Bandas = {'31.5','63','125','250','500','1000','2000','4000','8000','16000'};
        EDT = zeros(1,10);
        T20 = zeros(1,10);
        T30 = zeros(1,10);
%       T60 = zeros(1,10);
        C80 = zeros(1,10);
        D50 = zeros(1,10);
        
    for i=1:9
        
%         minDB = min(Suavizada.Octava{1,i});
%         Tempo = Tempo-abs(minDB);
%         Tempo(1:length(Suavizada.Octava{1,i})) = Suavizada.Octava{1,i};
%         Suavizada.Octava{1,i} = Tempo;
        
         [a_EDT,b_T20,c_T30,e_C80,f_D50] = allparameters(Suavizada.Octava{1,i},Filtrado.Octava{1,i});
        EDT(i) = a_EDT;
        T20(i) = b_T20;
        T30(i) = c_T30;
 %      T60(i) = d_T60;
        C80(i) = e_C80;
        D50(i) = f_D50;
        
    end  
        EDT = EDT';
        T20 = T20';
        T30 = T30';
%        T60 = T60';
        C80 = C80';
        D50 = D50';
     ParametrosOctava = table(EDT,T20,T30,C80,D50,'RowNames',Bandas');
     
    Parametros = struct('General', ParametrosGeneral, 'Tercio', ParametrosTercio, 'Octava', ParametrosOctava);
    
    end