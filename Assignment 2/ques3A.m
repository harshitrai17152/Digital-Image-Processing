clear all;
clc;

input_image=imread('Chandrayaan2 - Q3a-inputimage.png');
figure(),imshow(input_image,[]); % Showing the input image
title('Input Image');
input_image=double(input_image); % Converting image to double 

input_image=input_image(:,:,1); % Separating the 3rd channel  
box_filter=(1/(7*7)) * ones(7,7); % Box filter of 7x7

blurred_image=conv2(input_image,box_filter); % Obtaining the blurred image by convolving it with the 7x7 Box Filter
input_image=[input_image ones(569,6)]; % Zero padding to match the blurred image size
input_image=[input_image;ones(6,766)];

unsharp_image=(input_image) - (blurred_image); % Obtaining the masked image by subtracting the original image with the convoluted blurred image
sharp_image=(input_image) + (unsharp_image); % Obtaining the unmasked or sharp image by adding the original image with the unsharped image

%figure,imshow(input_image,[]);
%figure,imshow(blurred_image,[]);
figure,imshow(unsharp_image,[]);

figure(),imshow((uint8(sharp_image)),[]);
title('Output Image');

