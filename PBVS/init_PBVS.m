clear, clc, close all;

%% parameters
robot = loadrobot('frankaEmikaPanda');
% removeBody(robot, 'panda_leftfinger');
% removeBody(robot, 'panda_rightfinger');
% removeBody(robot, 'panda_hand');
% removeBody(robot, 'panda_link8');
% removeBody(robot, 'panda_link7');

% initial 
q_init = [0. 0. 0. -pi/2 0 pi/2 pi/4 0.04 0.04];

config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1','panda_finger_joint2'},...
        'JointPosition',{q_init(1),q_init(2),q_init(3),q_init(4),q_init(5),q_init(6),q_init(7),q_init(8),q_init(9)});
    
O = [0; 0; 0];        % world origin frame
f = 0.1;              % focal lenght
plane_x = 0.1;        % x image plane width
plane_y = 0.08;       % y image plane height

  

T = getTransform(robot,config,'panda_link1','panda_hand');
position = T^-1 * [O; 1];
orientation = tform2eul(T^-1);
init_pose = [position(1:3); orientation'];

%init_pose = [C ; ang'];
frequency = 500;       % sampling frequency [Hz]
dT = 1/frequency;      % sampling time [s]

% % points' position (x,y,z) in world frame
p = [0.4; 0.1; 0.2]; 
 
% reference 

ref = [0; 0; 0.1; 0;  0; -pi];
tolerance = 0.02; % error tolerance [cm]

% control
%Kp = diag([6 6 6 8 8 8]);
Kp = diag([1 1 1 3 3 3]);
%Kp = eye(6)*5;
Kd = 0.1*eye(6);
Kh = eye(9);     % 
Kg = 3*eye(9);   % gripper gain matrix


% Kalman Filter parameters
P0 = eye(6)*1;
R = eye(6)*0.001;
Q = zeros(6);
DT = 1/20; % [Hz]
