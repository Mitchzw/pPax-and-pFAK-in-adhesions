%clc; 
%close all; 
clear all;
% addpath ~/SegyMAT
% addpath ~/na_tools_matlab

%file_name='Path_1_kymograph.csv';

jj=5;  % correlation step e.g. jj=5, a correlation of 1 with 6 will take place, 2 with 7 etc.
% 1 is the lowest value for cross corelation. 0 will return the
% autocorelation of each time slice 

%file_name='FAKdKin_10_kymo-1.csv';
file_name='Pax22_kymo.csv';

%%
M = csvread(file_name,1,0);
k = find(M(:,2)<1); 
size_per_row=k(end);

DX=29.76; %[nm]
DY=1.25;  %[sec] 

nx=size_per_row;
ny=length(M)/size_per_row;

X=(1:1:nx)*DX;	 % definition of x axis for plots
Y=(1:1:ny)*DY;	 % definition of y axis for plots

%for i=1:length(size_per_row)
A=M(:,3);

B = reshape(A,size_per_row,length(M)/size_per_row)'; 

%% debug test
%for i=1:size_per_row
%    B(i,:) = B(1,:);
% %     if mod(i,2)==0
% %         B(i,:)=-1*B(i,:);
% %     end
%end
% condition 2
% CC=rand(size_per_row,length(M)/size_per_row)'; 
% B=CC;
%%
TEST=2*size_per_row-1;
LAGS=zeros(TEST,length(M)/size_per_row)';
correl_mat=zeros(TEST,length(M)/size_per_row)';
%correl_mat_norm=zeros(TEST,length(M)/size_per_row)';
%for i=1:length(M)/size_per_row-1
%    [correl_mat(i,:),LAGS(i,:)]=xcorr(B(i+1,:),B(i,:));
%end


for i=1:length(M)/size_per_row-(jj+1)
    [correl_mat(i,:),LAGS(i,:)]=xcorr(B(i+jj,:),B(i,:));
end


%  for i=1:step:length(M)/size_per_row-(jj+1)
%      Normalised_CrossCorr(i) = (1/(size_per_row-1))*sum((B(i+jj,:)-mean(B(i+jj,:))).*(B(i,:)-mean(B(i,:))))...
%          /(sqrt(var(B(i+jj,:))*var(B(i,:))));
%  end


%% normalization

size_correl=size(correl_mat);
for i=1:size_correl(1)
    maximum=max(correl_mat(i,:));
    correl_mat(i,:)=correl_mat(i,:)./maximum;
end    

%% coeff
% coeff=zeros(size_per_row,length(M)/size_per_row)';
% cor=zeros(size_per_row,length(M)/size_per_row)';
% for i=1:length(M)/size_per_row-1
%     [cor(i,:),coeff(i,:)]=corrcoef(B(i+1,:),B(i,:));
% end
% figure;
% subplot(211); imagesc(cor); subplot(212); imagesc(coeff)
%%
fontsize=12;
figure;
subplot(311)
imagesc(X,Y,B)
title('time lapse intensity map');
xlabel('distance (nm)','FontSize',fontsize)
ylabel('time (s)','FontSize',fontsize)
colorbar;
lim = caxis;
caxis([0 15000])  %% comment this for the raw data if values change too much cause u wont see anything

subplot(312)
imagesc(correl_mat(1:length(M)/size_per_row-(1+jj),:))
title('crosscorellation'); colorbar;
lim = caxis;
%caxis([500000000 7000000000])

subplot(313)
plot(correl_mat(1,:), 'ro')
hold on
plot(correl_mat(end-(1+jj),:),'bx')

%% i cant calculate a lag because I have a series of crosscorelation pairs and not just 2 signals
%  [~,I] = max(max(abs(correl_mat(1:end-1,:))));
%  spatial_Diff = mean(LAGS(1:end-1,I))*DX

%% averaged normalized crosscorrelation values of approximately 0.95 for
 Normalised_CrossCorr=zeros(1,length(M)/size_per_row-1);
 step=1
 %%jj=5 delete..already defined above
 for i=1:step:length(M)/size_per_row-(jj+1)
     Normalised_CrossCorr(i) = (1/(size_per_row-1))*sum((B(i+jj,:)-mean(B(i+jj,:))).*(B(i,:)-mean(B(i,:))))...
         /(sqrt(var(B(i+jj,:))*var(B(i,:))));
 end

% for i=1:step:length(M)/size_per_row-1
%      Normalised_CrossCorr(i) = (1/(size_per_row-1))*sum((B(i+1,:)-mean(B(i+1,:))).*(B(i,:)-mean(B(i,:))))...
%          /(sqrt(var(B(i+1,:))*var(B(i,:))));
% end

%aver_norm_cross_correl_global=mean(Normalised_CrossCorr)
%aver_norm_cross_correl_global=mean(Normalised_CrossCorr(1:step:end))

aver_norm_cross_correl_global=mean(Normalised_CrossCorr(1:step:end-(jj+1)))

dim = [.2 0.01 .3 .3];
str = ['The average normalized crosscorelation is: ',num2str(aver_norm_cross_correl_global),'  for the file: ',file_name];
annotation('textbox',dim,'String',str,'FitBoxToText','on');

%% debug test - Measure the delay between two correlated signals.%
%s1=B(1,:);
%s2=B(10,:);
% [acor,lag] = xcorr(s2,s1);
% dt=1;
% [~,I] = max(abs(acor));
% timeDiff = lag(I)*dt
%  figure; subplot(211); plot(s1,'b'); hold on; plot(s2,'r'); title('raw signals'); legend('s1','s2')
% subplot(212); plot(lag,acor); title('Cross-correlation between s1 and s2')
% 
%Normalised_CrossCorrel = (1/(length(s1)-1))*sum((s1-mean(s1)).*(s2-mean(s2)))/(sqrt(var(s1)*var(s2)))
% 



%500000000
%8000000000
