%%
h = figure();
set(gcf,'position',[100,50,1280,720])
subplot(1,2,1)
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
p1_ = out.p;


%% plot point

grid on; 
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
 
x_pose = out.pose(:, 1);
y_pose = out.pose(:, 2);
z_pose = out.pose(:, 3);
ang = out.pose(:, 4:6); 

for i = 2:length(out.pose)
    
    %% subplot 1 (robot)
    cla(subplot(3,2,[1 3 5]));
    grid on; 
    axis equal
    
    hold on
    quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
    text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)
    
    %rotation = rot(ang(i,1),ang(i,2),ang(i,3))*rot(0,pi/2,pi);
    %quiver3([x_pose(i);x_pose(i);x_pose(i)],[y_pose(i);y_pose(i);y_pose(i)],[z_pose(i);z_pose(i);z_pose(i)],rotation(1,:)'/2,rotation(2,:)'/3,rotation(3,:)'/3) % camera frame
    
    scatter3(p1_(i,1), p1_(i,2), p1_(i,3));
    
    config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1','panda_finger_joint2'},...
        'JointPosition',{out.q(i,1),out.q(i,2),out.q(i,3),out.q(i,4),out.q(i,5),out.q(i,6),out.q(i,7),out.q(i,8),out.q(i,9)});
    show(robot, config);
    
    if out.remaining_time(i) == 0
        title('Remaining time [s]:', '-')
    else if out.remaining_time(i) > 100
            title('Remaining time [s]:', '∞')
        else
            title('Remaining time [s]:', out.remaining_time(i))
        end
    end
    
     %% subplot 2 (error)
    cla(subplot(3,2,2));
    hold on
    grid on
    axis([0 length(out.error) -1 0.3])
    plot(out.error(1:i, :))
    title('Error')
    
    %% subplot 3 (states)
    cla(subplot(3,2,4));
    hold on
    grid on
    axis([0 length(out.states) -0.1 1.1])
    plot(out.states(1:i, :))
    legend("camera flag", 'control flag','grasp flag')
    title('States')
    
    %% subplot 4
    cla(subplot(3,2,6));
    hold on
    grid on
    scatter(out.proj(i,1), out.proj(i,2))
    rectangle('Position',[-plane_x -plane_y 2*plane_x 2*plane_y])
    axis([(-plane_x-0.002) (plane_x+0.002) (-plane_y-0.02) (plane_y+0.02)])
    axis equal
    title('Image Plane');
    
    %%
    pause(0.0001);
    F(i) = getframe(h);
end

%%
% 
% video = VideoWriter('PBVS without SOT.avi', 'Uncompressed AVI');
% video.FrameRate = 5;
% open(video);
% writeVideo(video, F);
% close(video);

