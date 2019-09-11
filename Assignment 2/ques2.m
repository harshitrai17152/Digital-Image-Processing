clear all;
clc; 
%% For Image 1
x1=double(imread('x5.bmp')); % input image
[M1,N1]=size(x1); % get size of image
for i=0:255
    h1(i+1)=sum(sum(x1==i)); %hist of input image
end

figure; subplot(1,2,1); imshow(x1,[]); %show input image
title('Input Image');
r=0:255;
subplot(1,2,2);stem(r,h1);  % show input hist
title('Input Image Histogram');

% compute hist equalization
T1=x1; % initialize output image
s1=sum(h1); % Total number of pixels
for i=0:255
    Tr(i+1)=round((sum(h1(1:i))/s1)*255); %(L-1)*CDF
end

%% For Image 2
x2=double(imread('Q2-input image.tif')); % output image
[M2,N2]=size(x2); % get size of image
for i=0:255
    h2(i+1)=sum(sum(x2==i)); %hist of output image
end

figure; subplot(1,2,1); imshow(x2,[]); %show output image
title('Output Image');
r=0:255;
subplot(1,2,2);stem(r,h2);  % show output hist
title('Output Image Histogram');

% compute hist equalization
T2=x2; % initialize output image
s2=sum(h2); % Total number of pixels
for i=0:255
    Gr(i+1)=round((sum(h2(1:i))/s2)*255); %(L-1)*CDF
end

%% For Matched Image

[pix] = unique(T1); % find all indices of unique pixel values
matchedY = T1; %initialize matched output as matchedY

for i =1:numel(pix)
    diffpix = abs(double(Tr(pix(i)+1))-double(Gr)); % for every unique pixel value in 'y' find difference of T(r) and G(z)
    [~,ind]=min(diffpix); % find index of nearest value of a unique pixel value in 'y' in Gr(z)
    val=ind-1; %take the pixel value corresponding to index obtained in previous line
    I=find(T1==pix(i)); % find all indices of pixels with value 'pix(i)' in 'y'
    matchedY(I)=val; % substitute pixel value 'val' in the indices obtained in previous line
end

figure, subplot(1,2,2), imshow(uint8(matchedY)); %show matched image
title('Hist Matched image');
subplot(1,2,1), imhist(uint8(matchedY)); % show matched hist
title('Matched image hist');
imwrite(uint8(matchedY),'matched.jpg','Quality',100); % Saving matched output image
