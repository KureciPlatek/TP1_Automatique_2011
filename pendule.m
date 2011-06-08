function [sys,x0] = pendule(t,x,u,flag)

    g = 9.81;
    l = 0.5;
    m = 0.1
    M = 2;

    if flag == 0
        sys = [4 0 4 1 0 1];
        x0 = [2 5*pi/180 0 0];

    end

    if flag == 1
        sys = [x(3),x(4)];
    end

    if flag == 3
        sys = [x(1);x(2);x(3);x(4)];
    end

end