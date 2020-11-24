pkg load video
pkg load image

function imFiltered = IAMFAI(imNoisy)
  [h,w,r] = size(imNoisy);
  imFiltered = zeros(h,w,r);
  for i=2:(h-1)
    val1r = MVDM([imNoisy(i-1,1,1),imNoisy(i,1,1),imNoisy(i+1,1,1)]);
    val2r = MVDM([imNoisy(i-1,2,1),imNoisy(i,2,1),imNoisy(i+1,2,1)]);
    
    val1g = MVDM([imNoisy(i-1,1,2),imNoisy(i,1,2),imNoisy(i+1,1,2)]);
    val2g = MVDM([imNoisy(i-1,2,2),imNoisy(i,2,2),imNoisy(i+1,2,2)]);
    
    val1b = MVDM([imNoisy(i-1,1,3),imNoisy(i,1,3),imNoisy(i+1,1,3)]);
    val2b = MVDM([imNoisy(i-1,2,3),imNoisy(i,2,3),imNoisy(i+1,2,3)]);
    for j=3:(w-1)
      val3r = MVDM([imNoisy(i-1,j,1),imNoisy(i,j,1),imNoisy(i+1,j,1)]);
      val3g = MVDM([imNoisy(i-1,j,2),imNoisy(i,j,2),imNoisy(i+1,j,2)]);
      val3b = MVDM([imNoisy(i-1,j,3),imNoisy(i,j,3),imNoisy(i+1,j,3)]);
      
      imFiltered(i,j,1) = MVDM([val1r,val2r,val3r]);
      imFiltered(i,j,2) = MVDM([val1g,val2g,val3g]);
      imFiltered(i,j,3) = MVDM([val1b,val2b,val3b]);
      
      val1r = val2r;
      val2r = val3r;
      
      val1g = val2g;
      val2g = val3g;
      
      val1b = val2b;
      val2b = val3b;
    endfor
  endfor
  %esquinas
  imFiltered(1,1,1)= median([imNoisy(1,1,1), imNoisy(1,2,1), imNoisy(2,1,1), imNoisy(2,2,1)]);
  imFiltered(1,1,2)= median([imNoisy(1,1,2), imNoisy(1,2,2), imNoisy(2,1,2), imNoisy(2,2,2)]);
  imFiltered(1,1,3)= median([imNoisy(1,1,3), imNoisy(1,2,3), imNoisy(2,1,3), imNoisy(2,2,3)]);
                             
  imFiltered(1,w,1)= median([imNoisy(1,w,1), imNoisy(1,w-1,1), imNoisy(2,w,1), imNoisy(2,w-1,1)]);
  imFiltered(1,w,2)= median([imNoisy(1,w,2), imNoisy(1,w-1,2), imNoisy(2,w,2), imNoisy(2,w-1,2)]);
  imFiltered(1,w,3)= median([imNoisy(1,w,3), imNoisy(1,w-1,3), imNoisy(2,w,3), imNoisy(2,w-1,3)]);
  
  imFiltered(h,1,1)= median([imNoisy(h,1,1), imNoisy(h-1,1,1), imNoisy(h-1,2,1), imNoisy(h,2,1)]);
  imFiltered(h,1,2)= median([imNoisy(h,1,2), imNoisy(h-1,1,2), imNoisy(h-1,2,2), imNoisy(h,2,2)]);
  imFiltered(h,1,3)= median([imNoisy(h,1,3), imNoisy(h-1,1,3), imNoisy(h-1,2,3), imNoisy(h,2,3)]);
                             
  imFiltered(h,w,1)= median([imNoisy(h,w,1), imNoisy(h-1,w,1), imNoisy(h-1,w-1,1), imNoisy(h,w-1,1)]);
  imFiltered(h,w,2)= median([imNoisy(h,w,2), imNoisy(h-1,w,2), imNoisy(h-1,w-1,2), imNoisy(h,w-1,2)]);
  imFiltered(h,w,3)= median([imNoisy(h,w,3), imNoisy(h-1,w,3), imNoisy(h-1,w-1,3), imNoisy(h,w-1,3)]);
  %bordes                          
  for l = 2:w-1
    imFiltered(1,l,1)= median([imNoisy(1,l,1),imNoisy(1,l-1,1),imNoisy(1,l+1,1), imNoisy(2,l,1),imNoisy(2,l-1,1),imNoisy(2,l+1,1)]);
    imFiltered(1,l,2)= median([imNoisy(1,l,2),imNoisy(1,l-1,2),imNoisy(1,l+1,2), imNoisy(2,l,2),imNoisy(2,l-1,2),imNoisy(2,l+1,2)]);
    imFiltered(1,l,3)= median([imNoisy(1,l,3),imNoisy(1,l-1,3),imNoisy(1,l+1,3), imNoisy(2,l,3),imNoisy(2,l-1,3),imNoisy(2,l+1,3)]);
           
    imFiltered(h,l,1)= median([imNoisy(h,l,1), imNoisy(h,l-1,1), imNoisy(h,l+1,1), imNoisy(h-1,l,1), imNoisy(h-1,l-1,1), imNoisy(h-1,l+1,1)]);
    imFiltered(h,l,2)= median([imNoisy(h,l,2), imNoisy(h,l-1,2), imNoisy(h,l+1,2), imNoisy(h-1,l,2), imNoisy(h-1,l-1,2), imNoisy(h-1,l+1,2)]);
    imFiltered(h,l,3)= median([imNoisy(h,l,3), imNoisy(h,l-1,3), imNoisy(h,l+1,3), imNoisy(h-1,l,3), imNoisy(h-1,l-1,3), imNoisy(h-1,l+1,3)]);                          
  endfor
  
  for m = 2:h-1
    imFiltered(m,1,1)= median([imNoisy(m,1,1), imNoisy(m-1,1,1), imNoisy(m+1,1,1), imNoisy(m,2,1), imNoisy(m-1,2,1), imNoisy(m+1,2,1)]);
    imFiltered(m,1,2)= median([imNoisy(m,1,2), imNoisy(m-1,1,2), imNoisy(m+1,1,2), imNoisy(m,2,2), imNoisy(m-1,2,2), imNoisy(m+1,2,2)]);
    imFiltered(m,1,3)= median([imNoisy(m,1,3), imNoisy(m-1,1,3), imNoisy(m+1,1,3), imNoisy(m,2,3), imNoisy(m-1,2,3), imNoisy(m+1,2,3)]);
                               
    imFiltered(m,w,1)= median([imNoisy(m,w,1), imNoisy(m-1,w,1), imNoisy(m+1,w,1), imNoisy(m,w-1,1), imNoisy(m-1,w-1,1), imNoisy(m+1,w-1,1)]);
    imFiltered(m,w,2)= median([imNoisy(m,w,2), imNoisy(m-1,w,2), imNoisy(m+1,w,2), imNoisy(m,w-1,2), imNoisy(m-1,w-1,2), imNoisy(m+1,w-1,2)]);
    imFiltered(m,w,3)= median([imNoisy(m,w,3), imNoisy(m-1,w,3), imNoisy(m+1,w,3), imNoisy(m,w-1,3), imNoisy(m-1,w-1,3), imNoisy(m+1,w-1,3)]);                         
  endfor
  
endfunction

function val = MVDM(a)
  a = sort(a);
  switch a(2)
    case 255
      val = a(1);
    case 0
      val = a(3);
    otherwise
      val = a(2);
  endswitch
endfunction

%Abrir video con ruido
noisyVideo = VideoReader("videos/video_con_ruido.mp4");

%Template para el output video
videoFrame = noisyVideo.NumberOfFrames;
videoHeight = noisyVideo.Height;
videoWidth = noisyVideo.Width;
output = uint8(zeros(videoHeight, videoWidth, 3, videoFrame));

%Aplicar el algoritmo IAMFA-I
for i = 1 : videoFrame
     NFRAME = i
     frame = readFrame(noisyVideo);
     output(:,:,:,i) = IAMFAI(frame(:,:,:));
end

#Escribir sin ruido
cleanVideo = VideoWriter("videos/video_sin_ruido_alg2.mp4");
for i = 1 : videoFrame
     writeVideo(cleanVideo, output(:,:,:,i));
end

close(cleanVideo)

