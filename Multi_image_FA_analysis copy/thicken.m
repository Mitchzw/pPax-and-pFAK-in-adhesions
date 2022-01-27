function [image_BW_remove_thicken] = thicken(image_BW_remove,thickenValue)

image_BW_remove_thicken = bwmorph(image_BW_remove, 'thicken', thickenValue);
%image_BW_remove_thicken = bwmorph(image_BW_remove_thicken, 'bridge', 1);
image_BW_remove_thicken = imfill(image_BW_remove_thicken, 'holes');
end