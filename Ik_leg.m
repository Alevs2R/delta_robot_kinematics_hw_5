 function [ active_q, passive_q ] = Ik_leg(T, L)  
    y1 = -L.base_radius; % координата для начала плеча
    y0 = T(2) - L.end_platform_radius; % координата крепления мобильной платформы

    % находим точку пересечения двух окружностей
    % получаем 2 уравнения окружности, решаем квадратное уравнение
    % в итоге получаем формулы
    x0 = T(1);
    z0 = T(3);
    rf = L.bicep_length;
    re = L.forearm_length;

    a = (x0*x0 + y0*y0 + z0*z0 +rf*rf - re*re - y1*y1)/(2*z0);
    b = (y1-y0)/z0;

    % находим дискриминант квадратного уравнения
    d = -(a+b*y1)*(a+b*y1)+rf*(b*b*rf+rf);
    if (d < 0) 
        theta = 0;
        return; % несуществующая точка
    end

    yj = (y1 - a*b - sqrt(d))/(b*b + 1); % выбираем внешнюю точку
    zj = a + b*yj;

    if yj > y1
        theta1 = atan(-zj / (y1 - yj)) + pi;
    else
        theta1 = atan(-zj / (y1 - yj));
    end

    % get passive joint angles

    % x_shift = L.base_radius - L.end_platform_radius;
    theta3 = asin(x0/re);

    y_local = y1 - y0; 
    theta2 = acos((y_local - rf*cos(theta1)) / (re * cos(theta3))) - theta1;

    active_q = theta1;   
    passive_q = [theta2; theta3]; 

end