%This script simply calls an image (durer), and creates a subplot of the
%image with an incremental increase in noise from the original photo
clear all
clc
close all

load durer
image(X)
V = X;
W = X;
Y = X;
Z = X;
axis equal
axis off
colormap(map)
i = 1

%Start with second image, create noise by using randi for 10000 times.
%Each for loop involves a new image of durer, with more noise
for i = 1:10000
    
    V(randi(648),randi(509)) = randi([1 128]);
end
colormap(map)
image(V)
imwrite(V, 'V.bmp','bmp')



for i = 1:100000
    
    W(randi(648),randi(509)) = randi([1 128]);
end
colormap(map)
image(W)
imwrite(W, 'W.bmp','bmp')

for i = 1:250000
    
    Y(randi(648),randi(509)) = randi([1 128]);
end
colormap(map)
image(Y)
imwrite(Y, 'Y.bmp','bmp')

for i = 1:1000000
    
    Z(randi(648),randi(509)) = randi([1 128]);
end
colormap(map)
image(Z)
imwrite(Z, 'Z.bmp','bmp')



imagesc([X V W Y Z])
colormap(map)
axis off 
axis equal