clear figure; clear all; close all;

%%% ------------------------------------------------------------------- %%%
% 3.b) Implement the "fixed threshold" matching algorithm. Adjust the 
% distance threshold until you obtain a satisfying result. Plot the best 
% result and one suboptimal result which uses a different distance threshold.
fprintf('3.b Problem------------\n');

I1a = imread('data1\obj1_t1.jpg');
I2a = imread('data1\obj1_5.jpg');

I1a = single(rgb2gray(I1a));
I2a = single(rgb2gray(I2a));

[f1,d1] = vl_sift(I1a,'edgethresh',10,'peakthresh', 15);
[f2,d2] = vl_sift(I2a,'edgethresh',10,'peakthresh', 15);

fprintf('Features 1: %i\n', size(f1,2));
fprintf('Features 2: %i\n', size(f2,2));

threshold=70;

% Euclidian distance over column vectors of length 128 (descriptors)
[~,n] = size(d1);
[~,m] = size(d2);

% pre-allocation
distance = zeros(m,n);

for i = 1 : n
    for j = 1 : m
        % compute euclidian distance between two vectors
        % square root of the sum of all the element of the distance vector
        distance(j,i) = sqrt(sum((d1(:,i)-d2(:,j)).^2));
    end
end

% SIFT Keypoint matching

% find minimum distance
[v1,Index1] = min(distance);

% compute distance threshold
Id = v1<=threshold;
temp1 = 1:n;
Idx = [temp1(Id);Index1(Id)];

figure; colormap gray;
imagesc(cat(2, I1a, I2a)) ;
axis equal; axis off; axis tight; hold on;

xa = f1(1,Idx(1,:)) ;
xb = f2(1,Idx(2,:)) + size(I1a,2) ;
ya = f1(2,Idx(1,:)) ;
yb = f2(2,Idx(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(f1(:,Idx(1,:))) ;
f2(1,:) = f2(1,:) + size(I1a,2) ;
vl_plotframe(f2(:,Idx(2,:))) ;
axis image off ;
