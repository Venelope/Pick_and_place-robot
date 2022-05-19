% This function implements inverse kinematics of the robot
% It takes x, y, z as input and returns th1 and th3 andle in degrees.


%%

function [th1,th3] = inverse_kin( x, y ,z1)

% Link parameters
L1 = 50; L2 = 95; L3 = 185; L4=110;

% Adding link 4 length as it always remains vertical
z= z1+L4;

% Calculating base motor angle
th1 = atan2d( y,x);
if  th1==-180
    th1 = th1 + 360;
end

% Calculating angle 2
th45 = asind((z - L1 - L2/sqrt(2))/L3) +45;
% adding -180 to convert angle into joint angle
th3 = -180+th45 ;
end