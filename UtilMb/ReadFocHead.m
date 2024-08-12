%
% Reads focus header, the focLoc struct of FocAnf.h, see FocIO.h
%
% IN    fileID  file pointer
% OUT   F       focus location
%
function [F] = ReadFocHead( fileID ) 

F.nLev   = fread(fileID, 1, 'int=>int'); 
F.hgt    = fread(fileID, 1, 'int=>int');       % height (abs.  coords)
F.wth    = fread(fileID, 1, 'int=>int');       % width  (abs.  coords)
F.idf    = fread(fileID, 1, 'uint8=>uint8');   % identifier 
F.hgtN   = fread(fileID, 1, 'single=>single'); % height   (norm. coords)
F.wthN   = fread(fileID, 1, 'single=>single'); % width    (norm. coords)
F.posV   = fread(fileID, 1, 'single=>single'); % vert pos (norm. coords)
F.posH   = fread(fileID, 1, 'single=>single'); % horz pos (norm. coords)
F.szIorig= fread(fileID, 2, 'int=>int');       % original image size


