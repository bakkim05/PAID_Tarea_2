clc; clear; close all;
pkg load image;

A = imread('images/orig2.jpg');
B = imread('images/objeto2.jpg');
B = B <= 50;
%disp(B(1:50, 1:50));
%Algoritmo de recuperación

function I = f_inp(A, M, bounds, its)
  if(its > 0)
    C = conv2(A, M, 'same');
    A(bounds) = C(bounds);
    I= f_inp(A, M, bounds, its-1);
    return
  endif
  I = A;
  return
endfunction 

a = 0.073235;
b = 0.176765;
M =  [a b a; 
      b 0 b; 
      a b a];
bounds = B;
A = im2double(A);

its=50;
%A = f_inp(A, M, bounds, its); 
A(:,:,1) = f_inp(A(:,:,1), M, bounds, its);
A(:,:,2) = f_inp(A(:,:,2), M, bounds, its);
A(:,:,3) = f_inp(A(:,:,3), M, bounds, its);

imshow(im2uint8(A));