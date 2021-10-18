
peak_threshold = 5;%5
edge_threshold = 10;%8

database_path=('Data2/client/');    %path to database
current_path=pwd;                   %save current path
cd(database_path);                  %change to trainging data folder

image_dir=struct2cell(dir('*.jpg'));

query_descriptors=[];

%if you don't have parallel toolbox
%use this line belowni:
for i = 1:size(image_dir,2)
    [~,n_chars]=find(image_dir{1,i}=='_'); %distinguish objX and objXX
    building_num=str2double(image_dir{1,i}(4:n_chars-1)); %object number
    [~,descriptorsQ]=vl_sift(single(rgb2gray(imread(image_dir{1,i}))),'PeakThresh',peak_threshold,'EdgeThresh',edge_threshold);
    descriptorsQ=[descriptorsQ;building_num*ones(1,size(descriptorsQ,2))];
    query_descriptors=[query_descriptors,descriptorsQ];
    fprintf("the choose building is %d\n",building_num)
end

cd(current_path);       %change to main folder

