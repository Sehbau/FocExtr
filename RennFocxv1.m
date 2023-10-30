%
% Wrapper routine for program focxv1
%
% IN    dscf    vector file name + path (must include extension '.vec')
%       Bbox    bounding box as array of numbers [top/bot/lef/rit]
%       outf    output file name + path
%       Opts    options
%       pthFocx path of program 'focx'
%
% OUT   Sz      struct with nLev, ntDsc
%       Out     stdout
% 
function [Sz Out] = RennFocx(dscf, Bbox, outf, Opts, pthFocx)

bboxStr   = sprintf('%d %d %d %d', Bbox(1), Bbox(2), Bbox(3), Bbox(4));

pthProg = '';
if nargin==3, Opts=''; end
if nargin==5, pthProg = pthFocx; end

cmd  	= [pthProg 'focxv1 ' dscf ' ' bboxStr ' ' outf ' ' Opts];

[Sts Out] = dos(cmd);                   % excecute program

%% -----   Analyse StdOut  -----
ixLev    = strfind(Out, 'nLevFoc');
Sz.nLev  = str2num(Out(ixLev+8));
ixDsc    = strfind(Out, 'ntDsc');
Sz.ntDsc = sscanf(Out(ixDsc+5:end), '%d', 1); %str2num(Out(ixDsc+6));

%% ------  Verify Proper Termination  -----
ixEOP = strfind(Out,'EndOfProgram');
if isempty(ixEOP)
    Sz
    Out
    fprintf('Paused');
    pause();
end



