close all
clear all
clc

%% Reading the image
f=imread('cameraman.tif'); % image to be degraded 
figure,imshow(f,[]);
title('Original Image');

%% zero padding
fp=padarray(f,[1 1],0,'post');
fp=padarray(fp,[1 1],0,'pre');

%% AWGN
n=uint8(30*randn(258));
g=uint8(fp)+n;   % get f + n = F + N
G=fft2(g);  % FFT to get Fourier of observed image
figure,imshow(g,[]); % Show observed image
title('Image with noise');

var_n=var(double(n(:)));

%% Adaptive filtering
fim=[size(f,1) size(f,2)]; % Estimated image
% Size of local box= 3x3

for i=2:257
    for j=2:257
        local_box=g(i-1:i+1,j-1:j+1);
        
        var_l=var(double(local_box(:)));
        mean_l=mean(local_box(:));
        
        a=var_n/var_l;
        b=g(i,j)-mean_l;
        
        if(a>1)
            a=1;
        end
        
        fim(i-1,j-1)=g(i,j)-(a*b);
    end
end

figure,imshow(fim,[]);
title('Estimated Image');
