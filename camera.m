close all, clear, clc;

%% parameters
% frame
O = [0; 0; 0]; % world origin
C = [0.2; 0.3; 0.6]; % camera origin
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
camera_axis = {'oc','zc','xc','yc'};
plane_y = 0.25; % y image plane width
plane_z = 0.18; % z image plane height

f = 0.05; % focal lenght
p = [1.0; 0.15; 0.8]; % point (x,y,z)
d = C - O;  
ang = [pi/2 pi/2 0];

[x_proj y_proj] = proj(p, ang, d, f)

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
y=linspace(C(2)-plane_y,C(2)+plane_y,20);
z=linspace(C(3)-plane_z,C(3)+plane_z,20);

[X, Y] = meshgrid(x,y);
Z = meshgrid(z);
s = surf(X,Y,Z,'FaceAlpha',0.3);
s.EdgeColor = 'none';

%%
[x_proj y_proj] = proj(p, ang, d, f)

w = 0.1   % width of the object
h = 0.2   % height of the object
x_surf = linspace(p(1)-w, p(1)+w, 3)
y_surf = linspace(p(2)-w, p(2)+w, 3)
z_surf = linspace(p(3)-h, p(3)+h, 3)
[X_surf, Y_surf] = meshgrid(x_surf,y_surf);
Z_surf = meshgrid(z_surf);

s = surf(X_surf,Y_surf,Z_surf,'Facealpha',0.3);

points = [x_surf             x_surf                         x_surf;
          y_surf [y_surf(2) y_surf(3) y_surf(1)] [y_surf(3) y_surf(1) y_surf(2)]; 
          z_surf             z_surf                         z_surf]
      


% points of the surface

