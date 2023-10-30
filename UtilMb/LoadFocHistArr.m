%
% Loads the descriptor histogram as saved under si_FocHistArr
% Does not contain focus header, because we have a list of histograms.
% Read as an entire block.
%
% IN    lfn     file path
% OUT   Mx      [nBx nBin] list of histograms (matrix)
%
function [Mx Sz] = LoadFocHistArr(lfn) 

fileID   = fopen(lfn, 'r');
if (fileID<0), error('file %s not found', lfn); end

%% -----  header
nBbx     = fread(fileID, 1,  'int=>int'); 
dim      = fread(fileID, 1,  'int=>int'); 

%% -----  data
Mx       = fread(fileID, nBbx*dim, 'int=>int'); 

fclose(fileID);

%% -----  reshape
Mx       = reshape(Mx, [nBbx dim]);

Sz.nFoc  = nBbx;
Sz.dim   = dim;





