%
% Wrapper routine for program focxv1
%
% sa RennDscx.m
%
% IN    pthDsc  vector file path (must include extension '.vec')
%       Bbox    bounding box as array of numbers [top/bot/lef/rit]
%       pthOut  output file path
%       Admin   administration, u_CmndAdmin.m
%
% OUT   Sz      struct with nLev, ntDsc
%       Out     stdout
% 
function [Sz Out] = RennFocxv1( pthDsc, Bbox, pthOut, Admin )

% create bounding box as string
bboxStr   = sprintf('%d %d %d %d', Bbox(1), Bbox(2), Bbox(3), Bbox(4));

if nargin==3, 
    Admin.pthProg = ''; 
    Admin.optS    = '';
end

cmnd = [Admin.pthProg 'focxv1 ' pthDsc ' ' bboxStr ' ' pthOut ' ' Admin.optS ];

[status Out] = dos(cmnd);                   % excecute program

%% ------  Status  ------
if status>0
    Out
    warning('Command %s returns exit code > 0 (see Out above)', cmnd);
end

%% -----   Analyse StdOut  -----
ixLev    = strfind( Out, 'nLevFoc');
Sz.nLev  = str2num( Out(ixLev+8));
ixDsc    = strfind( Out, 'ntDsc');
Sz.ntDsc = sscanf(  Out(ixDsc+5:end), '%d', 1); %str2num(Out(ixDsc+6));

%% ------  Verify Proper Termination  -----
ixEOP = strfind(Out,'EndOfProgram');
if isempty(ixEOP)
    warning('Command %s not executed. See sz and Out below', cmnd);
    Sz
    Out
    fprintf('Paused');
    pause();
end



