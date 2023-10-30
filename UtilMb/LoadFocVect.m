%
% Loads the descriptor vectors (attributes) as saved under si_FocVect
%
function [V Kt] = LoadFocVect(lfn) 

fileID   = fopen(lfn, 'r');
if (fileID<0), error('file %s not found', lfn); end

%% -----  header
nLev  = fread(fileID, 1,  'int=>int');      % # of pyramid levels
szV   = fread(fileID, 1,  'int=>int');      % vertical image size
szH   = fread(fileID, 1,  'int=>int');      % horizontal image size
ntDsc = fread(fileID, 1,  'int=>int');      % # of total desc
idfF  = fread(fileID, 1,  'uint8=>uint8');  % file identifier

% flags (unsigned char)
bGrp  = fread(fileID, 1,  'uint8=>uint8');  % not used at the moment
bFlg2 = fread(fileID, 1,  'uint8=>uint8');  % not used at the moment
bFlg3 = fread(fileID, 1,  'uint8=>uint8');  % not used at the moment
bFlg4 = fread(fileID, 1,  'uint8=>uint8');  % not used at the moment
bFlg5 = fread(fileID, 1,  'uint8=>uint8');  % not used at the moment

assert(idfF==100,'file idf not correct (44): %d', idfF);
assert(nLev>0 && nLev<12,'nLev not correct: %d', nLev);
assert(szV>0 && szV<5000, 'szV unreasonable: %d', szV);
assert(szH>0 && szH<5000, 'szH unreasnoable: %d', szH);

%% =====  Spaces  =====
[V.ACNT Kt.Ncnt]        = ReadCntSpc(fileID);
[V.ARSG Kt.Nrsg]        = ReadRsgSpc(fileID);
[V.AARCfll Kt.NarcFll]  = ReadArcSpc(fileID); % full set
[V.ASTRfll Kt.NstrFll]  = ReadStrSpc(fileID);

% order reversed!?
%[V.ASTRgst Kt.NstrGst]  = ReadStrSpc(fileID); % gerust
%[V.AARCgst Kt.NarcGst]  = ReadArcSpc(fileID);

%% =====  trailer/idf   ======
%idf    = fread(fileID, 1,  'int=>int'); % identifier
%assert(idf==888);

fclose(fileID);

%% ------   A2S   -------
%Kt.Ncnt
Kt.nLev    = double(nLev);          % its easier in Matlab with double
Kt.szV     = szV;
Kt.szH     = szH;
Kt.ntDsc   = ntDsc;

