%% load robot
close all;
robot = loadrobot('frankaEmikaPanda');
q_init = [(0.0) (0.0) (0.0) (-pi/2) (0.0) (pi/2) (pi/4) (0.04) (0.04)];

config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1','panda_finger_joint2'},...
        'JointPosition',{q_init(1),q_init(2),q_init(3),q_init(4),q_init(5),q_init(6),q_init(7),q_init(8),q_init(9)});
N = 50;

%% D-H parameters
a1 = 0;
a2 = 0;
a3 = 0;
a4 = 0.0825;
a5 = -0.825;
a6 = 0;
a7 = 0.088;
%
d1 = 0.333;
d2 = 0;
d3 = 0.316;
d4 = 0;
d5 = 0.384;
d6 = 0;
d7 = 0;
%
alpha1 = 0;
alpha2 = -pi/2;
alpha3 = pi/2;
alpha4 = pi/2;
alpha5 = -pi/2;
alpha6 = pi/2;
alpha7= pi/2;
%
theta1_min = -166 * (pi/180);
theta1_max =  166 * (pi/180);
theta2_min = -101 * (pi/180);
theta2_max =  101 * (pi/180);
theta3_min = -166 * (pi/180);
theta3_max =  166 * (pi/180);
theta4_min = -176 * (pi/180);
theta4_max = -4   * (pi/180);
theta5_min = -166 * (pi/180)*0;
theta5_max =  166 * (pi/180)*0;
theta6_min = -1   * (pi/180);
theta6_max =  215 * (pi/180);
theta7_min = -166 * (pi/180);
theta7_max =  166 * (pi/180);
%

theta1 = (theta1_max - theta1_min).*rand(N,1) + theta1_min;
theta2 = (theta2_max - theta2_min).*rand(N,1) + theta2_min;
theta3 = (theta3_max - theta3_min).*rand(N,1) + theta3_min;
theta5 = (theta5_max - theta5_min).*rand(N,1) + theta5_min;
theta6 = (theta6_max - theta6_min).*rand(N,1) + theta6_min;
theta7 = (theta7_max - theta7_min).*rand(N,1) + theta7_min;

theta4 = theta2 - theta6;

%% iterations
for i = 1:N
    A1 = Transf(a1,alpha1,d1,theta1(i));
    A2 = Transf(a2,alpha2,d2,theta2(i));
    A3 = Transf(a3,alpha3,d3,theta3(i));
    A4 = Transf(a4,alpha4,d4,theta4(i));
    A5 = Transf(a5,alpha5,d5,theta5(i));
    A6 = Transf(a6,alpha6,d6,theta6(i));
    A7 = Transf(a7,alpha7,d7,theta7(i));
    T = A1 * A2 * A3 * A4 * A5 * A6 * A7;
    X(i) = T(1,4);
    Y(i) = T(2,4);
    Z(i) = T(3,4);
    plot3(X,Y,Z,'.')
    hold on;
    radius(i) = norm([X(i), Y(i), Z(i)]);
    i
end
%%
show(robot,config,'visuals','on')
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m] ');
[x, y, z] = sphere;
x = x*max(radius);
y = y*max(radius);
z = z*max(radius);
s = surf(x,y,z,'FaceAlpha',0.2);
s.EdgeColor = 'none';
grid on

view(2);


function T = Transf(a, b, c, d )
T = [ cos(d),    -sin(d)*cos(b),      sin(d)*sin(b),    a*cos(d);
      sin(d),     cos(d)*cos(b),     -cos(d)*sin(b),    a*sin(d);
      0,            sin(b),             cos(b),           c;
      0,            0,                    0,              1];
end