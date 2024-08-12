%
% Runs several focus extractions using wrapper function RennFocxh1.
% 
% PREVIOUS  runDsc1.m
% PRESENT   runFocVecFew.m, sa runFocxv1.m
% NEXT      runMvec1.m
%
clear;
run('../UtilMb/globalsSB');
cd( PthProg.focExtr );                     
strVec    = 'img1';
%strVec    = 'img2';

% Prepare a few focii regions:
%             top bot lef rit
ABbox      = zeros(4,4);            % allocate
ABbox(1,:) = [10 40  10 40];  
ABbox(2,:) = [10 80  10 80];  
ABbox(3,:) = [10 120 10 120]; 
ABbox(4,:) = [10 150 10 150]; 

pthDsc     = ['Desc/' strVec '.vec'];

Admin      = u_CmndAdmin();

%% ========   LOOP   =======
nFoc    = size(ABbox,1);
Nlev    = size(nFoc,1);
Ndsc    = size(nFoc,1);
for f = 1:4

    pthOut  = ['Focii/' strVec '_f' num2str(f)]; 

    pthOut  = u_PathToBackSlash( pthOut, bOSISWIN);

    Sz      = RennFocxh1( pthDsc, ABbox(f,:), pthOut, Admin.optS );
    Nlev(f) = Sz.nLev;
    Ndsc(f) = Sz.ntDsc;
    
end



