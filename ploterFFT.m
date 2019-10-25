%%No voy a codear un FFT, voy a importar .txt a partir de Audacity

dataFile = importdata('FFT Pink Noise.txt');
arrayFFT = dataFile.data;
arrayFFT = transpose(arrayFFT);
X = arrayFFT([1],:);
Y = arrayFFT([2],:);
plot(X,Y)
    title ('Ruido Rosa')
    xlabel ('Frecuencia [Hz]')
    ylabel ('Ganancia [dB]')
    grid on