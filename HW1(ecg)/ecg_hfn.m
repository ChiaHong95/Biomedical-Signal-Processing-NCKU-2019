% MATLAB PROGRAM ecg_hfn.m
clear ; close all;
ecg = load('ecg_hfn.dat');
fs = 1000; %sampling rate = 1000 Hz
slen = length(ecg);
%t=[1:slen]/fs;
subplot(2,1,1);
plot(ecg)
% axis tight;
% xlabel('Time in seconds');
% ylabel('ECG');
temp=ecg(175:353);
for i=1:1:length(ecg)-length(temp)
   R=corrcoef(temp,ecg(i:i+length(temp)-1)); 
   Co(i)=R(3);
end
subplot(2,1,2);
plot(Co);

