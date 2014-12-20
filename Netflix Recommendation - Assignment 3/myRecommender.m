function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    name = 'Khare, Ashwini';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 100; % Choose your own.
    learningRate = 0.002; % Choose your own.
    regularizer = 0.015; % Choose your own.
    
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;

    % Gradient Descent:
    
    % IMPLEMENT YOUR CODE HERE.
    % Update U
    % Update V
    V = V';
    for steps=1:maxIter,
        % Iterate update and U & V
        for i=1:size(rateMatrix,1),
            for j=1:size(rateMatrix,2),
                if rateMatrix(i,j) > 0
                    eij = rateMatrix(i,j) - U(i,:)*V(:,j);
                    for k=1:size(lowRank,2)
                        temp_U = U(i,k);
                        temp_V = V(k,j);
                        U(i,k) = temp_U + learningRate*2*(eij*temp_V-regularizer*temp_U);
                        V(k,j) = temp_V + learningRate*2*(eij*temp_U-regularizer*temp_V);
                    end
                end
            end
        end
        % Check for reconstruction error
        e = sumsqr((rateMatrix - U*V).*(rateMatrix > 0));
        %for i=1:size(rateMatrix,1),
        %    for j=1:size(rateMatrix,2),
        %        if rateMatrix(i,j) > 0
        %            e_temp = e;
        %            e = e_temp + (rateMatrix(i,j)-U(i,:)*V(:,j))^2;
        %            for k=1:size(lowRank,2),
        %                e = e + regularizer*(U(i,k)^2+V(k,j)^2);
        %            end
        %        end
        %    end    
        %end
        if e<0.20
            break
        end
    end
    V = V';    
end