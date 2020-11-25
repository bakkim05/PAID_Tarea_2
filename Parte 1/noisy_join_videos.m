%Packages
pkg load video
pkg load image

%Load videos
videoJung = VideoReader("videos/jung.mp4");
videoDani = VideoReader("videos/daniel.mp4");
videoDago = VideoReader("videos/dago.mp4");

%Get frames from videos
frameJung = videoJung.NumberOfFrames;
frameDani = videoDani.NumberOfFrames;
frameDago = videoDago.NumberOfFrames;

%Create template for output video
frameTotal = frameJung + frameDani + frameDago
videoHeight = videoJung.Height;
videoWidth = videoJung.Width;
output = uint8(zeros(videoHeight, videoWidth, 3, frameTotal));

%Merge Videos
%%Video Jung
for i = 1 : frameJung
     frame = readFrame(videoJung);
     output(:,:,:,i) = imnoise(frame(:,:,:),"salt & pepper", 0.01);
end

%%Video Daniel
for i = frameJung+1 : frameJung + frameDani
     frame = readFrame(videoDani);
     output(:,:,:,i) = imnoise(frame(:,:,:),"salt & pepper", 0.01);
end

%%Video Dago
for i = frameJung + frameDani + 1  : frameTotal
     frame = readFrame(videoDago);
     output(:,:,:,i) = imnoise(frame(:,:,:),"salt & pepper", 0.01);
end

%Escribir el video en el archivo
videoOutput = VideoWriter("videos/video_con_ruido.mp4");
for i = 1 : frameTotal
     writeVideo(videoOutput, output(:,:,:,i));
end
close(videoOutput)
