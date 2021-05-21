clear, clc, close all;

%% parameters

robot = loadrobot('frankaEmikaPanda');
% removeBody(robot, 'panda_leftfinger');
% removeBody(robot, 'panda_rightfinger');
% removeBody(robot, 'panda_hand');
% removeBody(robot, 'panda_link8');
% removeBody(robot, 'panda_link7');
q = [0. 0. 0. -pi/2 0. pi/2 0. 0 0.];

config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1','panda_finger_joint2'},...
        'JointPosition',{q(1),q(2),q(3),q(4),q(5),q(6),q(7),q(8),q(9)});
    
O = [0; 0; 0];        % world origin frame
f = 0.1;              % focal lenght
plane_x = 0.15;        % x image plane width
plane_y = 0.12;       % y image plane height

T = getTransform(robot,config,'panda_link1','panda_hand');
position = T^-1 * [O; 1];
orientation = tform2eul(T^-1);
init_pose = [position(1:3); orientation'];

frequency = 500;       % sampling frequency [Hz]
dT = 1/frequency;      % sampling time [s]


% % points' position (x,y,z) in world frame
p1 = [0.5; 0.0; 0.1]; 
p2 = [0.5; 0.1; 0.1]; 
% reference 
ref1 = [-0.06; -0.0];
ref2 = [0.06;  -0.0];
ref = [ref1; ref2];

% control
Kp = 3*eye(4);
Kd = 0*eye(4);


% Kalman Filter parameters
P0 = eye(6)*0.5;
R = eye(6)*0.001;
Q = zeros(6);
DT = 1/20; % [Hz]