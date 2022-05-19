%% This function will make the robot to place ball on
% the flatform which is given as input.

% Function is called as follows
% Place_to('a') % To place ball on flatfrom A
% Place_to('b') % To place ball on flatform B
% Place_to('c') % To place ball on flatform C

%%

function Place_to(y)

mylego=legoev3;

% Coordinates of flatform A,B,C
A=[111.5,0,55;  117.83,0,7.2;  111.5,0,55];
B=[0,111.5,55;  0,100.5,-70;   0,111.5,55];
C=[-111.5,0,55; -100.5,0,-70; -111.5,0,55];


switch y
    % To place ball on flatform A
    case 'a'
        for i=1:1:size(A,1)
            Lego_pid(A(i,1), A(i,2), A(i,3),mylego);
            pause(0.5);
            if i==2
                gripper(mylego,1);
                pause(0.5);
            end
        end
        
    % To place ball on flatform B
    case 'b'
        for i=1:1:size(B,1)
            Lego_pid(B(i,1), B(i,2), B(i,3),mylego);
            pause(0.5);
            if i==2
                gripper(mylego,1);
                pause(0.5);
            end
        end
        
    % To place ball on flatform C
    case 'c'
        for i=1:1:size(C,1)
            Lego_pid(C(i,1), C(i,2), C(i,3),mylego);
            pause(0.5);
            if i==2
                gripper(mylego,1);
                pause(0.5);
            end
        end
end
clear;
end


