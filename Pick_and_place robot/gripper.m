% The gripper function opens and closes the gripper based on the value of x
% If x is 1 then it opens and x is 0 then it closes.
% After home configuration the gripper will be in closed condition with
% angle reading of motor 3 to zero.

%Gripper motor operating : If the gripper motor is opened with positive
%speed then its closed with negative speed and vice versa. When its opened
%with positive speed it reads angle around 80 and when its closed it read
%angle around 0 and when its opened with negative speed it reads -80 and
%when closed it reads less than or equal to 0.


function gripper(mylego, x)

% defining motor handle
mymotor3 = motor(mylego, 'A');
speed1= 9;
speed2=-9;

R1 = double(readRotation(mymotor3));

% The condition indicates that gripper is in closed state
% and it needs to be opened. ( trying to open with positive speed).
if  (R1 >=0 && R1 < 40 ) && x==1
    while true
        r1 = double(readRotation(mymotor3));
        start(mymotor3);
        mymotor3.Speed = speed1;
        if r1 > 73
            mymotor3.Speed = 0;
            break
        end
    end
end

% This condition indicates that gripper is in closed state
% and it needs to be opened.( trying to open with negative speed
% if it's not opened previously with positive speed).

R2 = double(readRotation(mymotor3));
if (R2 <= 0 && R2 >-40) && x==1
    while true
        r2 = double(readRotation(mymotor3));
        start(mymotor3);
        mymotor3.Speed = speed2;
        if r2 < -73
            mymotor3.Speed = 0;
            break
        end
    end
end

% This condition indicates that gripper is in opened state and
% needs to be closed.

% closing with positive speed
R3 = double(readRotation(mymotor3));
if R3 <= -50 && x==0
    start(mymotor3)
    mymotor3.Speed=speed1;
end

% Closing with negative speed
if R3 >=50 && x==0
    start(mymotor3)
    mymotor3.Speed=speed2;
end
end
