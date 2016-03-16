function [f,tfx] = transffourier(y, Nf, fe)
f = (0:Nf-1)/Nf*fe;
tfx = fft(y, Nf)/fe;
