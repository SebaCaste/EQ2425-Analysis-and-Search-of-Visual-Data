clear figure; clear all; close all;

%%% ------------------------------------------------------------------- %%%
% 2.c) Plot repeatability versus scaling factor with the scaling factors 
% (m^0;m^1;m^2; ... ;m^8, where m = 1.2) (MATLAB function: imresize) for 
% the two keypoint detectors.

fprintf('2.c Problem------------\n');

I1 = imread('data1\obj1_5.jpg');


I1 = single(rgb2gray(I1));

edge_thresh = 10.0;
peak_thresh = 15.0;
% dist_thresh = 3.5;

[f1,d1] = vl_sift(I1,'edgethresh',edge_thresh,'peakthresh', peak_thresh);
Scale=0;
Matches=0;
for n=0:8
    Scaling = 1.2.^n;

    I2 = imresize(imread('data1\obj1_5.jpg'),Scaling);
    I2 = single(rgb2gray(I2));

    [f2,d2] = vl_sift(I2,'edgethresh',edge_thresh,'peakthresh', peak_thresh);

    p = f1(1:2,:) * Scaling;
    right_point=0;
    selp = size(p,2);
    self2 = size(f2,2);
    fprintf('number feature p: %i\n',selp);
    fprintf('number feature f2: %i\n',self2);
    for i=p(1:2,:)
        for j=f2(1:2,:)
            if (abs(j(1)-i(1)) <= 2) && (abs(j(2)-i(2)) <= 2)
                right_point=right_point+1;
                break;
            end
        end
    end
    fprintf('right points: %i\n',right_point);
    
    Scale(end+1)=Scaling;
    Matches(end+1)=right_point;
    
end

Scale(1)=[];
Matches(1)=[];

figure;
scatter(Scale,Matches/size(f1,2));

