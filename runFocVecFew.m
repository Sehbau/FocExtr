%
% Runs several focus extractions using wrapper function RennFocxv1.
% It plots descriptors for one focus (just for verification again)
% 
% PREVIOUS  runDsc1.m
% PRESENT   runFocVecFew.m, sa runFocxv1.m
% NEXT      runMvec1.m
%
clear;
run('../UtilMb/globalsSB');
cd( PthProg.focExtr );                     
%strVec    = 'img1';
strVec    = 'img2';
%strVec    = 'aachen';

% Prepare a few focii regions:
%             top bot lef rit
ABbox      = zeros(4,4);            % allocate
ABbox(1,:) = [100 400 100 300];     % mitte etwas
ABbox(2,:) = [0 300 0 200];         % links oben
ABbox(3,:) = [300 500-1 200 325];   % rechts unten
ABbox(4,:) = [0 500 200 325];       % rechts 

pthDsc     = ['Desc/' strVec '.vec'];

Admin      = u_CmndAdmin();

%% ========   LOOP   =======
nFoc    = size(ABbox,1);
Nlev    = size(nFoc,1);
Ndsc    = size(nFoc,1);
for f = 1:4

    pthOut  = ['Focii/' strVec '_f' num2str(f)]; 

    pthOut  = u_PathToBackSlash( pthOut, bOSISWIN);

    Sz      = RennFocxv1( pthDsc, ABbox(f,:), pthOut, Admin );
    Nlev(f) = Sz.nLev;
    Ndsc(f) = Sz.ntDsc;
    
end

%% -------   Load One Bbox -------
% requires: addpath('UtilMb/');
[AIMG KtI]	= LoadDescVect(pthDsc);    
[AFOC KtF]  = LoadFocVect(['Focii/' strVec '_f1.vef']);    

%% --------   Prepare bounding box  -------
BxNorm      = p_BboxConvers(ABbox(1,:), KtI.szV, KtI.szH);

%% -----   Plot Contours  -----
% requires: addpath('../DescExtr/UtilMb/Plot/');
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

