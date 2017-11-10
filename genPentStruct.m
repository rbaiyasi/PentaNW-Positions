function [ pStruct ] = genPentStruct( nw_diam , link_thick )
%genPentStruct Generates a structure used for genPentLUT
% Derivation: Rashad Baiyasi lab notebook 02/01/16-__/__/__: pgs 143-145
%   INPUT:  nw_diam - Nanowire diameter (nm).
%           link_thick - Spacing between dyes and nanowire surface (nm).
%   OUTPUT: pStruct - structure containing the relevant information to
%               generate a lookup-table.

%% Vertices of pentagon
% Vu: Vertex locations for a unit pentagon centered on the origin
% Vn: Vertex locations for scaled pentagon
rot = @(ttheta) [cos(ttheta),-sin(ttheta);sin(ttheta),cos(ttheta)];
phi_int = pi*108/180; % pentagon interior angle
phi_v = pi/180*(18+(0:72:360));
phi_v = phi_v(1:end-1); % last element was repeated
phi_v = circshift(phi_v,1); % shift starting point to bottom
Vu = [cos(phi_v);sin(phi_v)]; % [x;y] column vectors
% final NW vertices
Vn = nw_diam/2*Vu; 

%% Constants describing outer path
% un: vector pointing along pentagon edge
% s: side length of pentagon
% un_hat: unit vector pointing along pentagon side
% tau: length of parametric variable t represented by the curved portion of
%   the path. Straight portion runs from [0,tau), curved from [tau,1).
un = -Vn + circshift(Vn,[0,-1]);
s = mean(abs(un(1,:) + 1i*un(2,:))); % side length of pentagon
un_hat = un / s;
tau = (link_thick/s*(pi-phi_int)+1)^(-1);

%% Functions for straight (r1n) and curved (r2n) segment
% r0n: starting point for each segment
r0n = link_thick*rot(-pi/2)*un_hat+Vn;
r1n = @(t) r0n + t*s/tau*un_hat;
r1tau = r1n(tau);
thetar = @(t) (t-tau)*(pi-phi_int)/(1-tau);
r2n = @(t)rot(thetar(t))*(r1tau-circshift(Vn,[0,-1]))+circshift(Vn,[0,-1]);

pStruct.r0n = r0n;
pStruct.tau = tau;
pStruct.r1n = r1n;
pStruct.thetar = thetar;
pStruct.r2n = r2n;
pStruct.Vn = [Vn,Vn(:,1)];