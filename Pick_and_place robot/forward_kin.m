% This function implements forward kinematics.
% It is used to find coordinates X,Y,Z for station
% A, B, C.

%%

function [x , y , z]=forward_kin(th1,th3)

L1 = 50; L2 = 95; L3 = 185; L4=110;


x = -cosd(th1)*(L3*(cosd(th3) + sind(th3)) + L2)/sqrt(2);
y = -sind(th1)*(L3*(cosd(th3) + sind(th3)) + L2)/sqrt(2);
z = -(L3 * (-cosd(th3)+sind(th3)) -L2 -sqrt(2)*L1)/sqrt(2) - L4;


end
