% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [segI, loc] = detectBall(I)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 

% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
mu =[146.402182265253,142.597356692792,63.8143537728600] ;
sig = diag([16.337832171663830;12.418235964334710;20.225822170463210]);
thre =0.000001;
covar=[2.669247600694537e+02,2.028870550534205e+02,3.304460881549454e+02;2.028870550534205e+02,1.542125844658960e+02,2.511690322854846e+02;3.304460881549454e+02,2.511690322854846e+02,4.090838824712012e+02];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
mask=zeros(120,160);
segI=false(120,160);
for i=1:120
    for j=1:160
      
        Prob = mvnpdf(double([I(i,j,1) I(i,j,2) I(i,j,3)]),mu,sig);
        if Prob > thre
            mask(i,j)=1;
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.

%{
bw=mask;


% create new empty binary image
bw_biggest = false(size(bw));

% http://www.mathworks.com/help/images/ref/bwconncomp.html
CC = bwconncomp(bw);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
segI(CC.PixelIdxList{idx}) = true; 

%}

%bw_biggest = false(120,160,3);
CC = bwconncomp(mask);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
segI(CC.PixelIdxList{idx}) = true; 
%segI = bw_biggest;
S = regionprops(CC,'Centroid');
loc = S(idx).Centroid;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%

% segI = 
% loc = 
% 
% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end
