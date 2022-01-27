function [Image, image_nr, Image_name, Path] = read_image

Path = uigetdir;
Path_img = strcat(Path,'/*.jpg');
Img_Path_Names = dir(Path_img);
                                               
image_nr = size(Img_Path_Names,1);
Image = struct('I', 0);
Image_name = struct('I', 0);

    for s = 1:image_nr
    
        Image_name(s).I = strcat(Path,'/',Img_Path_Names(s).name);
        Image(s).I = imread(Image_name(s).I);
        [~, ~, dim] = size(Image(s).I);
        if dim > 1
        Image(s).I = rgb2gray(Image(s).I);
        end;
        %Image(s).I = imadjust(Image(s).I);
        
        
    end;
    
end