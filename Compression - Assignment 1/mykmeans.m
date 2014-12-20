function [ class, centroid ] = mykmeans( pixels, K )

% @Reference Course Material. kmeans_digit.m
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% k-means algorithm; 
% greed algorithm trying to minimize the objective function; 
% A highly matricized version of kmeans.
% Taking the transpose of the input pixels since we want each row to
% represent the different colors (r,g,b)
x = pixels';

cno = K; 
m = size(x, 2);
% randomly initialize centroids with data points; 
c = x(:,randsample(size(x,2),cno));

iterno = 100; 
for iter = 1:iterno
  fprintf('--iteration %d\n', iter); 
  
  % norm2 of the centroids; 
  c2 = sum(c.^2, 1);  
  
  % for each data point, computer max_j -2 * x' * c_j + c_j^2; 
  tmpdiff = bsxfun(@minus, 2*x'*c, c2); 
  [val, labels] = max(tmpdiff, [], 2); 
  
  % update data assignment matrix; 
  P = sparse(1:m, labels, 1, m, cno, m); 
  count = sum(P, 1); 
   
  % recompute centroids; 
  c = bsxfun(@rdivide, x*P, count); 
end
  %disp(labels);
  class = labels;
  centroid = c';
 %[class, centroid] = kmeans(pixels, K);
end

