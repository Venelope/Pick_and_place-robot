
% This function will bring robot to a standard position and resets all
% motors rotations to zeroes. Fot this two touch sensors are
% used when these sensors read 1 all motor will stop and reseted
% The gripper motor will be reset when its closed. The gripper opens and closes and remains closed,
% when speed is given and speed has to be alternate positive and negative.

% The home configuration is near red flatform

%%

function home_configuration

% Set up MATLAB and EV3 communication
mylego = legoev3;

%Set up motor based on your motor port numbers
mymotor1 = motor(mylego, 'C');  % Base motor
mymotor2 = motor(mylego, 'B');  % middle motor
mymotor3 = motor(mylego, 'A');  % gripper motor

% setting up touch sensors handels
mytouch1 = touchSensor(mylego,1);  %Base sensor
mytouch2 = touchSensor(mylego,3);  % middle or elbow sensor

speed1 = 35;   % For motor 1 to rotate towards red flatform
speed2 = -35;  % For motor 2 to to move arm upwards
% For gripper
speed3 = 15;
speed4 = -15;


while  readTouch(mytouch1)== 0 || readTouch(mytouch2)== 0
    start(mymotor1);
    start(mymotor2);
  
    
    mymotor1.Speed = speed1;
    mymotor2.Speed = speed2;
    
    % Reading touch sensors
    r1=readTouch(mytouch1);
    r2=readTouch(mytouch2);
    if  r1 == 1
        mymotor1.Speed = 0;
    end
    if r2 == 1
        mymotor2.Speed = 0;
    end
    
end

% Resetting motor rotation once both sensors pressed.
resetRotation(mymotor1);
resetRotation(mymotor2);

% Resetting gripper motor
% Making robot to close gripper  with positive speed
start(mymotor3);
mymotor3.Speed = speed3;
pause(1);

%Reading the angle again and giving negative speed if previous speed did not
%close the motor.

start(mymotor3);
mymotor3.Speed = speed4;
pause(1);


% once gripper is closed completly, resetting the rotation to zero
resetRotation(mymotor3);

gripper(mylego, 1);   % Calling gripper function to open

clear; clc
end

