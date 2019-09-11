clear all;
clc;

pixel=[0 1 2 3]; % Input pixel levels 
level=4;
probability=[0.4 0.2 0 0.4]; % Probability of each pixel

new_pixel=zeros(size(pixel)); % Output pixel levels 

for i=0:3
    I=find(pixel==i);
    new_pixel(I)=round((level-1)*sum(probability(1:i+1)));
end

display(new_pixel);
lin=0:3;
stem(lin,probability);

pr=zeros(1,4);

for i=0:3
    pr(i+1)=sum(new_pixel==i)/level;
end

figure,stem(lin,pr);

