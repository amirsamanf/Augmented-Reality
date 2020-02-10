% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
cv_cover = imread('../data/cv_cover.jpg');


%% Compute the features and descriptors

hist_SURF = zeros(1, 36);
hist_BRIEF = zeros(1, 36);

for i = 0:36
    %% Rotate image
    cv_cover_rot = imrotate(cv_cover, (i+1)*10, 'bilinear', 'crop');
    
    %% Compute features and descriptors
    [locs1_SURF, locs2_SURF] = matchPics_SURF(cv_cover, cv_cover_rot);
    [locs1_BRIEF, locs2_BRIEF] = matchPics(cv_cover, cv_cover_rot);
   
    %% Match features
    
    %% Update histogram
    hist_SURF(i+1) = length(locs1_SURF);
    hist_BRIEF(i+1) = length(locs1_BRIEF);
    
    
end

%% Display histogram

x_SURF = (10:10:370);
x_BRIEF = (10:10:370);

figure
subplot(1,2,1)
plot(x_SURF, hist_SURF)
xlabel('Rotation in Degrees') 
ylabel('Number of Matches') 
title('SURF')


subplot(1,2,2)
plot(x_BRIEF, hist_BRIEF)
xlabel('Rotation in Degrees') 
ylabel('Number of Matches')
title('BRIEF')


