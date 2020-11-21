pkg load video
pkg load image

function imFiltered = FMFA(imNoisy)
  [h,w,r] = size(imNoisy);
  imFiltered = zeros(h,w,r);
  for i=2:(h-1)
    val1r = median([imNoisy(i-1,1,1),imNoisy(i,1,1),imNoisy(i+1,1,1)]);
    val2r = median([imNoisy(i-1,2,1),imNoisy(i,2,1),imNoisy(i+1,2,1)]);
    
    val1g = median([imNoisy(i-1,1,2),imNoisy(i,1,2),imNoisy(i+1,1,2)]);
    val2g = median([imNoisy(i-1,2,2),imNoisy(i,2,2),imNoisy(i+1,2,2)]);
    
    val1b = median([imNoisy(i-1,1,3),imNoisy(i,1,3),imNoisy(i+1,1,3)]);
    val2b = median([imNoisy(i-1,2,3),imNoisy(i,2,3),imNoisy(i+1,2,3)]);

    for j=3:(w-1)
      val3r = median([imNoisy(i-1,j,1),imNoisy(i,j,1),imNoisy(i+1,j,1)]);
      val3g = median([imNoisy(i-1,j,2),imNoisy(i,j,2),imNoisy(i+1,j,2)]);
      val3b = median([imNoisy(i-1,j,3),imNoisy(i,j,3),imNoisy(i+1,j,3)]);
      
      imFiltered(:,:,1) = median([val1r,val2r,val3r]);
      imFiltered(:,:,2) = median([val1g,val2g,val3g]);
      imFiltered(:,:,3) = median([val1b,val2b,val3b]);
      
      val1r = val2r;
      val2r = val3r;
      
      val1g = val2g;
      val2g = val3g;
      
      val1b = val2b;
      val2b = val3b;
    endfor
  endfor
endfunction

%Abrir video con ruido
noisyVideo = VideoReader("videos/video_con_ruido.mp4");

%Template para el output video
videoFrame = noisyVideo.NumberOfFrames;
videoHeight = noisyVideo.Height;
videoWidth = noisyVideo.Width;
output = uint8(zeros(videoHeight, videoWidth, 3, videoFrame));

%Aplicar el algoritmo Fast Median Filter Approximation
for i = 1 : videoFrame
     NFRAME = i
     frame = readFrame(noisyVideo);
     output(:,:,:,i) = FMFA(frame(:,:,:));
end

#Escribir sin ruido
cleanVideo = VideoWriter("videos/video_sin_ruido_alg1.mp4");
for i = 1 : videoFrame
     writeVideo(cleanVideo, output(:,:,:,i));
end

close(cleanVideo)