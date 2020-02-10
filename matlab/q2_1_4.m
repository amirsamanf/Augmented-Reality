% This file is for testing purposes
% close all;
% clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
hp_cover = imread('../data/hp_cover.jpg');


% if (ndims(cv_desk) == 3)
%     cv_desk = rgb2gray(cv_desk);
% end
% 
% if (ndims(hp_cover) == 3)
%     hp_cover = rgb2gray(hp_cover);
% end


% [locs1, locs2] = matchPics(cv_cover, cv_desk);
% 
% [H,inliers] = computeH_ransac(locs1,locs2);



[locs1, locs2] = matchPics(cv_cover, cv_desk);

[H,inliers] = computeH_ransac(locs1, locs2);

% hp = imresize(hp_cover, size(cv_cover)); % size of cv_cover
% 
% warp_im = warpH(hp, H', size(cv_desk));
% 
% imshow(cv_desk + warp_im)

% final = compositeH(H, hp, cv_desk);

% imshow(final);

% ins1 = zeros(size(locs1,1),2);
% ins2 = zeros(size(locs2,1),2);
% for i=1:length(inliers)
% 
%     if inliers(i) == 1
%         ins1(i,:) = locs1(i,:);
%         ins2(i,:) = locs2(i,:);
% 
%     end
% 
% end
% 
% ins1 = ins1(any(ins1,2),:);
% ins2 = ins2(any(ins2,2),:);

% l2 = zeros(size(locs1,1),2);
% for i=1:length(locs1)
%     
%     tmp = [locs1(i,:),1]*H;
%     
%     l2(i,1) = round(tmp(1)/tmp(3));
%     l2(i,2) = round(tmp(2)/tmp(3));
%     
% end

p = zeros(50,2);
for i=1:50
    p(i,2) = randperm(size(cv_cover,1),1);
    p(i,1) = randperm(size(cv_cover,2),1);
end

p2 = zeros(50,2);
for i=1:length(p)
    
    tmp = [p(i,:),1]*H;
    
    p2(i,1) = tmp(1)/tmp(3);
    p2(i,2) = tmp(2)/tmp(3);
    
end

showMatchedFeatures(cv_cover, cv_desk, p, p2, 'montage')



% figure;
% showMatchedFeatures(cv_cover, cv_desk, locs1, locs2, 'montage');
% title('Showing all matches');
