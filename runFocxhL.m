%
% Runs program focxhL (histogram), collecting a set of histograms for the
% bounding boxes in file BboxFocii.txt in same directory. Loads histogram
% array as block.
%
% To be run from directory PROD/FocExtr/
% 
clear;
run('../UtilMb/globalsSB');
cd( PthProg.focExtr );
strVec    = 'img1';
%strVec    = 'aachen';

%% ---------   Boundbox   --------
bbxf        = 'BboxFocii.txt';

%% =========   Command   ========
pthDsc      = ['Desc/' strVec '.vec'];
pthOut      = ['FOCII'];    % output file name (win backslash!)

cmd         = ['focxhL ' pthDsc ' ' bbxf ' ' pthOut];
[Sts Out]   = dos(cmd);

%% -------   Load Hist File   -------
addpath('UtilMb/');
[HST Sz]    = LoadFocHistArr([pthOut '.hsfL']);    

%% --------   Plot Flat Univariate   ---------
figure(1); clf; [nr nc]=deal(2,1);
subplot(nr,nc,1);
imagesc(HST);
ylabel('nFocii');
xlabel('Bins');
