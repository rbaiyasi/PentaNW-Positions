%% using variable phitheta, rotate it so they work around the y-axis
% reassign over the values of phitheta
N = size(phitheta,1);
ogphitheta = phitheta;
as = zeros(N,3);
for k = 1:N
    phi = phitheta(k,1);
    theta = phitheta(k,2);
    as(k,:) = [sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta)];
    bx = as(k,1);
    by = -as(k,3);
    bz = as(k,2);
    phitheta(k,1) = atan(by/bx);
    phitheta(k,2) = atan(sqrt(bx^2 + by^2)/bz);
end