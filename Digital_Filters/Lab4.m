clc;close all;clear all;

%% creating the  sounds
fs=8192;
duration=1
[s,t] = gamme(duration,fs);
Nf=length(s);

%sound(s,fs)
[f,tfx]=transffourier(s,Nf,fs);
xmin=250;
xmax=550;
ymax=0.6;
ymin=0

figure
plot(f,abs(tfx))
axis([xmin xmax ymin ymax])
title('Magnitude Spectrum Of Fourier Transform')
ylabel('|FCC|')
xlabel('f (Hz)')


%% parameters for low-pass filter

fc=420;                   %hz corresponds to the middle of the transition band lilited by fp and fa
Delta_f=200;               %Hz transition width
Ap=3;                     %db bandpass ripple
Aa=40;                    %dB stopband attenuation
DeltaA = 10^(-Aa/20);
EP = 1-abs((10^(-Ap/20)));
delta_landa=Delta_f/fs;
Lrect=ceil(0.9/delta_landa);
Fcutt = fc/fs;
Lhamming=ceil(3.3/delta_landa);
FP = fc-(0.5*Delta_f);
FA = fc+(0.5*Delta_f);
[Lkaiser,w,beta]=kaiserord([2*FP/fs 2*FA/fs],[1 0],[EP DeltaA]);




%%design FIR filter

%Rectangular Window
brect=fir1(Lrect,2*Fcutt,window(@rectwin,(Lrect+1)));
[Hrect, f] = freqz (brect, 1, 2000, fs);
Srect = 20*log10(abs(Hrect));
plot(f,Srect,'r');
hold all
title('Frequency Response of the different windows')
axis([0 1000 -140 5])
xlabel('f(Hz)');
ylabel('|H(f)|');


%hamming Window
bhamming=fir1(Lhamming,2*Fcutt,window(@hamming,Lhamming+1));
[Hhamming, fhamming] = freqz (bhamming, 1, 2000, fs);
Shamming = 20*log10(abs(Hhamming));
plot(f, Shamming, 'g');

%kaiser Window
bkaiser = kaiser(ceil(Lkaiser+1), beta);
hkaiser = fir1(Lkaiser,w,'low',bkaiser);
[Hkaiser, fkaiser] = freqz (hkaiser, 1, 2000, fs);
Skaiser = 20*log10(abs(Hkaiser));
plot(f,Skaiser);


%Filter Properties
plot([0 FP FP],[-Ap -Ap -Aa],'k',[FA FA fs/2],[-Ap -Aa -Aa],'k');
 legend('Rectangular Filters','Hamming Filters','Kaiser Filters','Filter Charateristics','Location','southwest')

 %% Comparing Impulse Responses
  figure
subplot(311);
plot(brect); title('Rectangular Window Impulse Response')
subplot(312);
plot(bhamming);title('Hamming Window Impulse Response')
subplot(313);
plot(hkaiser);title('Kaiser Window Impulse Response')

%% IIR Filters
%Butterworth
[nbutter , wb] = buttord(2*FP/fs,2*FA/fs,Ap,Aa);
[bbutter,abutter] = butter(nbutter,wb);
[Hbutter, fbutter] = freqz(bbutter, abutter, 2000, fs);
Sbutter = 20*log10(abs(Hbutter));
figure
plot(f, Sbutter);
hold all
title('Frequency Response of the IIR Filters')
axis([0 1000 -100 0])
xlabel('f(Hz)');
ylabel('|H(f)|');

%Chebyshev Polynomials
[nchebby1,wcbebby1] =  cheb1ord(2*FP/fs,2*FA/fs,Ap,Aa);
[nchebby2,wcbebby2] =  cheb2ord(2*FP/fs,2*FA/fs,Ap,Aa);

%Chebyshev1
[bchebby1,achebby1] = cheby1(nchebby1,Ap,wcbebby1,'low');
[Hchebby1, fchebby1] = freqz (bchebby1, achebby1, 2000, fs);
Schebby1 = 20*log10(abs(Hchebby1));
%figure
plot(f, Schebby1,'g');

%Chebyshev
[bchebby2,achebby2] = cheby2(nchebby2,Aa,wcbebby2,'low');
[Hchebby2, fchebby2] = freqz (bchebby2, achebby2, 2000, fs);
Schebby2 = 20*log10(abs(Hchebby2));


plot(f, Schebby2, 'red');
plot([0 FP FP],[-Ap -Ap -Aa],'k',[FA FA fs/2],[-Ap -Aa -Aa],'k');
legend('Butterworth Filter','Chebyshev1 Filter','Chebyshev2 Filter','Filter Charateristics','Location','southwest')

%% Phase Comparison
figure 
plot(fhamming,phase(Hhamming),'r');
axis([0 1000 -140 5])
title('Comparing the Phase between the Hamming Filter and Chebyshev1')
xlabel('f(Hz)');
ylabel('Phase');
hold all
plot(fchebby1,phase(Hchebby1),'g');
legend('Hamming Filter Phase', 'Chebyshev1 Filter Phase', 'Location','southwest')

%% Changing the Transition Width

fc=2500;                   %hz corresponds to the middle of the transition band lilited by fp and fa
Delta_f=10;               %Hz transition width
Ap=3;                     %db bandpass ripple
Aa=40;                    %dB stopband attenuation
DeltaA = 10^(-Aa/20);
EP = 1-abs((10^(-Ap/20)));
delta_landa=Delta_f/fs;
Fcutt = fc/fs;
Lhamming=ceil(3.3/delta_landa);
FP = fc-(0.5*Delta_f);
FA = fc+(0.5*Delta_f);
[Lkaiser,w,beta]=kaiserord([2*FP/fs 2*FA/fs],[1 0],[EP DeltaA]);

%hamming Window
bhamming=fir1(Lhamming,2*Fcutt,window(@hamming,Lhamming+1));
[Hhamming, fhamming] = freqz (bhamming, 1, 2000, fs);
Shamming = 20*log10(abs(Hhamming));
figure
plot(f, Shamming, 'g');
axis([0 1000 -140 5])
hold all
title('Frequency Response of Hamming Filter and Kaiser Filter with Delta_F = 80Hz and BW = 1dB')
axis([0 1000 -140 5])
xlabel('f(Hz)');
ylabel('|H(f)|');

%kaiser Window
bkaiser = kaiser(ceil(Lkaiser+1), beta);
hkaiser = fir1(Lkaiser,w,'low',bkaiser);
[Hkaiser, fkaiser] = freqz (hkaiser, 1, 2000, fs);
Skaiser = 20*log10(abs(Hkaiser));
plot(f,Skaiser);


%Filter Properties
plot([0 FP FP],[-Ap -Ap -Aa],'k',[FA FA fs/2],[-Ap -Aa -Aa],'k');
legend('Hamming Filter of Order = 338 ','Kaiser Filter of Order = 230','Filter Charateristics','Location','southwest')


%IIR
%Chebyshev Polynomials
[nchebby1,wcbebby1] =  cheb1ord(2*FP/fs,2*FA/fs,Ap,Aa);
[nchebby2,wcbebby2] =  cheb2ord(2*FP/fs,2*FA/fs,Ap,Aa);

%Chebyshev1
[bchebby1,achebby1] = cheby1(nchebby1,Ap,wcbebby1,'low');
[Hchebby1, fchebby1] = freqz (bchebby1, achebby1, 2000, fs);
Schebby1 = 20*log10(abs(Hchebby1));
figure
plot(f, Schebby1,'g');
hold all 
title('Frequency Response of Chebyshev1 Filter and Chebyshev2 Filter with Delta_F = 80Hz and BW = 1dB')
axis([0 1000 -100 0])
xlabel('f(Hz)');
ylabel('|H(f)|');

%Chebyshev
[bchebby2,achebby2] = cheby2(nchebby2,Aa,wcbebby2,'low');
[Hchebby2, fchebby2] = freqz (bchebby2, achebby2, 2000, fs);
Schebby2 = 20*log10(abs(Hchebby2));
plot(f, Schebby2, 'red');
plot([0 FP FP],[-Ap -Ap -Aa],'k',[FA FA fs/2],[-Ap -Aa -Aa],'k');
legend('Chebyshev1 Filter of Order = 10','Chebyshev2 Window Filter of Order = 10','Filter Charateristics','Location','southwest')


 %Filter the signal with Chebyshev
 z = filter(bchebby2,achebby2,s);
 figure
 subplot(311);
 plot(z); title('Filtered signal in Time domain Delta_F = 20Hz')
 %axis([0 1000 -100 0])
 xlabel('t(s)');
 ylabel('|Z|');
 [f,tfz]=transffourier(z,Nf,fs);
 subplot (312) 
 plot(f,abs(tfz)); title('Frequency Spectrum of the Filtered signal Delta_F = 20Hz')
 axis([200 550 0 0.6]);
 xlabel('f(Hz)');
 ylabel('|TFZ(f)|');
 
 %sound(z,fs);
 
 
 %NewBandstopfilter
 
 fcl = 340;
 fch = 360;
 DeltaF = 10;
 Ap = 3;
 Aa = 40;
 fpl = fcl -  DeltaF/2;
 fal = fcl +  DeltaF/2;
 fah = fch -  DeltaF/2;
 fph = fch +  DeltaF/2;
 
 %Orderofthefilter
 [nchebstop wchebstop] = cheb2ord([2*fpl/fs 2*fph/fs] , [2*fal/fs 2*fah/fs] ,Ap,Aa );
 [bchebstop,achebstop] = cheby2(nchebstop,Aa,wchebstop,'stop');
 [Hchebstop, fchebstop] = freqz (bchebstop, achebstop, Nf, fs);
 Schebstop = 20*log10(abs(Hchebstop));
 figure
 plot(fchebstop, Schebstop);
 title('Chebyshev stop filter Impulse Response')
 xlabel('f(Hz)');
 ylabel('|TFZ(f)|');
 axis([320 380 -100 0])

 %Filteringwith Chebystop
 z = filter(bchebstop,achebstop,s);
 figure
 subplot(311);
 plot(z); title('Filtered signal in Time domain of the signal filtered with Chebyshev Bandstop Filter')
 %axis([0 1000 -100 0])
 xlabel('t(s)');
 ylabel('|Z|');
 [f,tfz]=transffourier(z,Nf,fs);
 subplot (312) 
 plot(f,abs(tfz)); title('Frequency Spectrum of the signal filtered with Chebyshev Bandstop Filter')
 axis([200 550 0 0.6]);
 xlabel('f(Hz)');
 ylabel('|TFZ(f)|');
 

 %sound(z,fs);
 
  %Reading the Noisy signal
  [y2, fs2] = audioread('sonbruite.wav');
  figure
  subplot(311);
  plot(y2); title('Original Noisy Signal')
  xlabel('t(s)');
  ylabel('|Z|');
  %sound(y2,fs2);
  [f2,tfy2]=transffourier(y2,Nf,fs2);
  subplot(312);
  plot(f2,abs(tfy2)); title('Frequency domain showing where the noise exists')
  axis([0 4000 0 0.06]);
   xlabel('f(Hz)');
   ylabel('|TFZ(f)|');
   
   
   %% Filter the signal with Chebyshev
fc= 2500;                   %hz corresponds to the middle of the transition band lilited by fp and fa
Delta_f=100;               %Hz transition width
Ap=3;                     %db bandpass ripple
Aa=40;                    %dB stopband attenuation
delta_landa=Delta_f/fs;
FP = fc-(0.5*Delta_f);
FA = fc+(0.5*Delta_f);
[nbutter , wb] = buttord(2*FP/fs2,2*FA/fs2,Ap,Aa);
[bbutter,abutter] = butter(nbutter,wb);
   
 z = filter(bbutter,abutter,y2);
 figure
 subplot(311);
 plot(z); title('Filtered signal in Time domain with Butterworth Lowpass filter Delta_F = 10Hz, fc = 2500HZ, Ap = 3dB, Aa = 40dB ')
 %axis([0 1000 -100 0])
 xlabel('t(s)');
 ylabel('|Z|');
 sound(z,fs2);
 [f,tfz]=transffourier(z,Nf,fs2);
 subplot (312) 
 plot(f,abs(tfz)); title('Frequency Spectrum of the signal filtered with Butterworth Lowpass filter Delta_F = 10Hz, fc = 2500HZ, Ap = 3dB, Aa = 40dB')
 %axis([200 550 0 0.6]);
 xlabel('f(Hz)');
 ylabel('|TFZ(f)|');
  
  
  
 
 
 








