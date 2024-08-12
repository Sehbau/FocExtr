%
% Runs program focxh1, extracting one histogram with bounding box specified
% as arguments.
%
% To be run from PROD/FocExtr/
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
pthDsc      = ['Desc/' strVec '.vec'];
pthOut      = ['Focii/' strVec];        % output file name (win backslash!)

pthOut        = u_PathToBackSlash(pthOut); % slash to backslash for windows

cmd      	= ['focxh1 ' pthDsc ' ' bboxStr ' ' pthOut];
[Sts Out]	= dos(cmd);

%% ---------   Load Hist File   -------
% requires:
% addpath('UtilMb/');
% addpath('../DescExtr/UtilMb/Hist/'); % loading routines from repo DescExtr

[HFU HFB Nunf Nbif Floc]  = LoadFocHist([pthOut '.hsf1']);    
[H1 len]    = u_HistCatFlat(HFU, HFB, Nunf, Nbif, Floc);

%% --------   Plot Flat Univariate   ---------
% copied from exampleLoadHist.m (DescExtr)
figure(1); [nr nc]=deal(4,1);
subplot(nr,nc,1);
bar(HFU.Skl); ylabel('Skl');

subplot(nr,nc,2);
bar(HFU.Rsg); ylabel('RadSig');

subplot(nr,nc,3);
bar(HFU.Arc); ylabel('Arc');

subplot(nr,nc,4);
bar(HFU.Str); ylabel('Str');

%subplot(nr,nc,1);
%bar(HFU.Rdg); ylabel('Ridge');

%subplot(nr,nc,2);
%bar(HFU.Riv); ylabel('River');

%subplot(nr,nc,3);
%bar(HFU.Edg); ylabel('Edge');


%% --------   Plot Flat Bivariate   ---------
figure(2); [nr nc]=deal(4,1);
subplot(nr,nc,1);
bar(HFB.Skl); ylabel('Skl');

subplot(nr,nc,2);
bar(HFB.Rsg); ylabel('RadSig');

subplot(nr,nc,3);
bar(HFB.Arc); ylabel('Arc');

subplot(nr,nc,4);
bar(HFB.Str); ylabel('Str');

%subplot(nr,nc,1);
%bar(HFB.Rdg); ylabel('Ridge');

%subplot(nr,nc,2);
%bar(HFB.Riv); ylabel('River');

%subplot(nr,nc,3);
%bar(HFB.Edg); ylabel('Edge');

