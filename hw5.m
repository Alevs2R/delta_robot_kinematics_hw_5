clf();
clear();
axis equal;
figure(1);
hold on;
format long g
graphics_toolkit("gnuplot")

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

dT = [0 200 0];

jq * transpose(dT)

active_q_2 = active_q + (jq * transpose(dT)).'
T_2 = Fk(active_q_2, L);
plot_robot(active_q_2, T_2, L);



xlabel("X axis");
ylabel("Y axis");
zlabel("Z axis");
view(60,-30)
rotate3d on

% iterations = 10;

% q_list = zeros(10,7)

% for i = 1:iterations
%     delta_r = [-1.0/iterations 0.0 0.0]';
%     q = Ik_nullspace(delta_r, q, l, Tbase);
%     plot_robot(Tbase, q, l);
%     q_list(i,:) = q
% end

% xlabel("X axis");
% ylabel("Y axis");
% zlabel("Z axis");
% view(-30,30)
% rotate3d on
% graphics_toolkit("gnuplot");
% saveas(gcf,"inverse_nullspace.png")
