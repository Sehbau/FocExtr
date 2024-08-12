%
% Descriptor extraction for zones of ONE image. Two phases:
% - images created temporarily in IMGdown/...
% - descriptor created and saved in IMGDAT/...
%
% cf lvngRunDscxZon.m
%
function [] = f_ZonDscx( pthImg, Zon, pthIzon, pthDsc, ...
                            imgName, lineArgs, imgNo )

Ifll    = imread( pthImg);

%% -----  Create and Save the Zone Images to 'temp'  -----
bPlot   = 0;
AImgZon = u_ImgParcBbox( Ifll, Zon.Bbox, Zon.aLab, bPlot );
aFipZon = u_FinaApndIdfL( [pthIzon 'temp.jpg'], Zon.aLab, '_' );
s_ImgList( AImgZon, aFipZon, imgNo==1 );

%% -----  DescExtr  -----
for i = 1:Zon.nZon

    fistDsc  = [pthDsc 'DSC_' imgName '_' Zon.aLab{i}];
    fistDsc  = u_PathToBackSlash(fistDsc); 
    cmnd     = ['dscx ' aFipZon{i} ' ' fistDsc ' ' lineArgs]; 
    OutRef   = f_CmndExec( cmnd ); 
    
    fprintf('.');
    
end
%fprintf('dscx completed.\n');
fprintf(' ');
