clear all;
clc;

%% For calculating the transform

U=[ 10,15,1 ; 8,3,1 ; 11,17,1 ; 5,11,1 ; 6,13,1 ];
X=[ 33,20,1 ; 18,7,1 ; 37,22,1 ; 20,13,1 ; 23,16,1 ];

T=inv(U'*U)*U'*X;

%%
imgful=imread('cameraman.tif'); % Reading the input image
M=256;
N=256;
new_img=imcrop(imgful,[1 1 M N]); % Cropping the input image
[r2,c2]=size(new_img);

[p2,q2]=meshgrid(0:M-1,0:N-1); % Input meshgrid

% create array of destination x,y coordinates
r2=round(r2*2); % Dimensions of output image
c2=round(c2*2); % to view the complete output image after rotation

[x2,y2]=meshgrid(0:r2-1,0:c2-1); % Output meshgrid

imshow(new_img,[]);
title('Left Image');

% calculate source coordinates
Z2=zeros(r2,c2);
sourceCoor=[x2(:) y2(:) Z2(:)]*inv(T); % X=U*T, U=X*inv(T)

% calculate nearest neighbor interpolation
v2=sourceCoor(:,1); 
w2=sourceCoor(:,2);

I2=griddata(p2(:),q2(:),double(new_img(:)),v2,w2); % Interpolation
original_img=reshape(I2,r2,c2); % Reshaping the image according to the output image size 

figure,imshow(original_img,[]);
title('Middle Image');
imwrite(uint8(original_img),'output.jpg','Quality',100); % Saving output image

%%
% For part 2

new_img=imread('output.jpg');  % Reading the input image
[r2,c2]=size(new_img);

[p2,q2]=meshgrid(0:r2-1,0:c2-1); % Input meshgrid
[x2,y2]=meshgrid(0:r2-1,0:c2-1); % Output meshgrid

% calculate source coordinates
Z2=zeros(r2,c2);
sourceCoor=[x2(:) y2(:) Z2(:)]*T;

% calculate nearest neighbor interpolation 
v2=sourceCoor(:,1);
w2=sourceCoor(:,2);

% calculate new image
Vq=griddata(p2(:),q2(:),double(new_img(:)),v2(:),w2(:)); % Interpolation
original_img=reshape(Vq,r2,c2); 

original_img=original_img(1:340,1:340); % Cropping out the black region of the image
figure,imshow(original_img,[]);
title('Right Image');

