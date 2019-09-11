clear all;
clc;

U=[10,15,1 ; 8,3,1 ; 11,17,1 ; 5,11,1 ; 6,13,1 ];
X=[ 33,20,1 ; 18,7,1 ; 37,22,1 ; 20,13,1 ; 23,16,1 ];

T=inv(U'*U)*U'*X; % Calculating the Transform

display(T); 
