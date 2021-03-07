function R = Rx(q)
    R = eye(4);
    R(2,2) = cos(q); R(2,3) = -sin(q);
    R(3,2) = sin(q); R(3,3) = cos(q);
end
    