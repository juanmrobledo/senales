function importarArchivos(Ubicacion,Tipo)
 [file,path] = uigetfile('*.wav','Seleccione Impulso que desea importar','','MultiSelect','on');
    Archivo = string(file)
    for i=1:length(Archivo)
        [path char(Archivo(i))]
        ArchivoACopiar = [char(Ubicacion),char("\"),char(Tipo),char(" "),char(Archivo(i))]
        copyfile([path char(Archivo(i))],ArchivoACopiar)
    end
end

