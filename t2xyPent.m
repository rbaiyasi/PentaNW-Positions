function [ xyPos ] = t2xyPent( pStruct , ts )
%t2xyPent Summary of this function goes here
%   INPUT:  pStruct
%           t - vector of parametric variable values to use. Values should
%               be contained in [0,5).
%   OUTPUT: xyPos - matrix of [x;y] column vectors corresponding to the input
%               t values.
prd = 5; %period for pentagon
%% Formatting ts
ts(ts<0) = ts(ts<0) + prd;
ts(ts==prd) = 0;
t1 = ts(:);
t1seg = floor(t1); % Which segment the t lies on, starting with 0

t1 = t1 - t1seg; % Adjust t to lie between 0 and 1;

%% Main Loop
xyPos = zeros(2,numel(t1));

for k = 1:numel(t1)
    tmpt = t1(k);
    if tmpt <= pStruct.tau % straight segment
        xytemp = pStruct.r1n(tmpt);
        xyk = xytemp(:,t1seg(k) + 1);
    elseif tmpt > pStruct.tau % curved segment
        xytemp = pStruct.r2n(tmpt);
        xyk = xytemp(:,t1seg(k) + 1);
    end
    xyPos(:,k) = xyk;
end