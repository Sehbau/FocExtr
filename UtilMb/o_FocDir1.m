%
% Organizes the focus files of ONE directory and saves them with file
% identifier 'FL_' as prefix.
%
% Situation: a list of images with each image having several focii of
% different size (different pyramid height, different num of levels), ie.
%
%       img1_Lev1_f1.vef
%       img1_Lev2_f1.vef
%       img1_Lev1_f2.vef
%       img1_Lev2_f2.vef
%       img1_Lev3_f2.vef
%       img2_Lev1_f1.vef
%       ...
%
function [] = o_FocDir1( aImgNa, pth, pyrHgt )

nImg = length( aImgNa );
Levs = 1:pyrHgt;

for i = 1:nImg
        
    imgNa   = aImgNa{i};            % one image name

    fipa    = [ pth imgNa ];        % its path

    % obtains the focus filenames for different levels
    % AFina{lev=1} = 'imgi_Lev1_f1.vef'
    %                'imgi_Lev1_f2.vef'
    % AFina{lev=2} = 'imgi_Lev2_f1.vef'
    %                'imgi_Lev2_f2.vef'
    AFinaLev = o_DirFocNamLev( fipa, Levs ); 

    % generate list paths for levels:
    %   FL_imgi_Lev1.txt
    %   FL_imgi_Lev2.txt
    %   ...
    aLipas   = o_FocLstNames( pth, imgNa, pyrHgt ); 

    % now save the list files:
    SaveFocLstsFromDir( AFinaLev, pth, aLipas ); 

end

