%
% Deletes contents of level directories 'Lev1', 'Lev2', ... 'Levn' for focii.
% 
% cf dirsForLevels.m
%
function [] = u_DirsLevelsDel(pth, nLev, bOSisWin)

    for l = 1:nLev
        
        files = [pth '/Lev' num2str(l), '/*.*'];
        files = u_PathToBackSlash( files, bOSisWin );

        dos(['del ' files]);

    end

end

