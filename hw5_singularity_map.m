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

x = -700:100:700;
y = -700:100:700;
z = -1000:100:0;

sol_count = 0;

X = zeros(1000);
Y = zeros(1000);
Z = zeros(1000);

smap = zeros(1000);

for ix = x
    for iy = y
        for iz = z
            try                
                [active_q, passive_q, success] = Ik([ix iy iz], L);

                if (success & not(any(isnan(active_q))))
                    sol_count = sol_count + 1;
                    jq = Jq(active_q, passive_q, L);
                    m = sqrt(det(jq*transpose(jq)))
                    smap(sol_count) = m;
                    X(sol_count) = ix;
                    Y(sol_count) = iy;
                    Z(sol_count) = iz;
                end
            catch
                % disp("unreachable point");
            end_try_catch
        end
    end
end

max_m =max(smap(1:sol_count))
min_m = min(smap(1:sol_count))

scatter3(X(1:sol_count),Y(1:sol_count),Z(1:sol_count),[],smap(1:sol_count),'filled');

xlabel("X axis");
ylabel("Y axis");
zlabel("Z axis");
caxis([min_m, max_m/100])
colorbar

view(60,-30)
rotate3d on

saveas(gcf,'singularity_map.png')

