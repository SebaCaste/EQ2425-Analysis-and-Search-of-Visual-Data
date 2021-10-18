clear figure; clear all; close all;

%%% ------------------------------------------------------------------- %%%
% 2.a) Apply SIFT and SURF to 'obj1_5.jpg'. Adjust peak and edge thresholds 
% of the SIFT keypoint detector, and the strongest feature threshold of the 
% SURF such that a few hundred SIFT and SURF keypoints are detected.
fprintf('2.a Problem------------\n');

I1a = imread('data1\obj1_5.jpg');
I1a = single(rgb2gray(I1a));
[f1,d] = vl_sift(I1a,'edgethresh',11,'peakthresh', 13);

I2a = imread('data1\obj1_5.jpg');
I2a = rgb2gray(I2a);
points = detectSURFFeatures(I2a);
points = points.selectStrongest(size(f1,2));
f2 = points.Location;
f2 = double(transpose(f2));

figure; colormap gray;
imagesc(cat(2, I1a, I2a)) ;
axis equal; axis off; axis tight; hold on;

xa = f1(1,:) ;
xb = f2(1,:) + size(I1a,2) ;
ya = f1(2,:) ;
yb = f2(2,:) ;

vl_plotframe(f1) ;
f2(1,:) = f2(1,:) + size(I1a,2) ;
vl_plotframe(f2) ;
axis image off ;
