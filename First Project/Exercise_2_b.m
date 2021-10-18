clear figure; clear all; close all;

%%% ------------------------------------------------------------------- %%%
% 2.b) Plot repeatability versus rotation angle in increments of 15 degrees
% from 0 degrees to 360 degrees for the two keypoint detectors.

fprintf('2.b Problem------------\n');

% Rotation = 0;
Angle=0;
Matchs=0;
Features=0;
Rotated_features=0;

for Rotation=0:15:360
    clear figure; close all;
    % r=[cos(Rotation),-sin(Rotation);sin(Rotation),cos(Rotation)];
    fprintf('Rotation: %i\n', Rotation);

    I1 = imread('data1\obj1_5.jpg');
    I1 = single(rgb2gray(I1));
    [m,n]=size(I1);
%     figure; subplot(1,3,1);
%     colormap gray; imagesc(I1);
%     axis equal; axis off; axis tight; hold on;
    [f1,d1] = vl_sift(I1,'edgethresh',12,'peakthresh', 12);
%     vl_plotframe(f1);

%     p=[1000;1000]; 
%     ang=0:0.01:2*pi; 
%     xp=50*cos(ang);
%     yp=50*sin(ang);
%     plot(p(1)+xp,p(2)+yp,'r','LineWidth',2);

    I2a = imrotate(imread('data1\obj1_5.jpg'),Rotation);
    I2a = single(rgb2gray(I2a));

%     subplot(1,3,2);
%     colormap gray; imagesc(I2a);
%     axis equal; axis off; axis tight; hold on; 
    [f2a,d2a] = vl_sift(I2a,'edgethresh',10,'peakthresh', 15);
%     vl_plotframe(f2a);

    % p = f1(1:2,:)*r;
    if Rotation<=360 && Rotation>270
        xp=+f1(1,:)*cosd(Rotation)+f1(2,:)*sind(Rotation)+m*cosd(Rotation-270);
        yp=-f1(1,:)*sind(Rotation)+f1(2,:)*cosd(Rotation); 
    else if Rotation<=270 && Rotation>180
            xp=+f1(1,:)*cosd(Rotation)+f1(2,:)*sind(Rotation)+n*cosd(Rotation-180)+m*sind(Rotation-180);
            yp=-f1(1,:)*sind(Rotation)+f1(2,:)*cosd(Rotation)+m*cosd(Rotation-180);
        else if Rotation<=180 && Rotation>90
                xp=+f1(1,:)*cosd(Rotation)+f1(2,:)*sind(Rotation)+n*sind(Rotation-90);
                yp=-f1(1,:)*sind(Rotation)+f1(2,:)*cosd(Rotation)+n*cosd(Rotation-90)+m*sind(Rotation-90); 
            else
                xp=+f1(1,:)*cosd(Rotation)+f1(2,:)*sind(Rotation);
                yp=-f1(1,:)*sind(Rotation)+f1(2,:)*cosd(Rotation)+sind(Rotation)*n;
            end
        end
    end    

    % xp=f1(1,:)*cosd(Rotation)+f1(2,:)*sind(Rotation);
    % yp=-f1(1,:)*sind(Rotation)+f1(2,:)*cosd(Rotation)+sind(Rotation)*length(I1);
    % a=xp;
    % b=yp;
    % p=[xp(:);yp(:)]; 
    p=cat(1,xp,yp);
    % a=zeros(1,700);
    % b=zeros(1,700);
    % c=[a;b];
    right_point=0;
    for i=p(1:2,:)
        for j=f2a(1:2,:)
            if (abs(j(1)-i(1)) <= 2) && (abs(j(2)-i(2)) <= 2)
                right_point=right_point+1;
                break
            end
        end
    end

    fprintf('Image feature: %i\n', size(f1,2));
    fprintf('Rotated image feature: %i\n', size(f2a,2));
    fprintf('Right points: %i\n', right_point);

    Angle(end+1)=Rotation;
    Matchs(end+1)=right_point;
    Features(end+1)=size(f1,2);
    Rotated_features(end+1)=size(f2a,2);

end

Angle(1)=[];
Matchs(1)=[];
Features(1)=[];
Rotated_features(1)=[];

figure;
scatter(Angle,Matchs/size(f1,2));
figure;
scatter(Angle,Rotated_features);
% ylim([400,]);
%axis('fill');
% plot(Rotation,right_point);

% xp=1000*cosd(Rotation)+1000*sind(Rotation);
% yp=-1000*sind(Rotation)+1000*cosd(Rotation)+sind(Rotation)*length(I1);



% if Rotation<=360 && Rotation>270
%     xp=+1000*cosd(Rotation)+1000*sind(Rotation)+m*cosd(Rotation-270);
%     yp=-1000*sind(Rotation)+1000*cosd(Rotation); 
% else if Rotation<=270 && Rotation>180
%         xp=+1000*cosd(Rotation)+1000*sind(Rotation)+n*cosd(Rotation-180)+m*sind(Rotation-180);
%         yp=-1000*sind(Rotation)+1000*cosd(Rotation)+m*cosd(Rotation-180);
%     else if Rotation<=180 && Rotation>90
%             fprintf('diob\n');
% %             Rotation = 180-Rotation;
% %             xp=-m*cosd(Rotation-90);
% %             yp=-m*sind(Rotation-90)-n*cosd(180-Rotation);
%             xp=+1000*cosd(Rotation)+1000*sind(Rotation)+n*sind(Rotation-90);
%             yp=-1000*sind(Rotation)+1000*cosd(Rotation)+n*cosd(Rotation-90)+m*sind(Rotation-90);
%         else
%             xp=+1000*cosd(Rotation)+1000*sind(Rotation);
%             yp=-1000*sind(Rotation)+1000*cosd(Rotation)+sind(Rotation)*n;
%         end
%     end
% end
% 
% p=[xp;yp]; 
% ang=0:0.01:2*pi; 
% xp=50*cos(ang);
% yp=50*sin(ang);
% plot(p(1)+xp,p(2)+yp,'r','LineWidth',2);
