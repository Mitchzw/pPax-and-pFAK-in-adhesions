function [D, image_bw, s, imax_Nall, adhesion, Dr, Dm] = run(image_BW_remove_thicken, image_p)
image_bw = image_BW_remove_thicken;

[~, a]=bwlabeln(image_BW_remove_thicken); %Label each of the area that can be used as a mask for single FA

spotMeasurements_Pax = regionprops(image_BW_remove_thicken, 'all');
numberOfSpots_Pax = size(spotMeasurements_Pax, 1);


D = zeros;
Dm = zeros;
adhesion = struct ('size', 0, 'peak_count', 0);
imax_Nall = zeros;
% Bins of Dr represent the sizes of FA: small = 0-5um; large = 5-...um
Dr = struct('width', 0, 'prom', 0, 'int', 0);
%pp = 1;

for s = 1 : numberOfSpots_Pax
   
    
    MinorAxis = spotMeasurements_Pax(s).MinorAxisLength/2;
    MajorAxis = spotMeasurements_Pax(s).MajorAxisLength/2;
    d = MinorAxis*2;

    Phi = spotMeasurements_Pax(s).Orientation;
    Phi = -(pi*Phi/180);
    cosPhi = cos(Phi);
    sinPhi = sin(Phi);
    
    Center_x = spotMeasurements_Pax(s).Centroid(1);
    Center_y = spotMeasurements_Pax(s).Centroid(2);
    
    x1 = abs(Center_x + MajorAxis*cosPhi);
    y1 = abs(Center_y + MajorAxis*sinPhi);
    
    x2 = abs(Center_x - MajorAxis*cosPhi);
    y2 = abs(Center_y - MajorAxis*sinPhi);
    
    if x1 < 1 
        x1 = 1;
    end
    if x2 < 1 
        x2 = 1;
    end
    if y1 < 1 
        y1 = 1;
    end
    if y2 < 1 
        y2 = 1;
    end
    
    X = [x1 x2];
    Y = [y1 y2];
    
    dist = 1000;
    distR = sqrt((x1-x2)^2+(y1-y2)^2);
    norm = distR/dist;    
    
try
    
    [~,~,C_sum,~,~,~]=improfile_integrated(image_p,d,X,Y,dist);
    
    xProfile_smooth = smooth(C_sum, 25); %Changed from 33
    [~, ~, ~, p_temp] = findpeaks(xProfile_smooth);
    p_temp(p_temp == 0)=[];
    p_threshold = quantile(p_temp,0.25);
    [ymax, imax, w, p] = findpeaks(xProfile_smooth, 'MinPeakProminence', p_threshold);
   
    imax = sort(imax);
    imax_N = length(imax);
    imax_Nall(:,s) = imax_N;
   
    adhesion.size(:,s) = distR*40;
    adhesion.peak_count(:,s) = imax_N;
    
        %imin = sort(imin);

        %imin_N = length(imin);
        %imin_Nall(:,s) = imin_N; 
    
        %% Getting the distances between spots in masked FA
        
       
        
      for k = 1 : imax_N %Loop through all the spots
         
       if (k+1 <= imax_N) 
            Periods = (imax(k+1)-imax(k))*40*norm;
            if (Periods >= 100 && Periods <= 1000)
            D(:,k,s) = Periods;
%                 if distR * 40 <= 5000
%                 Dr.small(k,s) = Periods;
%                 end;
%                 if distR * 40 > 5000
%                 Dr.large(k,s) = Periods;
%                 end;
            end                         
       
          width = w*40*norm;
          Dr.width(:,k,s) = width(k);
          Dr.prom (:,k,s) = p(k);

       end
      end
      
        
          
       
        
      
      
%       if pp == 1
%        %%Getting the distances between the minima
%        for w = 1 : imin_N %Loop through all the spots
% 
%             if (w+1 <= imin_N) 
%             Periods_min = (imin(w+1)-imin(w))*40*norm;
%                 if (Periods_min > 0)
%             Dm(:,w,s) = Periods_min;
%                 end
%             end  
%         end
%       end;     
end;
  
D(D == 0)=[];
Dm(Dm==0)=[];
Dr.width(Dr.width == 0) = [];

end


