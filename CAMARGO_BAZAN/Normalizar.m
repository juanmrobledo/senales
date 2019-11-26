function Salida = Normalizar(ImpulsoSinNormalizar,SampleRate)

h = ImpulsoSinNormalizar;
j = max(abs((h)));
h = h/j;

h = h';

k=find(abs(h-4*10^(-4)) > 0.1);
ImpulsoCortado = h(k:end);


if (length(ImpulsoCortado)>(SampleRate*2))
    ImpulsoCortado = h(k:k+SampleRate*2);
end

Salida.Audio = ImpulsoCortado;
Salida.SampleRate = SampleRate;