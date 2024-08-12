%
% Runs program focxv1, loads vector file and plots descriptors from vector
% info (approximation).
% 
clear;
run('../UtilMb/globalsSB');
cd( PthProg.focExtr );
strVec    = 'img1';
%strVec    = 'aachen';

%% ---------   Boundbox   --------
%             top bot lef rit
%Bbox      = [100 400 100 300];  % mitte etwa
%Bbox      = [0 300 0 200];     % links oben
Bbox      = [300 500 200 350];  % rechts unten
%Bbox      = [0 500 200 350];  % rechts 

% turn bounding box and file number into string
bboxStr     = sprintf('%d %d %d %d', Bbox(1), Bbox(2), Bbox(3), Bbox(4));

%% =========   Command   ========
dscfV       = ['Desc/'  strVec '.vec'];
outf        = ['Focii/' strVec];        % output file name (win backslash!)

outf        = u_PathToBackSlash(outf); % slash to backslash for windows

cmd      	= ['focxv1 ' dscfV ' ' bboxStr ' ' outf];
[Sts Out]   = dos(cmd);

%% ---------   Load All Output Files   -------
% requires addpath('UtilMb/');

[AIMG KtI]	= LoadDescVect(dscfV);    % from repo DescExtr
[AFOC KtF]  = LoadFocVect( [outf '.vef'] );    

%% --------   Prepare Plotting  -------
% the plotting function 'rectangle' expects [x y width height]
% we convert using function pBboxConvers (in UtilMb)
BxNorm      = p_BboxConvers(Bbox, KtI.szV, KtI.szH);

% we deploy the Plot[Dsc]Pyr functions of the following directory
% addpath('../DescExtr/UtilMb/Plot/');

%% ------------------------------------------------------------
% We plot every descriptor type twice (for verification):
% - once the full set, the entire image
% - once the focus set, the selected subset

%% -----   Plot Contours  -----
PlotCntPyr(AIMG.ACNT, 3, 'Full', BxNorm);
PlotCntPyr(AFOC.ACNT, 4, 'Focus');

%% -----   Plot RadSig  -----
PlotRsgPyr(AIMG.ARSG, 3, 'Full', BxNorm);
PlotRsgPyr(AFOC.ARSG, 4, 'Focus');

%% -----   Plot Arc  -----
PlotArcPyr(AIMG.AARCfll, 5, 'Full', BxNorm);
PlotArcPyr(AFOC.AARCfll, 6, 'Focus');

%% -----   Plot Str  -----
PlotStrPyr(AIMG.ASTRfll, 7, 'Full', BxNorm);
PlotStrPyr(AFOC.ASTRfll, 8, 'Focus');

%% -----   Plot Shp  -----
PlotShpPyr(AIMG.ASHP, 9, 'Full', BxNorm);
PlotShpPyr(AFOC.ASHP, 10, 'Focus');

