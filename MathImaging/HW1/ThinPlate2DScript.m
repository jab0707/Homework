
clear();clf();close all;

%Generate Data
x_i = [1,2,3,4,3,5];
y_i = [2,4,6,8,2,3];
a_i = [1,4,7,2,1,0];
n = length(x_i);

%Put things into the form of the projection theorm
%Need a matrix composed of the control points (P)
%Need a matrix composed of the kernal (r^2)log(r) where r is the euclidean
%distance between two points. For the K matrix the points considered are
%all of the control point combinations

%Fintally need a matrix (Y) composed of the alpha values.

%This is the application of projection theorm.
%Then by assembling L = [K , P; p', 0] we can invert it to get W
%W is the weigths vector for each control point and the three constants (a1,a2,a3). We now have all
%we need to solve the equation 
%f(x,y) = a1 + a2x + a3y + sumOveri(W(i)*kernal(r)) where R = norm([xi,yi] - P(i));

%Generate P matrix
controlP = zeros(length(x_i),3);
controlP(:,1) = 1;
controlP(:,2) = x_i;
controlP(:,3) = y_i;
%Generate Y matrix
Y = zeros(length(a_i)+3,1);
Y(1:length(a_i),1) = a_i;

K = zeros(n,n);

for i = 1:n
    for j = 1:n
        r = norm(controlP(i,:) - controlP(j,:));
        if r == 0
            k(i,j) = 0;
        else
            K(i,j) = (r*r)*log(r);
        end
    end
end

L = zeros(n+3,n+3);
L(1:n,1:n) = K;
L(n+1:end,1:n) = controlP';
L(1:n,n+1:end) = controlP;



W = inv(L) * Y;

a1 = W(end-2);
a2 = W(end-1);
a3 = W(end);
%Plot a surface to test
x = linspace(-10,10,201);
y = linspace(-10,10,201);
fx = zeros(100,100);

for i = 1:length(x)
    for j = 1:length(y)
        theSum = 0 ;
        for k = 1:n
            r = norm(controlP(k,2:3)-[x(i),y(j)]);
            if r ~= 0
                theSum = theSum + W(k)*(r*r)*log(r);
            end
            
        end
        
        fx(i,j) = a1 + a2*x(i) +a3*y(j) +theSum;
        x_plot(i,j) = x(i);
        y_plot(i,j) = y(j);
    end
end

figure(1);hold on; surf(x_plot,y_plot,fx);
controlPts = [x_i;y_i;a_i];
pcshow(controlPts','r','MarkerSize',255);Title('TPS');
