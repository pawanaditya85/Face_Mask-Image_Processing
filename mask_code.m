clc
close all

%%importing images
og= imread('google3.jpg');
subplot(1,3,1);
imshow(og);
title("imported image");

%removing noise from image
median=medfilt3(og);
subplot(1,3,2);
imshow(median);
title('noise filtered image');


%%detection of eye
Eyedetect = vision.CascadeObjectDetector('EyePairBig');

eye = step(Eyedetect,og);

%%detection of nose
Nosedetect = vision.CascadeObjectDetector('Nose','MergeThreshold',4);

nose = step(Nosedetect,og);

%%detection of mouht
Mouthdetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',500);

mouth = step(Mouthdetect,og);

if ~isempty(mouth)
    md = insertObjectAnnotation(og,'Rectangle',mouth,"mouth",'LineWidth',3);
    subplot(1,3,3);
    imshow(md);
    title("Person is not wearing mask");
    
elseif ~isempty(nose)
    nd = insertObjectAnnotation(og,'Rectangle',nose,"nose",'LineWidth',3);
    subplot(1,3,3);
    imshow(nd);
    title("Person is not wearing mask properly");
    
else 
    subplot(1,3,3);
    imshow(og);
    rectangle('Position',eye,'LineWidth',3,'LineStyle','-','EdgeColor','b');
    title("person is wearing mask");
    eyes=imcrop(og,eye)
end