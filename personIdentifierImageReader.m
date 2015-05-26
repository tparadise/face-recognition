% Tom Paradise
% Image Reader personIdentifier

clear all
close all

% Training Data
% Train File
chosen_folder = 'C:\Users\paraditw\Desktop\personIdentifier\All_Faces';
filename_list = dir(chosen_folder); %this allows us to read all filenames in a folder and save it in a structure

xtrain = [];
y = [];
% x1 = zeros(960, 624);
image_data1 = [];
N = length(filename_list); %the length of the filename structure
for n = 3:N
    filename = fullfile(chosen_folder,filename_list(n,1).name); %choosing the name of the last file
    
    last_image = imread(filename,'pgm'); %reading the last file
    image_data1 = [image_data1, last_image];
    
    %figure(1),image(last_image);colormap(gray) %drawing the image,just to understand image files
    
    [M N2 ] = size(last_image);
    new_x = reshape(last_image,M*N2,1);
    xtrain(:,n-2) = new_x;
    %figure(2),plot(new_x,'.');
    
    a = strfind(filename,'an2i');
    if a
        y(n-2) = .9;
    else
        y(n-2) = .1;
    end  
end

[A B] = size(y);
randData = randperm(B);
yRand = y(:,randData);
xRand = xtrain(:,randData);

% % Test data
% % Test File
% chosen_folder = 'U:\private\Machine Learning\Neural Networks\ImageReader\All_Faces';
% filename_list = dir(chosen_folder); %this allows us to read all filenames in a folder and save it in a structure
% 
% realY = [];
% xtest = [];
% image_datatest = [];
% N = length(filename_list); %the length of the filename structure
% for n = 3:N
%     filename = fullfile(chosen_folder,filename_list(n,1).name); %choosing the name of the last file
%     
%     last_image = imread(filename,'pgm'); %reading the last file
%     image_datatest = [image_datatest, last_image];
%     
%     %figure(1),image(last_image);colormap(gray) %drawing the image,just to understand image files
%     
%     [M N ] = size(last_image);
%     new_x = reshape(last_image,M*N,1);
%     xtest = [xtest, new_x];
%     %figure(2),plot(new_x,'.');
%     
%      a = strfind(filename,'an2i');
%     if a
%         realY(n-2) = 1;
%     else
%         realY(n-2) = 0;
%     end
% end
