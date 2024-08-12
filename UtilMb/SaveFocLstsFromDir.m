%
% Saves lists of focus filenames for a range of levels.
%
% cf o_FocDir1.m (lvngRunMovo.m)
%
function [] = SaveFocLstsFromDir( AFinaLev, pth, aLipas )

ntLev  = length( AFinaLev );

for l = 1:ntLev
    
    SaveFipaLstFromDir( AFinaLev{l}, pth, aLipas{l} );
end

    
end

