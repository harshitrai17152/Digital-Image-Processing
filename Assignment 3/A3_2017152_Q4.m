% Harshit Rai
% 2017152

clear all;
clc;

input_image=imread('Chandrayaan2 - Q3a-inputimage.png');
cropped_image=imcrop(input_image,[1 1 511 511]); % Cropping the input image
figure(),imshow(cropped_image,[]); % Showing the cropped image
title('Input Image');

cropped_image=double(cropped_image); % Converting image to double 
input_image=cropped_image(:,:,1); % Separating the 3rd channel  
box_filter=(1/(3*3)) * ones(3,3); % Box filter of 3x3

padded_input_image=padarray(input_image,[2 2],0,'post');
padded_box_filter=padarray(box_filter,[511 511],0,'post');

dft_input=fft2(padded_input_image);
dft_box=fft2(padded_box_filter);

H=dft_input.*dft_box; % Hadamard Product
mask=dft_input-H;
sharp=dft_input+mask;
sharped_image=real(ifft2(sharp));
sharped_image=imcrop(sharped_image,[1 1 511 511]);

figure(),imshow((uint8(sharped_image)),[]);
title('Sharped Image');

% Yes both the images are similar due to the fact that convolution in time
% domain is equal to multiplication in frequency domian.
