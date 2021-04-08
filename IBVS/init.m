clear, clc, close all;

%% parameters

O = [0; 0; 0];        % world origin frame
C = [0.2; 0.3; 0.6];  % camera origin frame

f = 0.05;             % focal lenght
p = [2.1; 0.17; 0.8]; % point's position (x,y,z) in world frame
d = C - O;            % distance between camera and world frame
ang = [pi/2 pi/2 0]; 
init_pose = [C ; ang'];
frequency = 200;       % sampling frequency [Hz]
delta_t = 1/frequency; % sampling time [s]
Kp = 100*eye(2);
Kd = 0*eye(2);
