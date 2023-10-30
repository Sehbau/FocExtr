%
% Creates level directorys 'Lev1', 'Lev2', ... 'Levn' for focii.
%
% PREVIOUS  -
% PRESENT   dirsForLevels.m
% NEXT      
%
clear; 
%addpath('UtilMb');

bas = 52;   mxLev = 5;
%bas = 37; % vo7
%bas = 200; % cityscapes

%% -----------------   Init Collection/DataBase   ---------------
% gs_globals; gs_NamesDesc;
if bas==52
    
    nyuGlobals;       % klab/ppc/PPlcRec/NYU2/ datBasePrepIndoorNYU2.m
    
    u_DirsLevels(PATH.DANNvef, mxLev);
    
    % u_DirsLevelsDel(PATH.DANNvef, mxLev);
    
elseif bas==200

elseif bas==37

else error('not implemented');
end

