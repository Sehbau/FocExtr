%
% Wrapper routine for program focxh1 (one histogram only)
%
% Same as RennFocxv1 but different program name.
% 
function [Sz Out] = RennFocxh1(dscf, Bbox, outf, Opts, pthFocx)

bboxStr   = sprintf('%d %d %d %d', Bbox(1), Bbox(2), Bbox(3), Bbox(4));

pthProg = '';
if nargin==3, Opts=''; end
if nargin==5, pthProg = pthFocx; end

%dscf(end) = 'b';                        % .vef -> .veb

cmd  	= [pthProg 'focxh1 ' dscf ' ' bboxStr ' ' outf ' ' Opts];

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



