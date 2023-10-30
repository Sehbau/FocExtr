%
% Loads the descriptor histogram as saved under si_FocHist
% af LoadDescHist.m    
%
% IN    lfn     file path
% OUT   UNF     univariate, flat
%       BIF     bivariate, flat
%       Nunf    count for UNF
%       Nbif    count for BIF
%
function [UNF BIF Nunf Nbif F] = LoadFocHist(lfn) 

fileID   = fopen(lfn, 'r');
if (fileID<0), error('file %s not found', lfn); end

%% -----  header
F.nLev   = fread(fileID, 1,  'int=>int'); 
F.hgt    = fread(fileID, 1,  'int=>int'); % height (abs.  coords)
F.wth    = fread(fileID, 1,  'int=>int'); % width  (abs.  coords)
F.idf    = fread(fileID, 1,  'uint8=>uint8'); % identifier 
F.hgtN   = fread(fileID, 1,  'single=>single'); % height (norm. coords)
F.wthN   = fread(fileID, 1,  'single=>single'); % width  (norm. coords)
F.posV   = fread(fileID, 1,  'single=>single'); % vert pos (norm. coords)
F.posH   = fread(fileID, 1,  'single=>single'); % horz pos (norm. coords)


%% =====  flat univariate histograms  =====
[UNF.Skl Nunf.Skl] = ReadCntHist(fileID);

[UNF.Rsg Nunf.Rsg] = ReadRsgHist(fileID);

[UNF.Arc Nunf.Arc] = ReadArcHist(fileID);

[UNF.Str Nunf.Str] = ReadCntHist(fileID); % same params as Cnt

% perhaps in the future:
%[UNF.Rdg Nunf.Rdg] = ReadCntHist(fileID);
%[UNF.Riv Nunf.Riv] = ReadCntHist(fileID);
%[UNF.Edg Nunf.Edg] = ReadCntHist(fileID);


%% =====  flat bivariate histograms   =====
[BIF.Skl HBIV.Skl Nbif.Skl] = ReadCntHbiv(fileID);

[BIF.Rsg HBIV.Rsg Nbif.Rsg] = ReadRsgHbiv(fileID);

[BIF.Arc HBIV.Arc Nbif.Arc] = ReadArcHbiv(fileID);

[BIF.Str HBIV.Str Nbif.Str] = ReadCntHbiv(fileID);

% perhaps in the future:
%[BIF.Rdg HBIV.Rdg Nbif.Rdg] = ReadCntHbiv(fileID);
%[BIF.Riv HBIV.Riv Nbif.Riv] = ReadCntHbiv(fileID);
%[BIF.Edg HBIV.Edg Nbif.Edg] = ReadCntHbiv(fileID);

%% =====  trailer/eof   ======
eof    = fread(fileID, 1,  'int=>int'); % eof identifier
assert(eof==966);

fclose(fileID);





