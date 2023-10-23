function p2 = apply_homography(p1, H)

    q1 = [p1(1); p1(2); 1];
    q2 = H * q1;
    p2 = [q2(1)/q2(3), q2(2)/q2(3)];

end