pkg load image;
clc; clear; close all;
A = imread('images/orig.jpg');
%B = imread('images/objeto.jpg')(1:960, 1:1280,:);
B = imread('images/objeto4.jpg');
B = B <= 50;
%B = B >= 50;
%disp(B(1:50, 1:50));
%Algoritmo de recuperación
subplot(2,2,1)
imshow(A)
title('Imagen original')
subplot(2,2,2)
imshow(B)
title('Imagen Marca')
function I = f_inp(A, M, bounds, its)
  for i = 1:its
    C = conv2(A, M, 'same');
    A(bounds) = C(bounds);
  endfor
  I = A;
endfunction 

a = 0.073235;
b = 0.176765;
%a = 0.125;
%b = 0.125;

M =  [a b a; 
      b 0 b; 
      a b a];
bounds = B;
A = im2double(A);

its=50;

A(:,:,1) = f_inp(A(:,:,1), M, bounds, its);
A(:,:,2) = f_inp(A(:,:,2), M, bounds, its);
A(:,:,3) = f_inp(A(:,:,3), M, bounds, its);

subplot(2,2,3:4)
imshow(im2uint8(A))
title('Imagen corregida')