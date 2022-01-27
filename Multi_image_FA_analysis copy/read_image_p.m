function [Image_p] = read_image_p

Path = uigetdir;
Path_img = strcat(Path,'/*.jpg');
Img_Path_Names = dir(Path_img);
                                               
image_nr = size(Img_Path_Names,1);
Image_p = struct('I', 0);

    for s = 1:image_nr
    
        Image_name = strcat(Path,'/',Img_Path_Names(s).name);
        Image_p(s).I = imread(Image_name);
        [~, ~, dim] = size(Image_p(s).I);
        if dim > 1
        Image_p(s).I = rgb2gray(Image_p(s).I);
        end;
        %Image_p(s).I = imadjust(Image_p(s).I);
        
    end;
    
end