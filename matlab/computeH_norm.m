function [H2to1] = computeH_norm(x1, x2)

centroid1 = round(mean(x1));
centroid2 = round(mean(x2));


T1 = [sqrt(2),0,sqrt(2)*centroid1(1);0,sqrt(2),sqrt(2)*centroid1(2);0,0,1];

T2 = [sqrt(2),0,sqrt(2)*centroid2(1);0,sqrt(2),sqrt(2)*centroid2(2);0,0,1];

Tx1 = zeros(size(x1,1), 2);
Tx2 = zeros(size(x2,1), 2);

for i=1:size(x1,1)
    tmp1 = [x1(i,:),1]*T1;
    tmp2 = [x2(i,:),1]*T2;
    
    Tx1(i,1) = tmp1(1)/tmp1(3);
    Tx1(i,2) = tmp1(2)/tmp1(3);
       
    Tx2(i,1) = tmp2(1)/tmp2(3);
    Tx2(i,2) = tmp2(2)/tmp2(3);
end

H_norm = computeH(Tx1,Tx2);

H2to1 = (T1 * H_norm*inv(T2));

