clear;clc; close all
%%%%
pkg load image

%Imagen Original: I1
I1=imread('images/paisaje.jpg');
subplot(2,2,1)
imshow(I1)
title('(a) paisaje.jpg','FontSize',16)

%Texto: I2
I2=imread('images/marca.jpg');
I2(I2<50)=0; I2(I2>=50)=255; %Convertir imagen a Binaria. Parte Blanca = Texto. Parte Negra = Valor de 0
subplot(2,2,2)
imshow(I2)
title('(b) marca.jpg','FontSize',16)

%Imagen a Restaurar: I3
I3=I1+I2;
subplot(2,2,3)
imshow(I3)
title('(c) Imagen a Restaurar','FontSize',16)
a = 0.073235;
b = 0.176765;
M =  [a b a; 
      b 0 b; 
      a b a];
bounds = I2 == 255;
I3 = im2double(I3);
I2 = im2double(I2);
for i = 1:50
  C = conv2(I3, M, 'same');
  D=I2.*C;
  I3=I3.*(-I2+1);
  I3=I3+D;
end
tmp = im2uint8(I3);
figure
imshow(tmp)
title('(c) Imagen restaurada','FontSize',16)