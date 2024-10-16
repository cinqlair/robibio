% https://lucidar.me/fr/mathematics/how-to-calculate-the-intersection-points-of-two-circles/
function [S1,S2] = intersectCircles(P1, r1, P2, r2)
%% Calculate d
d=sqrt( (P2(1)-P1(1))*(P2(1)-P1(1)) + (P2(2)-P1(2))*(P2(2)-P1(2)) );


%% Calculate a and b
a = (r1*r1 - r2*r2 + d*d) / (2*d);
b = (r2*r2 - r1*r1 + d*d) / (2*d);

%% Calculate h
h=sqrt(r1*r1 - a*a);

%% Coordinates of P5
P5 = [ P1(1) + (a/d)*(P2(1)-P1(1)) , P1(2) + (a/d)*(P2(2)-P1(2)) ];

%% Intersection points
S1 = [ P5(1) - h*(P2(2)-P1(2))/d ; P5(2) + h*(P2(1)-P1(1))/d];
S2 = [ P5(1) + h*(P2(2)-P1(2))/d ; P5(2) - h*(P2(1)-P1(1))/d];
end

