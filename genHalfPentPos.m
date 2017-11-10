function [ xyPos , paramval ] = genHalfPentPos( nw_diam , link_thick , side_res )
%genHalfPentPos Generates positions along half of nanowire.
%   INPUT:  nw_diam
%           link_thick
%           side_res - number of segments between the corner of nanowire
%               and center of nanowire side.

pStruct = genPentStruct(nw_diam,link_thick);

t0 = (1-pStruct.tau)/2; % parametric variable at apex of nanowire

ts0 = linspace(-t0,1-t0,2*side_res + 1); % right side
ts = [ts0,ts0(2:end)+1]; % right top
ts = [ts0(ceil(numel(ts0)/2):end-1)-1,ts];
xyPos = t2xyPent(pStruct,ts);
xytmp = t2xyPent(pStruct,0:0.01:5);
% figure(1)
% plot(xytmp(1,:),xytmp(2,:))
% hold on
% scatter(xyPos(1,:),xyPos(2,:))
% hold off
% axis image

% Output starting at the apex with paramvalue of zero
xyPos = fliplr(xyPos);
paramval = abs(fliplr(ts) - max(ts));