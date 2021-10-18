clear figure; clear all; close all;

%%% ------------------------------------------------------------------- %%%
% 3.d) Implement the "nearest neighbor distance ratio" matching algorithm. 
% Adjust the ratio threshold until you obtain a satisfying result. Plot the 
% best result and one suboptimal result which uses a different ratio threshold.
fprintf('3.e Problem------------\n');

I1a = imread('data1\obj1_t1.jpg');
I2a = imread('data1\obj1_5.jpg');

I1a = rgb2gray(I1a);
I2a = rgb2gray(I2a);

points1 = detectSURFFeatures(I1a);
points1 = points1.selectStrongest(200);
loc1=points1.Location;
loc1=double(transpose(loc1));
[f1,d1] = extractFeatures(I1a,points1);
f1=double(transpose(f1));

points2 = detectSURFFeatures(I2a);
points2 = points2.selectStrongest(200);
loc2=points2.Location;
loc2=double(transpose(loc2));
[f2,d2] = extractFeatures(I2a, points2);
f2=double(transpose(f2));

% Default ratio=0.6
ratio=0.70;

% Euclidian distance over column vectors of length 128 (descriptors)
[~,n] = size(f1);
[~,m] = size(f2);

% pre-allocation
distance = zeros(m,n);

for i = 1 : n
    for j = 1 : m
        % compute euclidian distance between two vectors
        % square root of the sum of all the element of the distance vector
        distance(j,i) = sqrt(sum((f1(:,i)-f2(:,j)).^2));
    end
end

% SIFT Keypoint matching

% find nearest neighbour
[v1,Index1] = min(distance);
for i=1:n
    distance(Index1(i),i) = nan;
end
% find next nearest neighbour
[v2,~] = min(distance);

% compute distance ratio
criteria = v1./v2;
Id = criteria<=ratio;
temp1 = 1 : n;
Idx = [temp1(Id);Index1(Id)];

figure; colormap gray;
imagesc(cat(2, I1a, I2a)) ;
axis equal; axis off; axis tight; hold on;

xa = loc1(1,Idx(1,:)) ;
xb = loc2(1,Idx(2,:)) + size(I1a,2) ;
ya = loc1(2,Idx(1,:)) ;
yb = loc2(2,Idx(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(loc1(:,Idx(1,:))) ;
loc2(1,:) = loc2(1,:) + size(I1a,2) ;
vl_plotframe(loc2(:,Idx(2,:))) ;
axis image off ;
