%%Videogenerator creates videos at 30fps from images 
% Make an avi movie from a collection of PNG images in a folder.

% Specify the folder.
myFolder = 'C:\Research Work\Skeleton-Images-2015-08-19-13-20';
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end
% Get a directory listing.
filePattern = fullfile(myFolder, '*.JPEG');
jpegFiles = dir(filePattern);

% Open the video writer object.
writerObj = VideoWriter('Skeleton.avi');
writerObj.FrameRate = 30;
open(writerObj)

% Go through image by image writing it out to the AVI file.
for frameNumber = 1 : length(jpegFiles)
    
    % Construct the full image filename. 
    FileName = jpegFiles(frameNumber).name;
    C = strsplit(FileName,'-');
    baseFileName = strcat(C{1},'-', num2str(frameNumber),'.jpeg');
    fullFileName = fullfile(myFolder, baseFileName);
    % Display image name in the command window.
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Display image in an axes control.
    I = imread(fullFileName);
    
    %To Crop images in the video
    % For RGB Image use [1050 10 800 800] and for Skeleton use [240 80 300 300]
    % imageArray = imcrop(I,[1050 10 800 800]);
    imageArray = imcrop(I,[240 80 300 300]);
    imshow(imageArray);  % Display image.
    drawnow; % Force display to update immediately.
   
    % Write this frame out to the AVI file.
    writeVideo(writerObj, imageArray);
end
% Close down the video writer object to finish the file.
close(writerObj);