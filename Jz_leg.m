function [ Result ] = Jz_leg(q1,q2,q3,a)

Result = [
    cos(a)*cos(q1+q2)*cos(q3) + sin(a)*sin(q3), -sin(a)*cos(q1+q2)*cos(q3) + cos(a)*sin(q3), -sin(q1+q2)*cos(q3)
];

