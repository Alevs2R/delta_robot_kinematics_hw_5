clf();
clear();
graphics_toolkit("fltk")
h = figure;

L.base_radius = 370;
L.bicep_length = 300;
L.forearm_length = 800;
L.end_platform_radius = 80;

% end_position = [-200 400 -805];
end_position = [0 0 -505];

[active_q, passive_q] = Ik(end_position, L);

T = Fk(active_q, L);

jq = Jq(active_q, passive_q, L)

plot_robot(active_q, T, L);


filename = 'jacobian_moving.gif';
axis equal;
axis tight manual % this ensures that getframe() returns a consistent size
xlabel("X axis");
ylabel("Y axis");
zlabel("Z axis");
xlim([-800,800]);
ylim([-800,800]);
zlim([-600,400]);

view(-60,-15)

drawnow;
frame = getframe(h); 
im = frame2im(frame); 
[imind,cm] = rgb2ind(im); 
imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05); 

dT = zeros(3,40);
step_size = 10;
dT(:,1:20) = repmat([0.0;-step_size; 0.0], [1,20]);
dT(:,21:40) = repmat([0.0;step_size; 0.0], [1,20]);


for i = 1:length(dT)
    current_dT = dT(:,i);

    active_q = active_q + (jq * current_dT).';
    T = Fk(active_q, L);

    clf();
    axis equal;
    xlabel("X axis");
    ylabel("Y axis");
    zlabel("Z axis");
    xlim([-800,800]);
    ylim([-800,800]);
    zlim([-600,400]);
    view(-60,-15)
    plot_robot(active_q, T, L);

    % update jacobian
    [active_q, passive_q] = Ik(T, L);
    jq = Jq(active_q, passive_q, L);

    % Capture the plot as an image 
    drawnow;
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im); 

    % Write to the GIF File 
    imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.05); 
end

% jq * transpose(dT)

% active_q_2 = active_q + (jq * transpose(dT)).'
% T_2 = Fk(active_q_2, L);
% plot_robot(active_q_2, T_2, L);

