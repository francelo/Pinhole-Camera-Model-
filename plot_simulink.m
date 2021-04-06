%%
close all
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
camera_axis = {'oc','zc','xc','yc'};
plane_y = 0.25;       % y image plane width
plane_z = 0.18;       % z image plane height

%%
subplot(1,2,1)
grid on; 
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)

axis equal
hold on;
quiver3([C(1);C(1);C(1)],[C(2);C(2);C(2)],[C(3);C(3);C(3)],[versor_camera;0;0],[0;versor_camera;0],[0;0;versor_camera]) % camera frame
text([C(1),C(1)+versor_camera,C(1),C(1)], [C(2),C(2),C(2)+versor_camera,C(2)], [C(3),C(3),C(3),C(3)+versor_camera], camera_axis)
% create image plane
x = linspace(C(1)+f,C(1)+f,20);
y = linspace(C(2)-plane_y,C(2)+plane_y,20);
z = linspace(C(3)-plane_z,C(3)+plane_z,20);

[X, Y] = meshgrid(x,y);
Z = meshgrid(z);
s = surf(X,Y,Z,'FaceAlpha',0.3);
s.EdgeColor = 'none';

%%
xlim([-0.2, max(out.moving_point(:,1))])
ylim([-0.2, max(out.moving_point(:,2))])
zlim([0,    max(out.moving_point(:,3))])

subplot(1,2,2)
 xlim([min(out.moving_projection(:,1))-0.02, max(out.moving_projection(:,1))+0.02])
 ylim([min(out.moving_projection(:,2))-0.02, max(out.moving_projection(:,2))+0.02])


for i = 1:length(out.moving_point)
    subplot(1,2,1)
    scatter3(out.moving_point(i,1),out.moving_point(i,2),out.moving_point(i,3));
    subplot(1,2,2)
    cla(subplot(1,2,2))
    take_photo(out.moving_projection(i,:))
    
    pause(0.02)
end


