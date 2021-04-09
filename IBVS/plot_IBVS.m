%%
figure()
subplot(1,2,1)
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
plane_y = 0.25;       % y image plane width
plane_z = 0.18;       % z image plane height

%% plot point

 grid on; 
 quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
% text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)
% 
% axis equal
% hold on;
% 
% scatter3(p(1),p(2),p(3)); 
% scatter3(linspace(C(1),p(1)), linspace(C(2),p(2)), linspace(C(3),p(3)),' . ')

x_pose = out.pose(:, 1);
y_pose = out.pose(:, 2);
z_pose = out.pose(:, 3);
ang = out.pose(:, 4:6);


for i = 1:length(out.pose)
    %% subplot 1
    cla(subplot(1,2,1));
    grid on; 
    axis equal
    
    hold on
    quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
    text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)
    
    rotation = rot(ang(i,1),ang(i,2),ang(i,3));
    quiver3([x_pose(i);x_pose(i);x_pose(i)],[y_pose(i);y_pose(i);y_pose(i)],[z_pose(i);z_pose(i);z_pose(i)],rotation(1,:)',rotation(2,:)',rotation(3,:)') % camera frame

%   image plane
%     x = linspace(C(1)+f,C(1)+f,20);
%     y = linspace(C(2)-plane_y,C(2)+plane_y,20);
%     z = linspace(C(3)-plane_z,C(3)+plane_z,20);
%     [X, Y] = meshgrid(x,y);
%     Z = meshgrid(z);
%     s = surf(X,Y,Z, ang,'FaceAlpha',0.3);
%     s.EdgeColor = 'none';
    scatter3(p1(1),p1(2),p1(3));
    scatter3(p2(1),p2(2),p2(3));
    
    %% subplot 2
    cla(subplot(1,2,2));
    hold on
    scatter(ref1(1),ref1(2),'red','x');
    scatter(ref2(1),ref2(2),'red','x');
    grid on
    xlim([-0.45, 0.45])
    ylim([-0.18, 0.18])
    take_photo(out.proj1(i,:))
    take_photo(out.proj2(i,:))
    pause(0.0005);
end

% take_photo(out.proj1)
% take_photo(out.proj2)


