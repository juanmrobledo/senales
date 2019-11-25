
%% Creado del Solido
model = createpde('structural','modal-solid');
importGeometry(model,'plato perforado.stl');
hc = pdegplot(model,'FaceLabels','on');
hc(1).FaceAlpha = 0.5;
title('Placa de 40x40 cm')

structuralProperties(model,'YoungsModulus',71e9, ...
                           'PoissonsRatio',0.33, ...
                           'MassDensity',2700);

structuralBC(model,'Face',1,'Constraint','fixed');
% structuralBC(model,'Vertex',3:6,'Constraint','multipoint','Reference',[0;0;1],'Radius',0.2)

generateMesh(model,'Hmin',75);
figure 
pdeplot3D(model);
title('Mallado con Elementos cuadráticos tetraédricos');

%% Modos

% refFreqHz = [0 0 0 45.897 109.44 109.44 167.89 193.59 206.19 206.19];
Frecuencias =  [120 200 400 800 1300 1800];

maxFreq = 1.1*Frecuencias(end)*2*pi;
result = solve(model,'FrequencyRange',[-0.1 maxFreq]);
% freqHz = result.NaturalFrequencies/(2*pi);
% tfreqHz = table(refFreqHz.',freqHz);
% tfreqHz.Properties.VariableNames = {'Reference','Computed'};
% disp(tfreqHz);

h = figure;
h.Position = [100,100,900,600];
numToPrint = length(Frecuencias);
for i = 1:numToPrint
    subplot(3,2,i);
    pdeplot3D(model,'ColorMapData',result.ModeShapes.uz(:,i));
    axis equal
%     title(sprintf(['Mode=%d, z-displacement\n', ...
%     'Frequency(Hz): Ref=%g FEM=%g'], ...
% 
%     i,refFreqHz(i),freqHz(i)));
    
        title(sprintf(['Frecuencia(Hz):%g'],Frecuencias(i)));
end