% Robotics: Estimation and Learning 
% WEEK 3
% 
% Complete this function following the instruction. 
function myMap = occGridMapping(ranges, scanAngles, pose, param)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Parameters 

 
% % the number of grids for 1 meter.
 myResol = param.resol;
% % the initial map size in pixels
 myMap = zeros(param.size);
% % the origin of the map in pixels
 myorigin = param.origin; 
% 
% % 4. Log-odd parameters 
 lo_occ = param.lo_occ;
 lo_free = param.lo_free; 
 lo_max = param.lo_max;
 lo_min = param.lo_min;

 N = size(pose,2);
 for j = 1:N % for each time,

%     % Find grids hit by the rays (in the gird map coordinate)
     %j's col
    %x_occ = pose(1,j)+d*cos(pose(3,j)+scanAngles);
   % y_occ = pose(2,j)-d*sin(pose(3,j)+scanAngles);
   x=pose(1,j);
   y=pose(2,j);
   
    orig = [ ceil(myResol .* x) ; ceil(myResol .* y)] + myorigin;
    alpha = scanAngles(:,1);
    beta = alpha + pose(3,j);
    
    d = ranges(:,j);
    occ_temp = [d .* cos(beta)  -d .* sin(beta)] + repmat([x  y],size(ranges,1),1);
    occ_idx = ceil(myResol * occ_temp) + repmat(myorigin', size(ranges,1),1);
    for i = 1 : size(occ_idx,1)
        [freex, freey] = bresenham(orig(1), orig(2), occ_idx(i,1), occ_idx(i,2));
        free = sub2ind(size(myMap),freey,freex);
        myMap(free) = myMap(free) - lo_free;
    end
    myMap(occ_idx(:,2),occ_idx(:,1)) =  myMap(occ_idx(:,2),occ_idx(:,1)) + lo_occ;
    myMap(find(myMap > lo_max)) = lo_max;
    myMap(find(myMap < lo_min)) = lo_min;    
 end
end

   % i_xocc = myorigin(1)+(myResol(1)*x_occ)/0.04;
%    i_yocc = myorigin(2)+(myResol(2)*y_occ)/0.04
  %  occ=[i_xocc,i_yocc]
    
  %  gridcoord[j]=[i_xocc,i_yocc];
    

% 
    % Find occupied-measurement cells and free-measurement cells
  %  [freex, freey] = bresenham(myorigin1),myorigin(2),occ(1),occ(2)); 
  % convert to 1d index

%    free = sub2ind(size(myMap),freey,freex);

%     % Update the log-odds
%   
% 
%     % Saturate the log-odd values
%     
% 
%     % Visualize the map as needed
%    
% 
% end



