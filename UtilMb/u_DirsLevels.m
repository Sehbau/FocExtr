%
% Creates level directorys 'Lev1', 'Lev2', ... 'Levn' for focii.
%
% cf dirsForLevels.m
%
function [] = u_DirsLevels(pth, nLev)

    bPause = 0;
    
    for l = 1:nLev
        f_MkDir([pth '/Lev' num2str(l)],  bPause);    
        f_MkDir([pth '/DM' num2str(l)],  bPause);    
    end

end

