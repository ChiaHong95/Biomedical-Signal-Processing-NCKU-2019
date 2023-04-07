clear;close all;
ecg=load("ecg_hfn.dat");
figure;
in=ecg(1:715);
plot(in);grid on;title(['Original Signal / RMS = ',num2str(rms(ecg))]);

%% piece-wise model
pw=zeros(1,715);
pw(101:130)=linspace(0,0.4,30);
pw(131:170)=0.4;
pw(171:200)=linspace(0.4,0,30);
pw(272:293)=linspace(0,3.2,22);
pw(294:328)=linspace(3.2,-1.3,35);
pw(329:355)=linspace(-1.3,0,27);
pw(500:547)=linspace(0,0.7,48);
pw(548:567)=0.7;
pw(568:615)=linspace(0.7,0,48);
figure;
plot(pw);grid on;title('Signal by Manual');

%% weiner by model
N=715;
rxx = xcorr(ecg,N,'coeff');
rxx = rxx(N+1:end-1)'; 
rxy = xcorr(ecg,pw,N);
rxy = rxy(N+1:end-1);
rxx_matrix = toeplitz(rxx);
b = rxx_matrix\rxy;
b=b/N;
y=conv(b,ecg);
figure;

plot(ecg);grid on;title(['Original Signal / RMS = ',num2str(rms(ecg))]);
figure;
plot(y);grid on;title(['Weiner Filtered Signal / RMS = ',num2str(rms(y))]);

%% low pass 
d=movmean(ecg,16);
figure;
plot(d);title(['Moving Average Signal (16 pts) / RMS = ',num2str(rms(d))]);

%% PSD of model
Pxx=pwelch(y);
figure;
plot(Pxx(1:240));
%% fft
fs=1000;
L=length(ecg);f = fs*(0:(L/2))/L;
Y = fft(ecg);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
figure;plot(f,P1);title('Single-Sided Amplitude Spectrum of Original ecg');



