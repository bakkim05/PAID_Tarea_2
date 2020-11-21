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
      
      imFiltered(:,:,1) = MVDM([val1r,val2r,val3r]);
      imFiltered(:,:,2) = MVDM([val1g,val2g,val3g]);
      imFiltered(:,:,3) = MVDM([val1b,val2b,val3b]);
      
      val1r = val2r;
      val2r = val3r;
      
      val1g = val2g;
      val2g = val3g;
      
      val1b = val2b;
      val2b = val3b;
    endfor
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