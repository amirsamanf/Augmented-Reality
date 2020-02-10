function [ locs1, locs2] = matchPics_SURF( I1, I2 )
    
    threshold = 10.0;
    ratio = 0.7;
    
    img1 = I1;
    if (ndims(img1) == 3)
        img1 = rgb2gray(img1);
    end

%     img1 = double(img1) / 255;
    
    img2 = I2;
    if (ndims(img2) == 3)
        img2 = rgb2gray(img2);
    end

%     img2 = double(img2) / 255;

    corners1 = detectSURFFeatures(img1);
    corners2 = detectSURFFeatures(img2);
        
    [desc1, l1] = extractFeatures(img1, corners1);
    [desc2, l2] = extractFeatures(img2, corners2);

    indexPairs = matchFeatures(desc1, desc2, 'MatchThreshold', threshold, 'MaxRatio', ratio);
  
    locs1 = l1(indexPairs(:,1),:);
    locs2 = l2(indexPairs(:,2),:);
    
%     showMatchedFeatures(img1, img2, locs1, locs2, 'montage')

end

