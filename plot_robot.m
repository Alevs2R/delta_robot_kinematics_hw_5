function [] = plot_robot(q, T, L)

    theta1 = q(1);
    theta2 = q(2);
    theta3 = q(3);

    rf = L.bicep_length;
    re = L.forearm_length;

    tan60 = sqrt(3.0);
    sin30 = 0.5;

    % рисуем базу

    Tbase = eye(4);

    T11 = Tbase * Ty(-L.base_radius);
    T12 = Tbase * Rz(2*pi/3) * Ty(-L.base_radius);
    T13 = Tbase * Rz(-2*pi/3) * Ty(-L.base_radius);

    line([T11(1,4) T12(1,4) T13(1,4) T11(1,4)], [T11(2,4) T12(2,4) T13(2,4) T11(2,4)], [T11(3,4) T12(3,4) T13(3,4) T11(3,4)]);
    
    set(0, 'DefaultLineLineWidth', 2);


    % рисуем 1 линк

    T21 = T11 * Rx(theta1) * Ty(-rf);
    T22 = T12 * Rx(theta2) * Ty(-rf);
    T23 = T13 * Rx(theta3) * Ty(-rf);

    line([T11(1,4) T21(1,4)], [T11(2,4) T21(2,4)], [T11(3,4) T21(3,4)]);
    line([T12(1,4) T22(1,4)], [T12(2,4) T22(2,4)], [T12(3,4) T22(3,4)]);
    line([T13(1,4) T23(1,4)], [T13(2,4) T23(2,4)], [T13(3,4) T23(3,4)]);

    % рисуем мобильную платформу

    Tplatform = eye(4);
    Tplatform(1:3,4) = T;

    T41 = Tplatform * Ty(-L.end_platform_radius);
    T42 = Tplatform * Rz(2*pi/3) * Ty(-L.end_platform_radius);
    T43 = Tplatform * Rz(-2*pi/3) * Ty(-L.end_platform_radius);

    line([T41(1,4) T42(1,4) T43(1,4) T41(1,4)], [T41(2,4) T42(2,4) T43(2,4) T41(2,4)], [T41(3,4) T42(3,4) T43(3,4) T41(3,4)]);

    % рисуем 2 линк

    % T31 = T21 * Rx(q_passive(1,1)) * Rz(q_passive(2,1)) * Ty(-re);
    % T32 = T22 * Rx(q_passive(1,2)) * Rz(q_passive(2,2)) * Ty(-re);
    % T33 = T23 * Rx(q_passive(1,3)) * Rz(q_passive(2,3)) * Ty(-re);

    % line([T21(1,4) T31(1,4)], [T21(2,4) T31(2,4)], [T21(3,4) T31(3,4)]);
    % line([T22(1,4) T32(1,4)], [T22(2,4) T32(2,4)], [T22(3,4) T32(3,4)]);
    % line([T23(1,4) T33(1,4)], [T23(2,4) T33(2,4)], [T23(3,4) T33(3,4)]);

    line([T21(1,4) T41(1,4)], [T21(2,4) T41(2,4)], [T21(3,4) T41(3,4)]);
    line([T22(1,4) T42(1,4)], [T22(2,4) T42(2,4)], [T22(3,4) T42(3,4)]);
    line([T23(1,4) T43(1,4)], [T23(2,4) T43(2,4)], [T23(3,4) T43(3,4)]);
