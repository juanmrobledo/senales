function ImpulsoSinNormalizar = Generador_Impulso(Datos,Signal)
Audio = Signal.Audio;
Fi = Datos.Fi;

length(Audio)
length(Fi)
Audio = [Audio' zeros(1,22050)];
padA = Audio;
padB = [Fi zeros(1,abs(length(Audio')-length(Fi)))];
length(padA)
length(padB)
h = ifft(fft(padA).*fft(padB));
ImpulsoSinNormalizar = h;
