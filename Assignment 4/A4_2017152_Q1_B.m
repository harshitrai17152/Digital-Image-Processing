close all
clear all
clc

%% estimation by modelling - blind deconvolution
f=imread('cameraman.tif'); % image to be degraded 
figure,imshow(f,[]);
title('Original Image');
constant=0.0025;
[M,N]=size(f);

for k =0:255
    for l = 0:255
        H(k+1,l+1)=exp(-constant*(k^1+l^1)^(5/6));  % atmospheric turbulence
    end
end

G=H.*fft2(f); % blurring
g=real(ifft2(G)); %spatial domain
figure,imshow(g,[]);
title('Degraded Image without noise');

%% AWGN
g=uint8(g)+uint8(30*randn(256));   % get h*f + n = HF + N
G=fft2(g);  % FFT to get Fourier of observed image
figure,imshow(g,[]); % Show observed image
title('Degraded Image with noise');

%%  Degraded image
mse=mean(mean((double(g)-double(f)).^2));
snrdegraded=20*log10(255/(sqrt(mse))); % SNR degraded

%%  Laplacian for smothness
l(1,1)=-8; l(2,1)=1; l(1,2)=1; % Center is at (1,1)
l(M,1)=1; l(1,N)=1; % Indices modulo P or Q
l(M,2)=1; l(2,N)=1; l(2,2)=1; l(M,N)=1;

L=fft2(l); %%% for constrained filtering

%% Wiener Filter
lambda=0.01;
C=0.001:.04:4;
err=zeros(1,length(C));
for i=1:length(C)
    F=conj(H).*G./(abs(H).^2+C(i)+((lambda*abs(L).^2).*(C(i)+abs(H).^2)));
    fim=real(ifft2(F));
    err(i)=mean(mean((fim-double(f)).^2));
end

%% Show best restored Wiener
[val,indW]=min(err);
F=conj(H).*G./(abs(H).^2+C(i)+((lambda*abs(L).^2).*(C(i)+abs(H).^2)));
fim=real(ifft2(F)); % best restored image
figure,imshow(fim,[]);
title('Best Wiener restored');
snrwiener=20*log10(255/(sqrt(min(err))));  % SNR for restored
