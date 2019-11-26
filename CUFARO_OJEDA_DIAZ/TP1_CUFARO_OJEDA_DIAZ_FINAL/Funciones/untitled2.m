Fc = 1000;
f1 = Fc/2^(1/2);
f2 = Fc*2^(1/2);

filter = octaveFilter('FilterOrder', 8, ...
                    'CenterFrequency', Fc, 'Bandwidth', '1/3 octave', 'SampleRate', 44100)
        
fvtool(filter)