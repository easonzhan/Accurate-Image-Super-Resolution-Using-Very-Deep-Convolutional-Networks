%% set parameters
folder = '~/workspace/Data/SR/Test/Set5';
filepaths = dir(fullfile(folder,'*.bmp'));

for up_scale = 2:4
for i = 1 : length(filepaths)
    image = imread(fullfile(folder,filepaths(i).name));
    image = rgb2ycbcr(image);
    image = im2double(image(:, :, 1));                      
    
    im_gnd = modcrop(image, up_scale);
    [hei,wid,channel] = size(im_gnd);
   
    im_b = imresize(imresize(im_gnd,1/up_scale,'bicubic'),[hei,wid],'bicubic');

    
    fpX = fopen(strcat('~/workspace/Data/SR/testX',num2str(i),'_',num2str(up_scale),'.bin'),'w');
    fpY = fopen(strcat('~/workspace/Data/SR/testY',num2str(i),'_',num2str(up_scale),'.bin'),'w');
    fpSize = fopen(strcat('~/workspace/Data/SR/testSize',num2str(i),'_',num2str(up_scale),'.txt'),'w');

    fwrite(fpX,permute(im2uint8(im_b),[2,1,3]),'uint8');
    fwrite(fpY,permute(im2uint8(im_gnd),[2,1,3]),'uint8');
    fprintf(fpSize,'%d\n%d',hei,wid);
    
    fclose(fpX);
    fclose(fpY);
    fclose(fpSize);
    
end
end








