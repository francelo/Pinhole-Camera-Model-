%%
h = figure();
set(gcf,'position',[100,50,1280,720])
subplot(1,2,1)
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
p_pos = out.p(:,1:3); % point position
p_or = out.p(:, 4:6); % point orientation
time = linspace(0,length(out.states)*st,length(out.states));


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
    
    rotation = rot(p_or(i,1),p_or(i,2),p_or(i,3));
    quiver3([p_pos(i,1);p_pos(i,1);p_pos(i,1)],[p_pos(i,2);p_pos(i,2);p_pos(i,2)],[p_pos(i,3);p_pos(i,3);p_pos(i,3)],rotation(1,:)'/20,rotation(2,:)'/20,rotation(3,:)'/20) % object frame
    
    p_1 = p_pos(i, 1:3)' + [-l1/2; -l2/2; 0];
    p_2 = p_pos(i, 1:3)' + [-l1/2; +l2/2; 0];
    p_3 = p_pos(i, 1:3)' + [l1/2; l2/2; 0];
    p_4 = p_pos(i, 1:3)' + [l1/2; -l2/2; 0];
    
    Robj = [cos(p_or(i,3)) -sin(p_or(i,3)) 0;
            sin(p_or(i,3)) cos(p_or(i,3))  0;
                0           0          1];
    
    p1 = p_pos(i, 1:3)' + Robj * (p_1 - p_pos(i, 1:3)');
    p2 = p_pos(i, 1:3)' + Robj * (p_2 - p_pos(i, 1:3)');
    p3 = p_pos(i, 1:3)' + Robj * (p_3 - p_pos(i, 1:3)');
    p4 = p_pos(i, 1:3)' + Robj * (p_4 - p_pos(i, 1:3)');
       
    plot3([p1(1);p2(1)], [p1(2);p2(2)], [p1(3);p2(3)])
    plot3([p2(1);p3(1)], [p2(2);p3(2)], [p2(3);p3(3)])
    plot3([p3(1);p4(1)], [p3(2);p4(2)], [p3(3);p4(3)])
    plot3([p4(1);p1(1)], [p4(2);p1(2)], [p4(3);p1(3)])
    
    scatter3(p_pos(i,1), p_pos(i,2), p_pos(i,3));
    
    config = struct('JointName',{'panda_joint1','panda_joint2','panda_joint3','panda_joint4','panda_joint5','panda_joint6','panda_joint7','panda_finger_joint1','panda_finger_joint2'},...
        'JointPosition',{out.q(i,1),out.q(i,2),out.q(i,3),out.q(i,4),out.q(i,5),out.q(i,6),out.q(i,7),out.q(i,8),out.q(i,9)});
    show(robot, config);
    
    if out.remaining_time(i) == 0
        title('Remaining time [s]:', '-')
    elseif out.remaining_time(i) > 100
        title('Remaining time [s]:', '???')
    else
        title('Remaining time [s]:', out.remaining_time(i))
    end
    delete(findall(gcf,'type','annotation'))
    annotation('textbox', [0, 0.96, 0, 0], 'string', 'Object-Velocity[m/s]:')
    annotation('textbox', [0, 0.93, 0, 0], 'string',  round(out.speed(i,:),5))
   % annotation('textbox', [0, 0.87, 0.115, 0], 'string', '')
    
     %% subplot 2 (error)
    cla(subplot(3,2,2));
    hold on
    grid on
    axis([0 length(out.states)*st -0.2 0.2]);
    plot(time(1:i), out.error(1:i, :))
    title('Error')
    
    %% subplot 3 (states)
    cla(subplot(3,2,4));
    hold on
    grid on
    axis([0 length(out.states)*st -0.1 1.1]);
    plot(time(1:i), out.states(1:i, :))
    legend("camera flag", 'control flag','grasp flag')
    title('States')
    
    %% subplot 4
    cla(subplot(3,2,6));
    hold on
    grid on
    scatter(ref1(1),ref1(2),'red','x');
    scatter(ref2(1),ref2(2),'red','x');
    scatter(ref3(1),ref3(2),'red','x');
    scatter(ref4(1),ref4(2),'red','x');
    scatter(out.proj(i,1), out.proj(i,2))
    scatter(out.proj(i,3), out.proj(i,4))
    scatter(out.proj(i,5), out.proj(i,6))
    scatter(out.proj(i,7), out.proj(i,8))
    rectangle('Position',[-plane_x -plane_y 2*plane_x 2*plane_y])
    axis([(-plane_x-0.002) (plane_x+0.002) (-plane_y-0.02) (plane_y+0.02)])
    axis equal
    title('Image Plane');
    

    pause(0.0001);
end

%take_photo(out.proj1)
%take_photo(out.proj2)


