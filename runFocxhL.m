%
% Runs program focxh (histogram), collecting a set of histograms for the
% bounding boxes in file BboxFocii.txt in same directory. Loads histogram
% array as block.
%
% To be run from directory PROD/FocExtr/
% 
clear;
strVec    = 'img1';
%strVec    = 'aachen';

%% ---------   Boundbox   --------
bbxf        = 'BboxFocii.txt';

%% =========   Command   ========
dscfV       = ['Desc/' strVec '.vec'];
outf        = ['FOCII'];    % output file name (win backslash!)

cmd         = ['focxhL ' dscfV ' ' bbxf ' ' outf];
[Sts Out]   = dos(cmd);

%% -------   Load Hist File   -------
addpath('UtilMb/');
[HST Sz]    = LoadFocHistArr([outf '.hsfL']);    

%% --------   Plot Flat Univariate   ---------
figure(1); clf; [nr nc]=deal(2,1);
subplot(nr,nc,1);
imagesc(HST);
ylabel('nFocii');
xlabel('Bins');
