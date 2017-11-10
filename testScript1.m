%% Derivation: Rashad Baiyasi lab notebook 02/01/16-__/__/__: pgs 143-145
clearvars
%% Relavant parameters
d = 10; %nm
NWdiam = 430; %nm
rot = @(ttheta) [cos(ttheta),-sin(ttheta);sin(ttheta),cos(ttheta)];
phi_int = pi*108/180; % pentagon interior angle

%% Vertices of pentagon
% unit pentagon
phi_v = pi/180*(18+(0:72:360));
phi_v = phi_v(1:end-1); % last element was repeated
phi_v = circshift(phi_v,1); % shift starting point to bottom
% phi_v(end+1) = phi_v(1);

Vu = [cos(phi_v);sin(phi_v)]; % [x;y] column vectors

Vn = NWdiam/2*Vu; % final NW vertices

%% Outside path constants calculation
un = -Vn + circshift(Vn,[0,-1]);
s = mean(abs(un(1,:) + 1i*un(2,:))); % side length of pentagon
un_hat = un / s;
tau = (d/s*(pi-phi_int)+1)^(-1);

%% Starting point for each segment
r0n = d*rot(-pi/2)*un_hat+Vn;

% these functions only accept one t at a time
r1n = @(t) r0n + t*s/tau*un_hat;
thetar = @(t) (t-tau)*(pi-phi_int)/(1-tau);
r2n = @(t)rot(thetar(t))*(r1n(tau)-circshift(Vn,[0,-1]))+circshift(Vn,[0,-1]);


%% Calculate parametric positions
dt = 1e-5; % time step
t1 = 0:dt:tau;
t2 = (tau+dt):dt:1;
T1 = numel(t1);
coordcube = zeros(2,5,T1+numel(t2));
for k = 1:numel(t1)
    coordcube(:,:,k) = r1n(t1(k));
end
for k = 1:numel(t2)
    coordcube(:,:,k+T1) = r2n(t2(k));
end

coordcube = permute(coordcube,[3,2,1]);
[nT,nP,nD] = size(coordcube);
coords = reshape(coordcube,nT*nP,nD);
% coords = squeeze(coordcube(:,1,:));
rtaun = r1n(tau);
%% Plotting for visual
% figure(1); 
% plot(Vn(1,:),Vn(2,:)); axis image
% hold on
% scatter(coords(:,1),coords(:,2),'.r')
% scatter(r0n(1,:),r0n(2,:),'ok')
% scatter(rtaun(1,:),rtaun(2,:),'+k')
% hold off

%% Generating random points
% Parameters for simulation
numframes = 2000;
avgptsperframe = 4.25;
nwlength = 12e3; %nm
% numpts = 5e3;
numpts = numframes*avgptsperframe;
framenums = ceil(rand(numpts,1) * numframes);
[framenums,framesort] = sort(framenums);
troika_precision = 30;
px_size = 48;
%Calc coords


randts = rand(numpts,1)*5/dt;
randts = ceil(randts);
randpts = coords(randts,:);
randpts(:,3) = rand(numpts,1)*nwlength;
randptswithnoise = randpts + randn(size(randpts))*troika_precision;

% form trjR
trjR = zeros(numframes,3,numpts);
for k = 1:numpts
    trjR(framenums(k),:,k) = [randptswithnoise(k,[1,3])/px_size,1.5];
end
figure(2)
histogram(randptswithnoise(:,1));

save(['simNoSplit_pDens',num2str(avgptsperframe),'_NW',num2str(NWdiam)],'trjR','NWdiam','randptswithnoise')