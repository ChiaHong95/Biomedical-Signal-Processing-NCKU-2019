clear;close all;
eegf3=load('eeg1-f3.dat');f3=eegf3(420:496);
eego1=load('eeg1-o1.dat');o1=eego1(420:496);
fs=100;t=(1:length(eegf3))/fs;
figure;
subplot(311);plot(t(420:496),f3);
xlabel('Time in seconds');ylabel('eeg1-f3');
N=length(f3);
[c lag]=xcorr(f3,'coeff');
lag1=lag(N:end);
c1=c(N:end);
subplot(312);plot(lag1/fs,c1);
xlabel('Delay in seconds');ylabel('Autocorrelation(coeff)');

y= fft(c1);
len = length(c1);
fd=fs/len;
f = 0: fd:fs/2;
F_amp=abs(y).*2/len;
F_amp = F_amp(1:fix(len/2)+1);
subplot(313);
plot(f,F_amp);
xlabel('f (Hz)');
ylabel('Amp');
[pks,loc] = findpeaks(F_amp,'minpeakheight',0.1);
title ( ['Single-Sided eeg1-f3 frequency spectra: amp = ', num2str(F_amp(loc)),' at freq= ',num2str(f(loc)),' Hz']);


figure;
subplot(311);plot(t(420:496),o1);
xlabel('Time in seconds');ylabel('eeg1-o1');
N=length(o1);
[c lag]=xcorr(o1,'coeff');
lag1=lag(N:end);
c1=c(N:end);
subplot(312);plot(lag1/fs,c1);
xlabel('Delay in seconds');ylabel('Autocorrelation(coeff)');

y= fft(c1);
len = length(c1);
fd=fs/len;
f = 0: fd:fs/2;
F_amp=abs(y).*2/len;
F_amp = F_amp(1:fix(len/2)+1);
subplot(313);
plot(f,F_amp);
xlabel('f (Hz)');
ylabel('Amp');
[pks,loc] = findpeaks(F_amp,'minpeakheight',0.1);
title ( ['Single-Sided eeg1-o1 frequency spectra: frequency= ',num2str(f(loc)),' Hz']);


eego2=load('eeg1-o2.dat');o2=eego2(472:571);o1=eego1(472:571);
N=length(o2);
[c lag]=xcorr(o1,o2,'coeff');
t1=(1:N)/fs;
figure;subplot(411);plot(t1,o1);xlabel('Time in seconds');ylabel('eeg1-o1');
subplot(412);plot(t1,o2);xlabel('Time in seconds');ylabel('eeg1-o2');
subplot(413);plot(lag/fs,c);xlabel('Delay in seconds');ylabel({'Crosscorrelation';'coeff'});

y= fft(c);
len = length(c);
fd=fs/len;
f = 0: fd:fs/2;
F_amp=abs(y).*2/len;
F_amp = F_amp(1:fix(len/2)+1);
subplot(414);
plot(f,F_amp);hold on;
xlabel('f (Hz)');
ylabel('Amp');
[pks,loc] = findpeaks(F_amp,'minpeakheight',0.1);
plot(f(loc),F_amp(loc),'rx');
title ( ['Single-Sided frequency spectra: frequency= ',num2str(f(loc)),' Hz']);


f3=eegf3(472:571);
[c lag]=xcorr(o1,f3,'coeff');
figure;subplot(411);plot(t1,o1);xlabel('Time in seconds');ylabel('eeg1-o1');
subplot(412);plot(t1,f3);xlabel('Time in seconds');ylabel('eeg1-f3');
subplot(413);plot(lag/fs,c);xlabel('Delay in seconds');ylabel({'Crosscorrelation';'coeff'});

y= fft(c);
len = length(c);
fd=fs/len;
f = 0: fd:fs/2;
F_amp=abs(y).*2/len;
F_amp = F_amp(1:fix(len/2)+1);
subplot(414);
plot(f,F_amp);hold on;
xlabel('f (Hz)');
ylabel('Amp');
[pks,loc] = findpeaks(F_amp,'minpeakheight',0.1);
plot(f(loc),F_amp(loc),'rx');
title ( ['Single-Sided frequency spectra: frequency= ',num2str(f(loc)),' Hz']);

