clear;close all;
fnam = input('Enter the ECG file name :','s');
fid = fopen(fnam);
ecg = fscanf(fid,'%f ');
fs = 200; %sampling rate
sze = length(ecg);
necg = ecg/max(ecg); % normalize the maximum value to unity
time = [1 : sze]/fs;
ecg = ecg - mean(ecg);
figure;subplot(3,2,[1,2]);
plot(ecg);title([fnam,'  Raw ecg Signal']);
%% Low Pass Filter  H(z) = ((1 - z^(-6))^2)/(1 - z^(-1))^2 ==== 12Hz
Wn = 12*2/fs;
N = 3;                                                                  
[a,b] = butter(N,Wn,'low');                                             
ecg_l = filtfilt(a,b,ecg); 
ecg_l = ecg_l/ max(abs(ecg_l));

%% High Pass filter H(z) = (-1+32z^(-16)+z^(-32))/(1+z^(-1)) ==== 5Hz
Wn = 5*2/fs;
N = 3;                                                                  
[a,b] = butter(N,Wn,'high');                                            
ecg_h = filtfilt(a,b,ecg_l); 
ecg_h = ecg_h/ max(abs(ecg_h));
subplot(323);plot(ecg_h);
title("Band Pass Filtered");
%% derivative filter H(z) = (1/8T)(-z^(-2) - 2z^(-1) + 2z + z^(2))
b = [1 2 0 -2 -1].*(1/8)*fs;  
ecg_d = filtfilt(b,1,ecg_h);
ecg_d = ecg_d/max(ecg_d);
subplot(324);plot(ecg_d);
title("Derivative Filterd");
%% Squaring nonlinearly enhance the dominant peaks 
ecg_s = ecg_d.^2;
subplot(325);plot(ecg_s);title("Squared");
%% Moving average Y(nt) = (1/N)[x(nT-(N - 1)T)+ x(nT - (N - 2)T)+...+x(nT)]
% N=30 for fs=200Hz
% ecg_m = conv(ecg_s ,ones(1 ,round(0.150*fs))/round(0.150*fs));
% delay = delay + round(0.150*fs)/2;
ecg_m=movmean(ecg_s,30);
subplot(326);plot(ecg_m);title("Moving Average");
%%  Fiducial Marks

[pk,loc] = findpeaks(ecg_m,'MINPEAKHEIGHT',0.08,'MINPEAKDISTANCE',round(0.2*fs));
t=(1:sze)/fs;rate=length(loc)*60/t(end);
QRS=length(ecg_m)/(length(pk)*fs);%sec

%figure;plot(ecg_m);
% title([fnam,'   BPM= ',num2str(rate),' QRS width= ',num2str(QRS),' sec']);
% hold on;plot(loc,ecg_m(loc),'rx');
%% initialize the training phase get (signal level/noise level)

[pks,locs] = findpeaks(ecg_m,'MINPEAKDISTANCE',round(0.2*fs));
LLp = length(pks);
SIG_LEV = max(ecg_m(1:2*fs))*1/3;                                          
NOISE_LEV = mean(ecg_m(1:2*fs))*1/2;                                       
thres=NOISE_LEV+0.25*(SIG_LEV-NOISE_LEV);
%% Thresholding and desicion rule
Beat = 0;Noi = 0;T=0;                                                                
Noise_Count = 0;
figure;
a=plot(ecg_m);hold on;
Sx(1)=0;Sy=SIG_LEV;
Nx(1)=0;Ny=NOISE_LEV;
Tx(1)=0;Ty(1)=thres;
for i=1:LLp
    if  pks(i)>thres
        SIG_LEV=0.125*pks(i)+0.875*SIG_LEV;
        Beat=Beat+1;
        Sx(Beat+1)=locs(i);
        Sy(Beat+1)=SIG_LEV;
        q=plot(locs(i),pks(i),'m*');
    else
        NOISE_LEV=0.125*pks(i)+0.875*NOISE_LEV;      
      Noi=Noi+1;
      Nx(Noi+1)=locs(i);
      Ny(Noi+1)=NOISE_LEV;
    end
    thres=NOISE_LEV+0.25*(SIG_LEV-NOISE_LEV);
    T=T+1;
    Tx(T+1)=locs(i);
    Ty(T+1)=thres;
end

h1=plot(Sx,Sy,'LineWidth',2,'Linestyle','--','color','r');
h2=plot(Nx,Ny,'LineWidth',2,'Linestyle','--','color','b');
h3=plot(Tx,Ty,'LineWidth',2,'Linestyle','--','color','g');
legend([a q h1 h2 h3],{'Integrated Signal','Detected QRS','Signal Level','Noise Level','Adaptive Threshold'},'Location','BestOutside');

%% Search Back
RR=mean(diff(Sx),2);
for i=1:length(Sx)-1
    if  (Sx(i+1)-Sx(i))>RR*1.66
        new=thres(i)/2;
        x=find(locs==Sx(i));
        if(locs(x+1)>new)
            Beat=Beat+1;
            hold on;
            plot(locs(x+1),pks(x+1),'m*');
        end
    end
end
rate2=Beat*60/t(end);
title([fnam,'  BPM= ',num2str(rate2),' Width=',num2str(RR/fs),' sec']);



