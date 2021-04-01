close all, clear, clc;

%% parameters
% frame
O = [0; 0; 0]; % origin
C = [0.2; 0.3; 0.6]; % camera origin
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
camera_axis = {'oc','zc','xc','yc'};

% point (x,y,z)
p = [1.0; 0.15; 0.8];

% focal lenght
f = 0.05;

% 
d = C - O;

Rx = [1 0 0;
    0 cos(pi/2) -sin(pi/2);
    0 sin(pi/2) cos(pi/2)];

Ry = [cos(pi/2) 0 sin(pi/2);
    0 1 0;
    -sin(pi/2) 0 cos(pi/2)];

R = Rx*Ry;


Twc = [R d;
    zeros(1,3) 1];

p_cam = Twc^-1 * [p;1]

% camera projection matrix
P = diag([f,f,1]) * [eye(3), zeros(3,1)];

p_tilde = P*[p;1];
x_proj = p_tilde(1)/p(3)
y_proj = p_tilde(2)/p(3)

%% plot

grid on;
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % origin frame
text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)

axis equal
hold on;
quiver3([C(1);C(1);C(1)],[C(2);C(2);C(2)],[C(3);C(3);C(3)],[versor_camera;0;0],[0;versor_camera;0],[0;0;versor_camera]) % camera frame
text([C(1),C(1)+versor_camera,C(1),C(1)], [C(2),C(2),C(2)+versor_camera,C(2)], [C(3),C(3),C(3),C(3)+versor_camera], camera_axis)

scatter3(p(1),p(2),p(3));
scatter3(linspace(C(1),p(1)), linspace(C(2),p(2)), linspace(C(3),p(3)),' . ')


x=linspace(C(1)+f,C(1)+f,20);
y=linspace(C(2)-0.25,C(2)+0.25,20);
z=linspace(C(3)-0.18,C(3)+0.18,20);

[X, Y] = meshgrid(x,y);
Z = meshgrid(z);
s = surf(X,Y,Z,'FaceAlpha',0.3);
s.EdgeColor = 'none';

% xlim([-2.5, 5])
% ylim([-2.5, 3])
% zlim([0, 3.5])
