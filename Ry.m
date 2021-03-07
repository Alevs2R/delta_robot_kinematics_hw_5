function R = Ry(q)
    R = eye(4);
    R(1,1) = cos(q); R(1,3) = sin(q);
    R(3,1) = -sin(q); R(3,3) = cos(q);
end
    