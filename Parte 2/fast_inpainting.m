clc; clear; close all;
pkg load image;

A = imread('images/restaurar.jpg');
B = imread('images/marca.jpg');
subplot(2,2,1);
imshow(A);
title('Imagen a restaurar');
%Algoritmo de recuperación

function I = f_inp(A, M, bounds, its)
  for i = 1:its
    C = conv2(A, M, 'same');
    A(bounds) = C(bounds);
  endfor
  I = A;
endfunction 

a = 0.073235;
b = 0.176765;
M =  [a b a; 
      b 0 b; 
      a b a];
bounds = B >= 50;
subplot(2,2,2);
imshow(bounds);
title('Texto');
A = im2double(A);
C = zeros(size(A));
its = 20
A = f_inp(A, M, bounds, its);
subplot(2,2,3:4);
imshow(im2uint8(A));
title('Imagen restaurada');