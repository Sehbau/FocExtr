%
% Runs program focxv1, loads vector file and plots descriptors from vector
% info (approximation).
% 
clear;
addpath('../DescExtr/UtilMb/Vect/'); % loading routines from repo DescExtr
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
dscfV       = ['Desc/' strVec '.vec'];
outf        = ['Focii\' strVec];        % output file name (win backslash!)

cmd      	= ['focxv1 ' dscfV ' ' bboxStr ' ' outf];
[Sts Out]   = dos(cmd);

%% ---------   Load All Output Files   -------
addpath('UtilMb/');

[AIMG KtI]	= LoadDescVect(dscfV);    % from repo DescExtr
[AFOC KtF]  = LoadFocVect([outf '.vef']);    

%% --------   Prepare Plotting  -------
% the plotting function 'rectangle' expects [x y width height]
% we convert using function pBboxConvers (in UtilMb)
BxNorm      = p_BboxConvers(Bbox, KtI.szV, KtI.szH);

% we deploy the Plot[Dsc]Pyr functions of the following directory
addpath('../DescExtr/UtilMb/Plot/');

%% ------------------------------------------------------------
% We plot every descriptor type twice:
% - once the full set, the entire image
% - once the focus set, the selected subset
%% -----   Plot Contours  -----
PlotCntPyr(AFOC.ACNT, 1, 'Focus');
PlotCntPyr(AIMG.ACNT, 2, 'Full', BxNorm);

%% -----   Plot RadSig  -----
PlotRsgPyr(AFOC.ARSG, 3, 'Focus');
PlotRsgPyr(AIMG.ARSG, 4, 'Full', BxNorm);

%% -----   Plot Arc  -----
PlotArcPyr(AFOC.AARCfll, 5, 'Focus');
PlotArcPyr(AIMG.AARCfll, 6, 'Full', BxNorm);

%% -----   Plot Str  -----
PlotStrPyr(AFOC.ASTRfll, 7, 'Focus');
PlotStrPyr(AIMG.ASTRfll, 8, 'Full', BxNorm);

