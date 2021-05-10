function T = direct_kinematic(q)

A = @(a,d,alpha,theta)[
    cos(theta)     -cos(alpha)*sin(theta)      sin(alpha)*sin(theta)      a*cos(theta);
    sin(theta)      cos(alpha)*cos(theta)     -sin(alpha)*cos(theta)      a*sin(theta);
        0                  sin(alpha)                 cos(alpha)                d;
        0                      0                           0                    1
];

A1 = @(theta1)[A( 0,        0.333,     0,      theta1)];
A2 = @(theta2)[A( 0,            0,   -pi/2,    theta2)];
A3 = @(theta3)[A( 0,        0.316,    pi/2,    theta3)];
A4 = @(theta4)[A( 0.0825,       0,    pi/2,    theta4)];
A5 = @(theta5)[A(-0.0825,   0.384,   -pi/2,    theta5)];
A6 = @(theta6)[A( 0,            0,    pi/2,    theta6)];
A7 = @(theta7)[A( 0,        0.107,    pi/2,    theta7)];

Transformation=@(theta1,theta2,theta3,theta4,theta5,theta6,theta7)[ ...
    A1(theta1) * ...
    A2(theta2) * ...
    A3(theta3) * ... 
    A4(theta4) * ...
    A5(theta5) * ...
    A6(theta6) * ... 
    A7(theta7)];

q1 = q(1); q2 = q(2); q3 = q(3); q4 = q(4); q5 = q(5); q6 = q(6); q7 = q(7);
T = Transformation(q1,q2,q3,q4,q5,q6,q7);


end