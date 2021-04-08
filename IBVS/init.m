clear, clc, close all;

%% parameters

O = [0; 0; 0];        % world origin frame
C = [0.2; 0.3; 0.6];  % camera origin frame

f = 0.05;             % focal lenght

d = C - O;            % distance between camera and world frame
ang = [pi/2 pi/2 0]; 
init_pose = [C ; ang'];
frequency = 200;       % sampling frequency [Hz]
delta_t = 1/frequency; % sampling time [s]

% points' position (x,y,z) in world frame
p1 = [1.2; 0.45; 0.8]; 
p2 = [1.2; 0.45; 0.8]; 

Kp = 10 * eye(4);
Kd = 0 * eye(4);
