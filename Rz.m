function R = Rz(q)
    R = eye(4);
    R(1,1) = cos(q); R(1,2) = -sin(q);
    R(2,1) = sin(q); R(2,2) = cos(q);
end
    