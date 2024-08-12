%
% Extracts a list of focii with wrapper routine RennFocxv1.m
%
% IN    pthDsc  vector file path (must include extension '.vec')
%       ABbox   array of bounding boxes [nBbx x top/bot/lef/rit]
%       pthFoc  output path for focii
%       imgNa   image name 
%
% OUT   Num     sizes of focii
% 
function Num = RennFocxvLstMb( pthDsc, ABbox, pthFoc, imgNa, Admin )

NLEVS       = 10;

[nBbx nPrm] = size(ABbox);
Num.Lev     = zeros(nBbx,1,'uint8');
Num.Dsc     = zeros(nBbx,1,'int32');
KntLev      = zeros(1,NLEVS,'int16');
for f = 1:nBbx
    
    Bbox  = ABbox(f,:);
    
    if Admin.bRename
        pthOut  = [pthFoc 'temp']; % use only a temporary file
    else
        pthOut  = [pthFoc imgNa '_f' num2str(f)]; 
    end

    pthOut      = u_PathToBackSlash(pthOut, Admin.bOSisWin);
    
    [Sz OutFocx]  = RennFocxv1( pthDsc, Bbox, pthOut, Admin );
    
    Num.Lev(f) = Sz.nLev;
    Num.Dsc(f) = Sz.ntDsc;    

    if Sz.nLev < 1 
        fprintf('Skipped nLev=%d \t\t', Sz.nLev);
        Bbox
        continue;
    end
    
    if ~exist( [pthOut '.vef'], 'file' )
        assert( Sz.ntDsc==0, 'another case?' );
        fprintf('No descriptors - no renaming. skipping.\n');
        continue; 
    end

    if Admin.bRename

        cLev    = KntLev( Sz.nLev );
        pthOld  = [pthOut '.vef'];

        % renaming file:
        % - 'rename' does not need a path, as it is a dos command
        % - 'rename' takes only a new filename WITHOUT path
        %pthNew  = [pthFoc imgNa '_Lev' num2str(Sz.nLev) '_f' num2str(cLev)];
        nameNew = [imgNa '_Lev' num2str(Sz.nLev) '_f' num2str(cLev) '.vef'];

        cmdRen  = [ 'ren ' pthOld ' ' nameNew ];
        %cmdRen  = u_PathToBackSlash( cmdRen );

        [status OutRen] = dos( cmdRen );
        if status>0 % >1 before jun/17 !?
            status 
            OutRen
            OutFocx
            error('renaming unsuccesful: %s (perhaps kill files)', cmdRen );
        end
        % Sz.nLev
        % cLev
        KntLev( Sz.nLev ) = cLev + 1;
    end
end

Num.LevKnt = KntLev;

end % MAIN