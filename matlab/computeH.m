function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points

n = size(x1, 1);

x = x2(:, 1); y = x2(:,2); 
X = x1(:,1); Y = x1(:,2);

rows0 = zeros(3, n);

rowsXY = -[X.'; Y.'; ones(1,n)];

A = zeros(2*n,9);
for i=1:n
    A(2*i-1,:) = [rowsXY(:,i).', rows0(:,i).', x(i)*X(i), x(i)*Y(i), x(i)];
    A(2*i,:) = [rows0(:,i).', rowsXY(:,i).', y(i)*X(i), y(i)*Y(i), y(i)];
end

if n == 4
    h = null(A);
end

[~,~,V] = svd(A);
h = V(:,9);

H2to1 = reshape(h,3,3);


