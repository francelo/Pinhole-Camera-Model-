clear, clc, close all;

%% parameters

robot = loadrobot('frankaEmikaPanda');
% removeBody(robot, 'panda_leftfinger');
% removeBody(robot, 'panda_rightfinger');
% removeBody(robot, 'panda_hand');
% removeBody(robot, 'panda_link8');
% removeBody(robot, 'panda_link7');

% initial 
q_init = [(0.0) (0.0) (0.0) (-pi/3) (0.0) (pi/3) (pi/4) (0.04) (0.04)];

config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1','panda_finger_joint2'},...
                'JointPosition',{q_init(1),q_init(2),q_init(3),q_init(4),q_init(5),q_init(6),q_init(7),q_init(8),q_init(9)});
            
workspace_dim = 0.7;  % robot workspace [m]
O = [0; 0; 0];        % world origin frame
f = 0.025;            % focal lenght
plane_x = 0.12;       % x image plane width
plane_y = 0.1;        % y image plane height

T = getTransform(robot,config,'panda_link1','panda_hand');
position = T^-1 * [O; 1];
orientation = tform2eul(T^-1);
init_pose = [position(1:3); orientation'];

%init_pose = [C ; ang'];
frequency = 100;       % sampling frequency [Hz]
dT = 1/frequency;

% % points' position (x,y,z) in world frame
p = [0.5; 0.0; 0.5];     % points' position (x,y,z)
o = [0; 0; 0];        % points' orientation 
l1 = 0.06;
l2 = 0.04;

% camera relative frame
phi = 0;
theta = pi;
psi = pi/2;
R_cam = rot(phi, theta, psi);
camera_offset = rot(pi, 0, 0) * [-0.0; 0.0; -0.0];

% reference 
ref1 = [-0.03; -0.0];
ref2 = [0.03;  0.0];
ref3 = [-0.03; 0.03];
ref4 = [0.03;  0.03];
ref = [ref1; ref2; ref3; ref4];
tolerance = 0.002; % error tolerance [cm]

% control
Kp = 3*eye(8);
Kd = 0*eye(8);
Kh = eye(9);     % 
Kg = 3*eye(9);   % gripper gain matrix

% Kalman Filter parameters
P0 = eye(6)*1;
R = eye(6)*0.0001;
Q = zeros(6);
DT = 1/20; % [1/Hz]

% plot sample time
st = 0.05;
