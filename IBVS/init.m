clear, clc, close all;

%% parameters

O = [0; 0; 0];        % world origin frame
C = [0.2; -0.3; 0.6];  % camera origin frame

f = 0.7;             % focal lenght
% p = [2.1; 0.17; 0.8]; % point's position (x,y,z) in world frame

d = C - O;            % distance between camera and world frame
ang = [pi/2  0  pi/2]; 
init_pose = [C ; ang'];
frequency = 200;       % sampling frequency [Hz]
delta_t = 1/frequency; % sampling time [s]


% % points' position (x,y,z) in world frame
p1 = [2.0; 0.8; 0.9]; 
p2 = [2.0; 0.1; 0.9]; 
% reference 
ref1 = [-0.35; -0.0];
ref2 = [0.15;  -0.0];
ref = [ref1; ref2];

% control
Kp = 10*eye(4);
Kp = diag([65, 10, 65, 10]);
Kd = 0.2*eye(4);
Kd = diag([0.5, 0.2 0.5 0.2]);
