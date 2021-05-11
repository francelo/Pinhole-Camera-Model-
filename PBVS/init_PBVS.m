clear, clc, close all;

%% parameters
robot = loadrobot('frankaEmikaPanda');
removeBody(robot, 'panda_leftfinger');
removeBody(robot, 'panda_rightfinger');
% removeBody(robot, 'panda_hand');
% removeBody(robot, 'panda_link8');
% removeBody(robot, 'panda_link7');
q_init = [0 0 0 -pi/2 0 0 0];
syms q1 q2 q3 q4 q5 q6 q7
config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7'},'JointPosition',{q1,q2,q3,q4,q5,q6,q7});

O = [0; 0; 0];        % world origin frame
C = [0.2; 0.3; 0.2];  % camera origin frame

f = 0.5;             % focal lenght
% p = [2.1; 0.17; 0.8]; % point's position (x,y,z) in world frame

d = C - O;            % distance between camera and world frame
ang = [pi/2  0  pi/2];  % initial orientation, [pi 0 pi/2] 
init_pose = [C ; ang'];
frequency = 500;       % sampling frequency [Hz]
dT = 1/frequency;      % sampling time [s]


% % points' position (x,y,z) in world frame
p1 = [0.3; 0.1; 0.1]; 
p2 = [1.7; 0.85; 0.1]; 
% reference 
%ref1 = [-0.18; -0.0];
%ref2 = [0.18;  -0.0];
%ref = [ref1; ref2];
ref = [0; 0; 0.3; 0;  pi/2; -pi/2];

% control
%Kp = 1*eye(6);
Kp = diag([1 1 1 1 1 1]);
Kd = 0*eye(6);
