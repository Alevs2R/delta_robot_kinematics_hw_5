function [ T ] = Fk(q, L)

    theta1 = q(1);
    theta2 = q(2);
    theta3 = q(3);

    rf = L.bicep_length;
    re = L.forearm_length;

    % сдвигаем сферы на end_platform_radius, чтобы точка пересечения была в одном месте

    t = L.base_radius - L.end_platform_radius;

    tan60 = sqrt(3.0);
    sin30 = 0.5;

    y1 = -(t + rf*cos(theta1));
    z1 = -rf*sin(theta1);

    y2 = (t + rf*cos(theta2))*sin30;
    x2 = y2*tan60;
    z2 = -rf*sin(theta2);

    y3 = (t + rf*cos(theta3))*sin30;
    x3 = -y3*tan60;
    z3 = -rf*sin(theta3);

    % находим точку пересечения 3 сфер

    dnm = (y2 - y1) * x3 - (y3 - y1) * x2;

    w1 = y1 * y1 + z1 * z1;
    w2 = x2 * x2 + y2 * y2 + z2 * z2;
    w3 = x3 * x3 + y3 * y3 + z3 * z3;

    a1 = (z2 - z1) * (y3 - y1) - (z3 - z1) * (y2 - y1);
    b1 = -((w2 - w1) * (y3 - y1) - (w3 - w1) * (y2 - y1)) / 2;

    a2 = -(z2 - z1) * x3 + (z3 - z1) * x2;
    b2 = ((w2 - w1) * x3 - (w3 - w1) * x2) / 2;

    a = a1 * a1 + a2 * a2 + dnm * dnm;
    b = 2 * (a1 * b1 + a2 * (b2 - y1 * dnm) - z1 * dnm * dnm);
    c = (b2 - y1 * dnm) * (b2 - y1 * dnm) + b1 * b1 + dnm * dnm * (z1 * z1 - re * re);

    d = b * b - 4 * a * c;

    if (d < 0)
        T = [0 0 0];
        disp("error d<0");
        return;
    end

    z0 = -0.5 * (b + sqrt(d)) / a;
    x0 = (a1 * z0 + b1) / dnm;
    y0 = (a2 * z0 + b2) / dnm;

    T = [x0 y0 z0];

end