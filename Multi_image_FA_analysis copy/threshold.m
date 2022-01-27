function [image_BW] = threshold (Image, thresholdValue)

image_BW = Image > thresholdValue;

end