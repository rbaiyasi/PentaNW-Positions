numsteps0 = 7; %one less than number of points in that quarter-circle
N1 = numsteps0;
N2 = round(N1*sin(pi/4));

row1 = linspace(0,pi/2,N1+1)';
row1(:,2) = pi/2;

row2 = linspace(0,pi/2,N2+1)';
row2(:,2) = pi/4;

row3 = [0,0];

phitheta = cat(1,row1,row2,row3);