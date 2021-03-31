close all, clear, clc;

O = [0; 0; 0]; % origin
C = [0.5; 0.5; 1.5]; % camera origin

versor_origin = 0.5;
versor_camera = 0.2;

origin_axis = {'O';'X';'Y';'Z'};
camera_axis = {'oc','zc','xc','yc'};

grid on;
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % origin frame
text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)

axis equal
hold on;
quiver3([C(1);C(1);C(1)],[C(2);C(2);C(2)],[C(3);C(3);C(3)],[versor_camera;0;0],[0;versor_camera;0],[0;0;versor_camera]) % camera frame
text([C(1),C(1)+versor_camera,C(1),C(1)], [C(2),C(2),C(2)+versor_camera,C(2)], [C(3),C(3),C(3),C(3)+versor_camera], camera_axis)



d = C - O;

Rx = [1 0 0;
    0 cos(pi/2) -sin(pi/2);
    0 sin(pi/2) cos(pi/2)];

Ry = [cos(pi/2) 0 sin(pi/2);
    0 1 0;
    -sin(pi/2) 0 cos(pi/2)];

R = Rx*Ry;


Tco = [R d;
    zeros(1,3) 1];


%% P matrix

f = 0.015; % focal lenght
P = diag([f,f,1]) * [eye(3), zeros(3,1)];

p = [4.6; 0.25; 1.8];
scatter3(p(1),p(2),p(3));
scatter3(linspace(C(1),p(1)), linspace(C(2),p(2)), linspace(C(3),p(3)),' . ')
xlim([-0.5, 5])
ylim([-0.5, 2])
zlim([0, 2.5])
