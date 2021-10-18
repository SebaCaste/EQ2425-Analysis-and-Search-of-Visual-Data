clear figure; clear all; close all;

%%% ------------------------------------------------------------------- %%%
% 3.a) Extract a few hundred SIFT features from the test images (vl feat: 
% vl sift). Show the feature keypoints superimposed on top of obj1 5.JPG 
% and obj1 t5.JPG.
fprintf('3.a Problem------------\n');

I1a = imread('data1\obj1_t1.jpg');
I2a = imread('data1\obj1_5.jpg');

I1a = single(rgb2gray(I1a));
I2a = single(rgb2gray(I2a));

[f1,X] = vl_sift(I1a,'edgethresh',10,'peakthresh', 15);
[f2,Y] = vl_sift(I2a,'edgethresh',10,'peakthresh', 15);

fprintf('Features 1: %i\n', size(f1,2));
fprintf('Features 2: %i\n', size(f2,2));

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
