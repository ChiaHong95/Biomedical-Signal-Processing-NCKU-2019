clear ; close all;
ecg = load('ecg_hfn.dat');
fs = 1000; 

%problem1
slen = length(ecg);
t=(1:slen)/fs;
figure(1);
subplot(211);
plot(t,ecg);axis tight;
xlabel('Time in seconds');ylabel('ECG');title('Original ECG signal');
temp=ecg(175:353);
for i=1:1:length(ecg)-length(temp)
   R=corrcoef(temp,ecg(i:i+length(temp)-1)); 
   Co(i)=R(3);
end
t2=(1:length(Co))/fs;
subplot(212);plot(t2,Co);axis tight;
ylabel('Correlation Coefficient');xlabel('Time in seconds');title('Cross correlation with template');
[pks,loc]=findpeaks(Co,'minpeakheight',0.7);
loc=loc/fs;
figure(2);
plot(t2,Co,loc,pks,'rx');
xlabel('Time in seconds');ylabel('Correlation Coefficient');
rate=round(length(loc)*60/t(end));title(['Minpeakheight =0.7, Heartrate=',num2str(rate),'/min']);

figure;subplot(211);
[pks,loc]=findpeaks(Co,'minpeakheight',0.5);
loc=loc/fs;
plot(t2,Co,loc,pks,'rx');
xlabel('Time in seconds');ylabel('Correlation Coefficient');
rate=round(length(loc)*60/t(end));title(['Minpeakheight =0.5, Heartrate=',num2str(rate),'/min']);

subplot(212);[pks,loc]=findpeaks(Co,'minpeakheight',0.5,'minpeakdistance',300);
loc=loc/fs;plot(t2,Co,loc,pks,'rx');
rate=round(length(loc)*60/t(end));
xlabel('Time in seconds');ylabel('Correlation Coefficient');title(['Minpeakheight =0.5, MinPeakDistance=300 pts, Heartrate=',num2str(rate),'/min']);

[pks3,loc3]=findpeaks(ecg,'minpeakheight',2.5,'MinPeakDistance',10); 
for i=1:12
    F=loc3(i)-294;
    T=loc3(i)+400;
    Seg(i,:)=ecg(F:T);
end
M=mean(Seg);figure;
subplot(211);plot(ecg(1:694));SNR=snr(ecg(1:694));
xlabel('Points');ylabel('ECG');title(['Original ECG cycle with SNR=',num2str(SNR)]);
subplot(212);plot(M);SNR2=snr(M);
xlabel('Points');ylabel('ECG');title(['Synchronized averaged ECG cycle with SNR=',num2str(SNR2)]);

%   problem2
M1= movmean( ecg , 2 );
figure;subplot(211);plot(ecg);
xlabel('Time in seconds');ylabel('ECG');title(['Original ECG signal with SD=',num2str(std(ecg))]);
subplot(212);plot(M1);
xlabel('Time in seconds');ylabel('ECG');title(['Averaged by 2 points with SD=',num2str(std(M1))]);

M2= movmean( ecg , 4 );
figure;subplot(211);plot(ecg);
xlabel('Time in seconds');ylabel('ECG');title(['Original ECG signal with SD=',num2str(std(ecg))]);
subplot(212);plot(M2);
xlabel('Time in seconds');ylabel('ECG');title(['Averaged by 4 points with SD=',num2str(std(M2))]);