function [ class ] = topicm( bow, K )
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
topics = K;
docs = size(bow,1);
words = size(bow,2);
% class = zeros(docs,1);
prior = 1/K*ones(1,K);
%likelihood = 1/K*ones(words,K);
expWord = randn(words,K);
expDoc = randn(docs,K);
posterior = randn(K,docs,words);

expWord = expWord./repmat(sum(expWord),words,1);
expDoc = expDoc./repmat(sum(expDoc),docs,1);

%E Step 
min =  1e-6;
for counter = 1:25
    counter
    
   % prior, size = [1,topics];
   % expDoc, size = [docs,topics];
   % expWord, size = [words,topics];
    prior_perm = prior.';
    expDoc_perm = expDoc.';
    expWord_perm = permute(expWord,[2,3,1]);

    posterior = bsxfun(@times,prior_perm,bsxfun(@times,expDoc_perm,expWord_perm));

    den = sum(posterior(:));

    
    %posterior(1:topics,1:docs,1:words) = prior(1,1:topics).'*expDoc(1:docs,1:topics).'*expWord(1:words,1:topics);
    %den = sum(posterior(:,:,:));
   % posterior(:,:,:)  =  posterior(:,:,:)/(den);
    %for doc = 1:docs 
    %    for word = 1:words
    %        den =0;
    %        for topic = 1:topics
    %            posterior(topic,doc,word) =prior(1,topic)*expDoc(doc,topic)*expWord(word,topic);
    %            den  = den + posterior(topic,doc,word) ;
    %        end     
    %    end
    %  end    
     % for topic = 1:topics
     %     % den  = sum( posterior(:,doc,word));
     %      posterior(:,doc,word)  =  posterior(:,doc,word)/(den);
     %  end


%Maximization
for topic = 1:topics
    den =0;
         for word = 1:words
             num = 0;
             for doc = 1:docs 
                num = num + (posterior(topic,doc,word)*bow(doc,word));
             end             
             expWord(word,topic) = num;
             den = den + num;
         end
          for word = 1:words
             expWord(word,topic) =   expWord(word,topic)/(1e-6 + den);
         end 
        
     end
     for topic = 1:topics
         den =0;
         for doc = 1:docs 
             num = 0;
             for word = 1:words
                num = num + (posterior(topic,doc,word)*bow(doc,word));
             end
             expDoc(doc,topic) = num;
             den = den + num;
         end
         for doc = 1:docs
             expDoc(doc,topic) =   expDoc(doc,topic)/(1e-6 +den);
         end 
         
     end
   %  den =0;
     for topic = 1:topics
         
         for doc = 1:docs 
             num = 0;
             for word = 1:words
                num = num + (posterior(topic,doc,word)*bow(doc,word));
             end
         end
         prior(1,topic) = num;
         den =den+num;
     end
     for topic = 1:topics
        prior(1,topic) = prior(1,topic)/(1e-6 +den);
     end
     
 end
% 
% disp(expDoc);
class = expWord;
%[c,class] = max(expDoc,[],2);
end