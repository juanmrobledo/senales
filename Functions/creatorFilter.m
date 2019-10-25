function [octFiltBank,terFiltBank] = creatorFilter ()



%Frecuencias centraltes nominales por INTI Procedimiento específico: PEA11,
%IRAM 4081/77
octavaCentralNominal = [31.5 63 125 250 500 1000 2000 4000 8000 16000];
tercioCentralNominal = [25 31.5 40 50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 3500 3150 4000 5000 6300 8000 10000 12500 16000];
fs = 44100;

%% Generación de coeficientes para filtros de Octava

     octFiltBank = cell(length(octavaCentralNominal),2); %Banco de filtro
     
 for i = 1:length(octavaCentralNominal)
            lowBand = octavaCentralNominal(i)/2^(1/2);
            upBand = octavaCentralNominal(i)*2^(1/2);
            
            if fs == 44100 
                if upBand > 22050
                    upBand = 22050;
                end
            end
            
            octFiltBank{i,1} = octavaCentralNominal(i);  
            octFiltBank{i,2} = designfilt('bandpassiir', ...
                                          'FilterOrder',8, ...
                                          'HalfPowerFrequency1',lowBand, ...
                                          'HalfPowerFrequency2',upBand, ...
                                          'SampleRate',fs);                        
 end
 %fvtool(octFiltBank{6,2})
 %% Generación de coeficientes para filtros de Tercios de octava

     terFiltBank = cell(length(tercioCentralNominal),2); %Banco de filtro
     
   for i = 1:length(tercioCentralNominal)
              lowBand = tercioCentralNominal(i)/2^(1/6);
              upBand = tercioCentralNominal(i)*2^(1/6);

              if fs == 44100 
                  if upBand > 22050
                     upBand = 22050;
                     lowBand = lowBand-400;
                  end
              end

          terFiltBank{i,1} = tercioCentralNominal(i); 
          terFiltBank{i,2} = designfilt('bandpassiir', ...
                                        'FilterOrder',8, ...
                                        'HalfPowerFrequency1',lowBand, ...
                                        'HalfPowerFrequency2',upBand, ...
                                        'SampleRate',fs);       
     end

 
%% ploteo de filtro de octava en 1k para ejemplo


end