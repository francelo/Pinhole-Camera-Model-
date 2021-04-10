clear, clc, close all;

%% parameters

O = [0; 0; 0];        % world origin frame
C = [0.2; -0.3; 0.6];  % camera origin frame

f = 0.8;             % focal lenght
% p = [2.1; 0.17; 0.8]; % point's position (x,y,z) in world frame

d = C - O;            % distance between camera and world frame
ang = [pi/2  0  pi/2]; 
init_pose = [C ; ang'];
frequency = 200;       % sampling frequency [Hz]
dT = 1/frequency; % sampling time [s]


% % points' position (x,y,z) in world frame
p1 = [2.4; 0.8; 1.1]; 
p2 = [2.4; 0.1; 1.1]; 
% reference 
ref1 = [-0.35; -0.0];
ref2 = [0.15;  -0.0];
ref = [ref2; ref1];

% control
Kp = 1*eye(4);
%Kp = diag([70, 10, 70, 10]);
Kd = 0*eye(4);
%Kd = diag([0.8, 0.5 0.8 0.5]);
