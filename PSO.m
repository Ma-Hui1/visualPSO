function [population_x1,population_x2] = PSO(f,a,b)
N = 30;
population_x1 = [];
population_x2 = [];
pBest_x1 = zeros(1,N);
pBest_x2 = zeros(1,N);
gBest = [0,0];
speed_x1 = zeros(1,N);
speed_x2 = zeros(1,N);
g=matlabFunction(f);
properTimes = 0;
w = 0.8;
c1 = 2;
c2 = 0.7;
% initial the loc
for i = 1:N
    x1 = -10 + randi(20);
    x2 = -10 + randi(20);
    population_x1 = [population_x1;x1];
    population_x2 = [population_x2;x2];
    if g(x1,x2) < g(gBest(1),gBest(2))
        gBest(1) = x1;
        gBest(2) = x2;
    end
    if g(x1,x2) < g(pBest_x1(i),pBest_x2(i))
        pBest_x1(i) = x1;
        pBest_x2(i) = x2;
    end
end
% w = 0.5
% c1 = c2 = 2
% v(t+1) = w * v(t) + c1*rand()*(p(t) - x(t)) + c2 * rand()*(g(t) - x(t))
% x(t+1) = x (t) + v (t+1)
% MIND THE BORDER
% X1_num = size(tabulate(Population_x1));
% X2_num = size(tabulate(Population_x2));

while(properTimes < 4)
    delta = 0;
    for i = 1 : N
        speed_x1(i) = w * speed_x1(i) + c1 * unifrnd(0,1) * (pBest_x1(i) - population_x1(i)) + c2 * unifrnd(0,1) * (gBest(1) - population_x1(i));
        speed_x2(i) = w * speed_x2(i) + c1 * unifrnd(0,1) * (pBest_x2(i) - population_x2(i)) + c2 * unifrnd(0,1) * (gBest(2) - population_x2(i));
        % x1
        newLoc_x1 = population_x1(i) + speed_x1(i);
        if (newLoc_x1 < b) && (newLoc_x1 > a)
            population_x1(i) = newLoc_x1;
        end
        if newLoc_x1 >= b
            population_x1(i) = b;
        end
        if newLoc_x1 <= a
            population_x1(i) = a;
        end
        
        %x2
        newLoc_x2 = population_x2(i) + speed_x2(i);
        if (newLoc_x2 < b) && (newLoc_x2 > a)
            population_x2(i) = newLoc_x2;
        end
        if newLoc_x2 >= b
            population_x2(i) = b;
        end
        if newLoc_x2 <= a
            population_x2(i) = a;
        end
        
        if g(population_x1(i),population_x2(i)) < g(gBest(1),gBest(2))
            gBest(1) = population_x1(i);
            gBest(2) = population_x2(i);
        end
        
        
        % 
        if g(population_x1(i),population_x2(i)) < g(pBest_x1(i),pBest_x2(i))
            pBest_x1(i) = population_x1(i);
            pBest_x2(i) = population_x2(i);
        end
    end
%     X1_num = size(tabulate(Population_x1));
%     X2_num = size(tabulate(Population_x2));
%     individualNum = X1_num(1) + X2_num(1);
    for j = 2 : N
%         delta += Math.abs(result.get(times * N - i) - result.get(times * N - i - 1));
        delta = delta + abs(g(population_x1(j),population_x2(j)) - g(population_x1(j-1),population_x2(j-1)));
    end
    if delta < 0.01
        properTimes = properTimes + 1;
    end
    
    %visual
    x1f = a:1:b;
    x2f = a:1:b;
    [xx1,xx2]=meshgrid(x1f,x2f);
    y=xx1 .^ 2 - xx2 .^ 2;
%     y =5 * xx1 .^ 2 + 8 * xx2 .^ 3;
    surf(xx1,xx2,y);
    for i = 1:N
        text(population_x1(i),population_x2(i),g(population_x1(i),population_x2(i)),'o')
    end
    hold off;
    %visual
    
end
end
