function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!

number_words = size(bow,2); 
num_docs = size(bow,1); 
num_clusters = K; 
pi_c = rand(1,K); % Mixture Coefficient of a document containing topic C
pi_c = pi_c./sum(pi_c); % Normalized
mu_jc = rand(number_words, K); % Probability of word in text being equal to wj
mu_jc = mu_jc./repmat(sum(mu_jc), number_words, 1); % Normalized

gamma = zeros(num_docs, num_clusters);

for iterations=1:100

%E-step

den = zeros(num_docs,1);
num = ones(num_docs,num_clusters);

for i=1:num_docs
    for j=1:num_clusters    
        for k=1:number_words
            num(i,j) = num(i,j) * (mu_jc(k,j))^bow(i,k);
        end
        den(i) = den(i) + pi_c(j) * num(i,j);
    end
end

for i=1:num_docs
    for j=1:num_clusters
        gamma(i,j) = (pi_c(j) * num(i,j))/den(i);
    end
end

%M-step
mnum = zeros(number_words,num_clusters);
for i=1:number_words
    for j=1:num_clusters
        for k=1:num_docs
            mnum(i,j) = mnum(i,j) + gamma(k,j) * bow(k,i);
        end
    end
end

mden = sum(mnum,1);

for i=1:number_words
    for j=1:num_clusters
        mu_jc(i,j) = mnum(i,j)/mden(j);
    end
end

pi_c = (1.0/num_docs) * sum(gamma,1);

end

[~,class] = max(gamma,[],2);

end