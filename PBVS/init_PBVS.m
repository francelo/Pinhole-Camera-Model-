clear, clc, close all;

%% parameters

robot = importrobot('frankaEmikaPanda.urdf');
q_init = zeros(1, 9);
syms q1 q2 q3 q4 q5 q6 q7 q8 q9
config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1', 'panda_finger_joint2'},'JointPosition',{q1,q2,q3,q4,q5,q6,q7,q8,q9});

O = [0; 0; 0];        % world origin frame
C = [0.2; 0.3; 0.2];  % camera origin frame

f = 0.5;             % focal lenght
% p = [2.1; 0.17; 0.8]; % point's position (x,y,z) in world frame

d = C - O;            % distance between camera and world frame
ang = [pi/2  0  pi/2];  % initial orientation, [pi 0 pi/2] 
init_pose = [C ; ang'];
frequency = 200;       % sampling frequency [Hz]
dT = 1/frequency;      % sampling time [s]


% % points' position (x,y,z) in world frame
p1 = [0.2; 0.35; 0.3]; 
p2 = [1.7; 0.85; 0.1]; 
% reference 
%ref1 = [-0.18; -0.0];
%ref2 = [0.18;  -0.0];
%ref = [ref1; ref2];
ref = [-0.2; 0; 0; pi/2; 0 ; pi/2];

% control
Kp = 10*eye(6);
Kd = 0*eye(6);
