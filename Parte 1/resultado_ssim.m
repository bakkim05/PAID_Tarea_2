pkg load image
pkg load video

%Load videos
videoOriginal = VideoReader("videos/video_sin_ruido.mp4");
videoAlg1 = VideoReader("videos/video_sin_ruido_alg1.mp4");
videoAlg2 = VideoReader("videos/video_sin_ruido_alg2.mp4");

frameOriginal = videoOriginal.NumberOfFrames;
videoHeight = videoOriginal.Height;
videoWidth = videoOriginal.Width;

similitud_alg1 = zeros(frameOriginal,3);
similitud_alg2 = zeros(frameOriginal,3);

for i = 1 : frameOriginal
     readerOriginal = readFrame(videoOriginal);
     readerAlg1 = readFrame(videoAlg1);
     readerAlg2 = readFrame(videoAlg2);
     
     similitud_alg1(i,1) = ssim(readerAlg1(:,:,1),readerOriginal(:,:,1));
     similitud_alg1(i,2) = ssim(readerAlg1(:,:,2),readerOriginal(:,:,2));
     similitud_alg1(i,3) = ssim(readerAlg1(:,:,3),readerOriginal(:,:,3));
     
     similitud_alg2(i,1) = ssim(readerAlg2(:,:,1),readerOriginal(:,:,1));
     similitud_alg2(i,2) = ssim(readerAlg2(:,:,2),readerOriginal(:,:,2));
     similitud_alg2(i,3) = ssim(readerAlg2(:,:,3),readerOriginal(:,:,3));
end

resultado_ssim_alg1 = mean(mean(similitud_alg1))
resultado_ssim_alg2 = mean(mean(similitud_alg2))