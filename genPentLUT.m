function [ lookup ] = genPentLUT( pStruct , numpts )
%genPentLUT Creates lookup table using output of genPentStruct.
%   INPUT:  pStruct
%           numpts - number of points used to discretize the positions
%               around the nanowire.

%% Sorting the points into their piecewise positions.
ts = linspace(0,1,numpts+1);
ts = ts(1:end-1);