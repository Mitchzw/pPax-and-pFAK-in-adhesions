function [image_BW_remove] = remove(image_BW, removeValue)

image_BW_remove = bwareaopen(image_BW, removeValue);

end