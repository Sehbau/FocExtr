%
% Runs several focus extractions using wrapper function RennFocxv1.
% It plots descriptors for one focus (just for verification again)
% 
clear;
addpath('../DescExtr/UtilMb/Vect/'); % loading routines from repo DescExtr

strVec    = 'img1';
%strVec    = 'aachen';

% Prepare a few focii regions:
%             top bot lef rit
ABbox      = zeros(4,4);            % allocate
ABbox(1,:) = [100 400 100 300];     % mitte etwas
ABbox(2,:) = [0 300 0 200];         % links oben
ABbox(3,:) = [300 500 200 350];     % rechts unten
ABbox(4,:) = [0 500 200 350];       % rechts 

dscf      = ['Desc/' strVec '.vec'];

%% ========   LOOP   =======
nFoc    = size(ABbox,1);
Nlev    = size(nFoc,1);
Ndsc    = size(nFoc,1);
for f = 1:4

    outf  = ['Focii\' strVec '_f' num2str(f)];  % win backslash!
    
    Sz      = RennFocxv1(dscf, ABbox(f,:), outf);
    Nlev(f) = Sz.nLev;
    Ndsc(f) = Sz.ntDsc;
    
end

%% -------   Load One Bbox -------
addpath('UtilMb/');

[AIMG KtI]	= LoadDescVect(dscf);    
[AFOC KtF]  = LoadFocVect(['Focii\' strVec '_f1.vef']);    

%% --------   Prepare bounding box  -------
BxNorm      = p_BboxConvers(ABbox(1,:), KtI.szV, KtI.szH);

%% -----   Plot Contours  -----
addpath('../DescExtr/UtilMb/Plot/');

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

