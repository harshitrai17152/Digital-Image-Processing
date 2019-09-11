clear all;
clc;

input_image=imread('Chandrayaan2 - Q3a-inputimage.png');
figure(),imshow(input_image,[]); % Showing the input image
title('Input Image');
input_image=double(input_image); % Converting image to double 

input_image=input_image(:,:,1); % Separating the 3rd channel  
box_filter=(1/(7*7)) * ones(7,7); % Box filter of 7x7

final_filter= (-1/49)* [1 1 1 1 1 1 1;
                        1 1 1 1 1 1 1;
                        1 1 1 1 1 1 1;
                        1 1 1 1.9796 1 1 1;
                        1 1 1 1 1 1 1;
                        1 1 1 1 1 1 1;
                        1 1 1 1 1 1 1];
                    
final_filter=[final_filter ones(7,753)]; % Zero padding to match the blurred image size
final_filter=[final_filter;ones(562,760)];                   
                    
final_out=conv2(input_image,final_filter);

figure(),imshow((uint8(final_out)),[]);
title('Output Image');

% In part A and part B both the final images are different.


