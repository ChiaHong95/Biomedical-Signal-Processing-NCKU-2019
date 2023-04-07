 clear;close all;
maindir=pwd;
subdir  = dir( maindir );

for k = 1 : length( subdir )
    if( isequal( subdir( k ).name, '.' )||...
            isequal( subdir( k ).name, '..')||...
            isequal( subdir( k ).name, 'DS_Store')||...
            ~subdir( k ).isdir)
        continue;
    end
    % 6 for eeg1/// 7 for eeg2
    subdirpath = fullfile( maindir, subdir( 6 ).name, '*.dat' );
    dat = dir( subdirpath ) ;
    
    datpath = fullfile( dat(1).folder, dat( 1 ).name);
    data=load(datpath );
    
    for j = 2 : length( dat )
       
        datpath = fullfile( dat(k).folder, dat( j ).name);
        eeg=load( datpath );
        data=[data,eeg];
    end 
% % 
end
len=length( dat );
data=data-mean(data,2);
%%EEG 各 channel 之 covariance matrix
Co1=cov(data);
figure;
for i=1:len
    subplot(len,1,i);
    plot(Co1(i,:));
end
%% 10 個 PC 之 covariance matrix
[COEFF,SCORE, latent] = pca(data);
Co2=cov(SCORE);
figure;
for i=1:len
    subplot(len,1,i);
    plot(Co2(i,:));
end
%% latent
S=sum(latent);
latent=latent*100/S;
for i=2:len
   latent(i)=latent(i)+latent(i-1);
end
figure;
plot(latent);
%% COEFF
figure
for i=1:len
    subplot(len,1,i);
    plot(COEFF(i,:));
end

