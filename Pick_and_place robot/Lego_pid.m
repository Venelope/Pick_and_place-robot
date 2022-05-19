
% This function will implement pid controller
% by taking x y z and mylego as input
% Base motor is mymotor1, elbow or middle motor is mymotor2

%%

function  Lego_pid(x , y , z1, mylego)

[th1,th3] = inverse_kin( x, y ,z1); % calling inverse kinematics function.

% changing signs of angle in order to match direction of rotation of
% lego motors and that of frames attached to robot.
th_1 = -th1;
th_3 = -th3;

%% Giving compensation for backlash and restriction due to cable
th_1(th_1<-85 & th_1> -95)=th_1-15;
th_1(th_1<-160 & th_1> -200)=th_1-20;

% Creating motor handels
mymotor1 = motor(mylego, 'C');
mymotor2 = motor(mylego, 'B');

% PID parameters

% for motor 1
Kp1=0.7;  Ki1=0.8;
% For motor 2 
Kp2=0.8;  Ki2=0.85;
Int_error = [0 0];     
Ts = 0.01; % sample time


%% Operations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while true
    
    r1 =double(readRotation(mymotor1))*12/36;         % Read rotation counter in degrees multiplied by gear ratio
    r2 =double(readRotation(mymotor2))*8/40 +94;      %94 degree is mechanical constraints
    
    % PID terms calculation
    error = ([th_1, th_3]-[r1, r2]);
    Int_error = Int_error + error*Ts;
    
    % Adding 15 and -15 as minimum speed required for motor 1 to move 
    if error(1,1)>=0
        output1 = error(1,1)*Kp1 + Int_error(1,1)*Ki1 +15;
    elseif error(1,1) < 0
        output1 = error(1,1)*Kp1 + Int_error(1,1)*Ki1 -15;
    end
    
    % Adding -25 and 8 as minimum speed required for motor 2 to move up and
    % down respectively
    if error(1,2)>=0
        output2 = error(1,2)*Kp2 + Int_error(1,2)*Ki2 + 8;
    elseif error(1,2) <0
        output2 = error(1,2)*Kp2 + Int_error(1,2)*Ki2 -25;
    end
    
    % Saturating pid output 1 and output 2
    output1(output1 < -30)=-30;
    output1(output1 > 30)=30;
    output2(output2 < -35)=-35;
    output2(output2 > 20)=20;
    
    start(mymotor1);
    start(mymotor2);
    

    % Giving output as a speed to reach desired position
    if abs(error(1,1))>= 2
        mymotor1.Speed = output1;
    end
    if abs(error(1,2))>= 2
        mymotor2.Speed = output2;
    end
    
    if abs(error(1,1))< 2
        mymotor1.Speed = 0;
    end
    if abs(error(1,2)) < 2
        mymotor2.Speed = 0;
    end
    
    % Breaking when error limit is reached
    if abs(error(1,1))< 2 && abs(error(1,2))< 2
        break
    end
    
    % Sample time
    pause(Ts);
end

clear;

end
