function prob = algorithm(q, price_move)
format shortEng %To handle small numbers
% plot and return the probability

%Compute the forward probability
num = size(price_move,1);
%Store alpha
alpha = zeros(num, 2);
alpha(1,1) = (1-q) * 0.2;
alpha(1,2) = q * 0.8;
a = [0.8 0.2];
for i=2:num,
    if price_move(i,1) == 1
        alpha(i,1) = (q) * ( alpha(i-1,1) * a(1,1) + alpha(i-1,2)* a(1,2) );
        alpha(i,2) = (1 - q) * ( alpha(i-1,1) * a(1,2) + alpha(i-1,2) * a(1,1) );
    end
    if price_move(i,1) == -1
        alpha(i,1) = (1-q) * ( alpha(i-1,1) * a(1,1) + alpha(i-1,2) * a(1,2) );
        alpha(i,2) = (q) * ( alpha(i-1,1) * a(1,2) + alpha(i-1,2) * a(1,1) );
    end
end
% P(x)
P_x = alpha(39,1) + alpha(39,2);
% Start backward probability
beta = zeros(num, 2);
%Base Condition
beta(39,1) = 1;
beta(39,2) = 1;
for i=38:-1:1,
    if price_move(i+1,1) == 1
        beta(i, 1) = ( a(1,1) * q * beta(i+1,1)) + (a(1,2) * (1-q) * beta(i+1,2));
        beta(i, 2) = ( a(1,2) * q * beta(i+1,1) + (1-q) * a(1,1) * beta(i+1,2) );
    end
    if price_move(i+1,1) == -1
        beta(i,1) = ( a(1,1) * (1-q) * beta(i+1,1) + a(1,2) * q * beta(i+1,2) );
        beta(i,2) = ( a(1,2) * (1- q) * beta(i+1,1) + (q) * a(1,1)*beta(i+1,2) );
    end
end
%beta
prob = alpha(39,1) * beta (39,1) / P_x;
probab = zeros(num,1);
for i=1:num,
    probab(i) = alpha(i,1) * beta(i,1) / P_x;
end
plot(alpha(:,1).*beta(:,1) / P_x)
plot(probab,'-*','color', rand(1,3) );
hold on
end
