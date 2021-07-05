clear, clc, close all;

%% parameters
robot = importrobot('franka_hand.urdf');

% initial 
q_init = [ (0.0) (0.0) (0.0) (-pi/3) (0.0) (pi/3) (0.0) ];

config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7'},...
                'JointPosition',{q_init(1),q_init(2),q_init(3),q_init(4),q_init(5),q_init(6),q_init(7)});
  
workspace_dim = 0.7;  % robot workspace [m]
O = [0; 0; 0];        % world origin frame
f = 0.0019;            % focal lenght
plane_x = 0.012;       % x image plane width
plane_y = 0.008;        % y image plane height

T = getTransform(robot,config,'panda_link0','right_hand');
position = T^-1 * [O; 1];
orientation = tform2eul(T^-1);
init_pose = [position(1:3); orientation'];

%init_pose = [C ; ang'];
frequency = 100;       % sampling frequency [Hz]
dT = 1/frequency;      % sampling time [s]

% points' pose in world frame
p = [0.3; 0.3; 0.1];     % points' position (x,y,z)
o = [0; 0; pi/2];        % points' orientation 
l1 = 0.06;
l2 = 0.04;

% camera relative frame
phi = 0;
theta = pi;
psi = pi/2;
R_cam = rot(phi, theta, psi);
camera_offset = rot(pi, 0, 0) * [-0.06; 0.0; -0.04];
 
% reference - camera desired pose relative to the object 
ref = [0; 0; 0.06; -pi/2;  0; -pi];
tolerance = 0.02; % error tolerance [cm]

% control
Kp = diag([1.3 1.3 1.3 1.3 1.3 1.3]);
Kd = 0*eye(6);
Kh = eye(7);     % 
Kg = 3*eye(7);   % gripper gain matrix


% Kalman Filter parameters
P0 = eye(6)*1;
R = eye(6)*0.0001;
Q = zeros(6);
DT = 1/20; % [1/Hz]

% plot sample time
st = 0.05;
