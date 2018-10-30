[y1,Fs]=audioread('mike.wav');
[y2]=audioread('street.wav');
y3=y1+y2; %combine mike.wav and street.wav

NFFTm=length(y1);
Xm=fftshift(fft(y1,NFFTm));            %apply fft to mike.wav
fValsm=(-NFFTm/2:NFFTm/2-1)/NFFTm;     %normalize frequency 
figure;
subplot(3,1,1);
plot(fValsm,abs(Xm),'r');              %plot frequency domain of mike.wav
title('frequency domain representation of mike.wav');
xlabel('normalized frequency');

NFFTs=length(y2);
Xs=fftshift(fft(y2,NFFTs));            %apply fft to street.wav 
fValss=(-NFFTs/2:NFFTs/2-1)/NFFTs;     %normalize frequency 
subplot(3,1,2);
plot(fValss,abs(Xs));                  %plot frequency domain of street.wav
title('frequency domain representation of street.wav');
xlabel('normalized frequency');

NFFT=length(y3);
X=fftshift(fft(y3,NFFT));               %apply fft to street.wav+mike.wav
fVals=(-NFFT/2:NFFT/2-1)/NFFT;          %normalize frequency
subplot(3,1,3);
plot(fVals,abs(X),'g');            %plot frequency domain of combined sound    
title('frequency domain representation of mike.wav+street.wav');
xlabel('normalized frequency');

figure;
t=linspace(0,length(y1)/Fs,length(y1));     
subplot(3,1,1);
plot(t,y1,'r');                     %plot time domain of mike.wav
title('time domain representation of mike.wav');

t=linspace(0,length(y2)/Fs,length(y2));
subplot(3,1,2);
plot(t,y2);                         %plot time domain of street.wav
title('time domain representation of street.wav');

t=linspace(0,length(y3)/Fs,length(y3));
subplot(3,1,3);
plot(t,y3,'g');                     %plot time domain of combined sound
title('time domain representation of street.wav+mike.wav');

%filter between 200 hertz and 3000 hertz
[m,n] = butter(8, [200/(Fs/2), 3000/(Fs/2)], 'bandpass');
y4 = filter(m, n, y3);
sound(y4,Fs);                       %listen filtered sound

figure;
subplot(2,1,1);
plot(fValsm,abs(Xm),'r');            %plot frequency domain of mike.wav
title('frequency domain representation of mike.wav');
xlabel('normalized frequency');

NFFT=length(y4);
X=fftshift(fft(y4,NFFT));           %apply fft to filtered sound
fVals=(-NFFT/2:NFFT/2-1)/NFFT;      %normalize frequency
subplot(2,1,2);
plot(fVals,abs(X),'g');            %plot frequency domain of filtered sound
title('frequency domain representation of filtered street.wav+mike.wav');
xlabel('normalized frequency');
aaaaaa=10*log(abs(X));
figure;
t=linspace(0,length(y1)/Fs,length(y1));
subplot(2,1,1);
plot(t,y1,'r');                             %plot time domain of mike.wav
title('time domain representation of mike.wav');

t=linspace(0,length(y4)/Fs,length(y4));
subplot(2,1,2);
plot(t,y4,'g');                         %plot time domain of filtered sound
title('time domain representation of filtered street.wav+mike.wav');

%calculate SNR value of mike.wav and filtered sound
  t1=0;
  t2=0;
    for p=1:length(y1)
        t1=t1+y1(p)*y1(p);
        t2=t2+(y4(p)-y1(p))*(y4(p)-y1(p));
    end
    
 SNR=10*log10(t1/t2);
