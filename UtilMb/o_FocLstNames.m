% 
% Generates list names for focus files for a range of levels.
%
% cf u_FocOrgColl (lvngRunMovo.m)
% sa u_DirFocNamLev
%
function aLipa = o_FocLstNames( pth, name, ntLev )

    aLipa = cell( ntLev, 1 );

    for l = 1:ntLev

        aLipa{l} = [ pth 'FL_' name '_Lev' num2str(l) '.txt' ];

    end

end


        
