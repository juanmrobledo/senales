
function [Suavizada, Regresion, Parametros] = main (Signal)

%Se ingresa con un array de la señal promediada
%Se crea un handle con la señal:
%  Signal.amplitudvector = array digital
%  Signal.SampleRate = Frecuencia de muestreo
%  Signal.Time = Duracion de IR


%%%%%%%%%%%%%%%%   FILTRADO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%



Filtrado= myFilt(Signal);
Suavizada = mySuav(Filtrado);
Regresion = myReg(Suavizada);
Parametros = myParametros(Suavizada,Filtrado);


end

    function Filtrado = myFilt(Signal)

    load('Coeficientesdefiltros.mat')
    
        Filtrado = struct('General', Signal.amplitudvector, 'Tercio', [0], 'Octava', [0]);
        Filtrado.Tercio = cell(1,length(terFiltBank(:, 2)));
        Filtrado.Octava = cell(1,length(octFiltBank(:, 2)));

for i=1:length(Filtrado.Tercio)
    Filtrado.Tercio{i} = filtfilt(terFiltBank{i,2},Signal.amplitudvector);
    Filtrado.Tercio{i} = Filtrado.Tercio{i}';
end


for i=1:length(Filtrado.Octava)
    Filtrado.Octava{i} = filtfilt(octFiltBank{i,2},Signal.amplitudvector);
    Filtrado.Octava{i} = Filtrado.Octava{i}';
end

    end
    
    function Suavizada = mySuav(Filtrado)

% memoTemp = Signal.amplitudvector; %se salva archivo sin procesar

        Suavizada = struct('General', suavizado(Filtrado.General), 'Tercio', [0], 'Octava', [0]);
        Suavizada.Tercio = cell(1,length(Filtrado.Tercio));
        Suavizada.Octava = cell(1,length(Filtrado.Octava));

for i=1:length(Filtrado.Octava)
%     Signal.amplitudvector = Filtrado.Octava{1,i};
    Suavizada.Octava{i} = suavizado(Filtrado.Octava{i});

end

for i=1:length(Filtrado.Tercio)
%     Signal.amplitudvector = Filtrado.Tercio{1,i};
    Suavizada.Tercio{i} = suavizado(Filtrado.Tercio{i});
end    
    
% Signal.amplitudvector = memoTemp;

    end

    function Regresion = myReg(Suavizada)


%general
    x = 1:length(Suavizada.General);
    [A,B] = cuadMin(x,Suavizada.General);
    coefGeneral = [A B];
    
%tercio
    coefTercio = zeros(length(Suavizada.Tercio),2);
    for i=1:length(Suavizada.Tercio)
        x = 1:length(Suavizada.Tercio{i});
        [A,B] = cuadMin(x,Suavizada.Tercio{i});
        coefTercio(i,:) = [A B];
    end   
    
%octava
    coefOctava = zeros(length(Suavizada.Octava),2);
    for i=1:length(Suavizada.Octava)
        x = 1:length(Suavizada.Octava{1,i}); 
        [A,B] = cuadMin(x,Suavizada.Octava{1,i});
        coefOctava(i,:) = [A B];
    end
    
    
    Regresion = struct('General', coefGeneral, 'Tercio', coefTercio, 'Octava', coefOctava);

    end

    function Parametros = myParametros(Suavizada,Filtrado)


[EDT,T10,T20,T30,C80,D50] = allparameters(Suavizada.General,Filtrado.General);
ParametrosGeneral = table(EDT,T10,T20,T30,C80,D50,'RowNames',{'General'});

%% Tercio

Bandas = {'125','160','200','250','315',...
         '400','500','630','800','1000','1250','1600','2000','3500','3150',...
         '4000','5000','6300','8000'};
        EDT = zeros(1,length(Suavizada.Tercio));
        T10 = zeros(1,length(Suavizada.Tercio));
        T20 = zeros(1,length(Suavizada.Tercio));
        T30 = zeros(1,length(Suavizada.Tercio));
%        T60 = zeros(1,length(Suavizada.Tercio));
        C80 = zeros(1,length(Suavizada.Tercio));
        D50 = zeros(1,length(Suavizada.Tercio));
        
    for i=1:length(Suavizada.Tercio)
%         
%         minDB = min(Suavizada.Tercio{i});
%         Tempo = Tempo-abs(minDB);
%         Tempo(1:length(Suavizada.Tercio{1,i})) = Suavizada.Tercio{i};
%         Suavizada.Tercio{1,i} = Tempo;
%         
        [a_EDT,x_T10,b_T20,c_T30,e_C80,f_D50] = allparameters(Suavizada.Tercio{i},Filtrado.Tercio{i});
        EDT(i) = a_EDT;
        T10(i) = x_T10;
        T20(i) = b_T20;
        T30(i) = c_T30;
%        T60(i) = d_T60;
        C80(i) = e_C80;
        D50(i) = f_D50;
        
    end   
        EDT = EDT';
        T10 = T10';
        T20 = T20';
        T30 = T30';
%        T60 = T60';
        C80 = C80';
        D50 = D50';
     ParametrosTercio = table(EDT,T10,T20,T30,C80,D50,'RowNames',Bandas');




%% Octava

     Bandas = {'125','250','500','1000','2000','4000','8000'};
        EDT = zeros(1,length(Suavizada.Octava));
        T10 = zeros(1,length(Suavizada.Octava));
        T20 = zeros(1,length(Suavizada.Octava));
        T30 = zeros(1,length(Suavizada.Octava));
%       T60 = zeros(1,length(Suavizada.Octava));
        C80 = zeros(1,length(Suavizada.Octava));
        D50 = zeros(1,length(Suavizada.Octava));
        
    for i=1:length(Suavizada.Octava)
        
%         minDB = min(Suavizada.Octava{1,i});
%         Tempo = Tempo-abs(minDB);
%         Tempo(1:length(Suavizada.Octava{1,i})) = Suavizada.Octava{1,i};
%         Suavizada.Octava{1,i} = Tempo;
        
         [a_EDT,x_T10,b_T20,c_T30,e_C80,f_D50] = allparameters(Suavizada.Octava{1,i},Filtrado.Octava{1,i});
        EDT(i) = a_EDT;
        T10(i) = x_T10;
        T20(i) = b_T20;
        T30(i) = c_T30;
 %      T60(i) = d_T60;
        C80(i) = e_C80;
        D50(i) = f_D50;
        
    end  
        EDT = EDT';
        T10 = T10';
        T20 = T20';
        T30 = T30';
%        T60 = T60';
        C80 = C80';
        D50 = D50';
     ParametrosOctava = table(EDT,T10,T20,T30,C80,D50,'RowNames',Bandas');
     
    Parametros = struct('General', ParametrosGeneral, 'Tercio', ParametrosTercio, 'Octava', ParametrosOctava);
    
    end