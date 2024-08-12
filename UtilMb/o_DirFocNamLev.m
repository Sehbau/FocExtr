% 
% Obtains filenames for focii for ONE structure (scene,object) 
%
% cf o_FocDir1 (lvngRunMovo.m)
%
% Focii were generated with:
%
%   [imgNa '_Lev' num2str(Sz.nLev) '_f' num2str(cLev) '.vef'];
%
function AFina = o_DirFocNamLev( fipa, Levs )

    nLev  = length(Levs);

    AFina = cell( nLev, 1 );

    for l = 1:nLev

        lev      = Levs(l);
        AFina{l} = dir( [fipa '_Lev' num2str(lev) '_f*.vef' ] );

    end

end


        
