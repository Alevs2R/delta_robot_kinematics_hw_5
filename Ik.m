function [ active_q, passive_q, success ] = Ik(T, L)

x0 = T(1);
y0 = T(2);
z0 = T(3);

sin120 = sin(2*pi/3);
cos120 = cos(2*pi/3);

[active_q_1, passive_q_1, success1] = Ik_leg(T, L);
[active_q_2, passive_q_2, success2]  = Ik_leg([x0 * cos120 + y0 * sin120, y0 * cos120 - x0 * sin120, z0], L);
[active_q_3, passive_q_3, success3]  = Ik_leg([x0 * cos120 - y0 * sin120, y0 * cos120 + x0 * sin120, z0], L);

active_q = [active_q_1, active_q_2, active_q_3];
passive_q = [passive_q_1, passive_q_2, passive_q_3];

success = success1 & success2 & success3;

end