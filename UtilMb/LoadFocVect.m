%
% Loads the descriptor vectors (attributes) as saved under si_FocVect
%
function [V Floc Kt] = LoadFocVect(lfn) 

fileID   = fopen(lfn, 'r');
if (fileID<0), error('file %s not found', lfn); end

%% -----  header
HedV    = ReadDescFileHead( fileID, 100 );
Floc    = ReadFocHead( fileID );

%% =====  Spaces  =====
[V.ACNT Kt.Ncnt]        = ReadCntSpc(fileID);
[V.ARSG Kt.Nrsg]        = ReadRsgSpc(fileID);
[V.AARCfll Kt.NarcFll]  = ReadArcSpc(fileID); % full set
[V.ASTRfll Kt.NstrFll]  = ReadStrSpc(fileID);
[V.ASHP Kt.Nshp]        = ReadShpSpc(fileID); % shape

% order reversed!?
%[V.ASTRgst Kt.NstrGst]  = ReadStrSpc(fileID); % gerust
%[V.AARCgst Kt.NarcGst]  = ReadArcSpc(fileID);

%% =====  trailer/idf   ======
%idf    = fread(fileID, 1,  'int=>int'); % identifier
%assert(idf==888);

fclose(fileID);

%% ------   A2S   -------
%Kt.Ncnt
Kt.nLev    = double( HedV.nLev);      % its easier in Matlab with double
Kt.szV     = double(HedV.szV);
Kt.szH     = double(HedV.szH);
Kt.ntDsc   = double(HedV.ntDsc);
Kt.Floc    = Floc;
