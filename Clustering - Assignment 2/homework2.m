function [] = homework2( )
% This is a simple example to help you evaluate your clustering algo implementation. You should run your code several time and report the best
% result. The data contains a 400*101 matrix call X, in which the last
% column is the true label of the assignment, but you are not allowed to
% use this label in your implementation, the label is provided to help you
% evaluate your algorithm. 
%
%
% Please implement your clustering algorithm in the other file, mycluster.m. Have fun coding!

load('data');
T = X(:,1:100);
label = X(:,101);
%accuracies = (100);
%for i=1:100,
IDX = mycluster(T,4);
acc=AccMeasure(label,IDX)
%accuracies(i) = acc
%end
%hist(accuracies)
%mean(accuracies)
%median(accuracies)
%mode(accuracies)
%std(accuracies)
%min(accuracies)
%max(accuracies)
%end