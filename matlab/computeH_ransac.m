function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)

    N = 10000;
    dThresh = 2;

    maxinlierCount = 0;
    inliers = zeros(1,size(locs2,1));
    
    for k=1:N
        inlierCount = 0;
        ins = zeros(1,size(locs2,1));

        p1 = zeros(4,2);
        p2 = zeros(4,2);
        for i=1:4
            ind = randperm(size(locs1,1),1);
            p1(i,2) = locs1(ind, 2);
            p1(i,1) = locs1(ind, 1);
            p2(i,2) = locs2(ind, 2);
            p2(i,1) = locs2(ind, 1);
        end

        H_curr = computeH_norm(p1,p2);

        l2 = zeros(size(locs1,1),2);
        for i=1:size(locs1,1)
            tmp = [locs1(i,:),1]*H_curr;
            l2(i,1) = tmp(1)/tmp(3);
            l2(i,2) = tmp(2)/tmp(3);
        end

        for i=1:size(locs2,1)
            dx = l2(i,1) - locs2(i,1);
            dy = l2(i,2) - locs2(i,2);
            d = sqrt(dx^2 + dy^2);

            if d < dThresh
               inlierCount = inlierCount + 1;
               ins(i) = 1;
            end

        end

        if inlierCount > maxinlierCount
            maxinlierCount = inlierCount;
            inliers = ins;
            bestH2to1 = H_curr;
        end
    
    end

end

