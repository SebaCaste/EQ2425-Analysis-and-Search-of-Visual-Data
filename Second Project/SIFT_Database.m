
peak_threshold = 5;%5
edge_threshold = 10;%8

database_path=('Data2/server/');    %path to database
current_path=pwd;                   %save current path
cd(database_path);                  %change to trainging data folder

image_dir=struct2cell(dir('*.jpg'));

database_descriptors=[];

%if you don't have parallel toolbox
%use this line belowni:
for i = 1:size(image_dir,2)
    
    [~,n_chars]=find(image_dir{1,i}=='_'); %distinguish objX and objXX
    building_num=str2double(image_dir{1,i}(4:n_chars-1)); %object number
    [~,descriptors]=vl_sift(single(rgb2gray(imread(image_dir{1,i}))),'PeakThresh',peak_threshold,'EdgeThresh',edge_threshold);
    descriptors=[descriptors;building_num*ones(1,size(descriptors,2))];
    database_descriptors=[database_descriptors,descriptors];

end

cd(current_path);       %change to main folder

