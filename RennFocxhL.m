%
% Wrapper routine for program focxh, a set of histograms read with
% boundings boxes read from file.
%
% Same as RennFocxh1 but different program name.
% 
function [Sz Out] = RennFocxhL(dscf, Bbox, outf, Opts, pthFocx)

bboxStr   = sprintf('%d %d %d %d', Bbox(1), Bbox(2), Bbox(3), Bbox(4));

pthProg = '';
if nargin==3, Opts=''; end
if nargin==5, pthProg = pthFocx; end

%dscf(end) = 'b';                        % .vef -> .veb

cmnd  	= [pthProg 'focxhL ' dscf ' ' bboxStr ' ' outf ' ' Opts];

[status Out] = dos(cmnd);                   % excecute program

%% ------  Status  ------
if status>0
    Out
    warning('Command %s returns exit code > 0 (see Out above)', cmnd);
end

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



