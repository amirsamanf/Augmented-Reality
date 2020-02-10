% Q3.3.1

cv_cover = imread('../data/cv_cover.jpg');

bookVid = loadVid('../data/book.mov');
sourceVid = loadVid('../data/ar_source.mov');

fr = sourceVid(1).cdata;
for i=1:size(fr,1)
    if sum(fr(i,:)) > 10000
        cropInd = i;
        break
    end
end

v = VideoWriter('../data/out.avi');
open(v);

for i=1:length(sourceVid)
    
   bookFrame = bookVid(i).cdata;
   sourceFrame = sourceVid(i).cdata;
   cropFrame = sourceFrame(cropInd:size(sourceFrame,1)-cropInd, 213:426, :);
   if sum(sum(sum(cropFrame))) < 500000
      cropFrame(:) = 0; 
   end
   
   [locs1, locs2] = matchPics(cv_cover, bookFrame);
   [H,~] = computeH_ransac(locs1, locs2);
      
   scaled_source = imresize(cropFrame, [size(cv_cover,1) size(cv_cover,2)]);
   
   compositeFrame = compositeH(H, scaled_source, bookFrame);
      
   writeVideo(v,compositeFrame);

end

rest = length(bookVid) - length(sourceVid);

for i=1:rest
    
   bookFrame = bookVid(i+length(sourceVid)).cdata;
   sourceFrame = sourceVid(i).cdata;
   cropFrame = sourceFrame(cropInd:size(sourceFrame,1)-cropInd, 213:426, :);
   if sum(sum(sum(cropFrame))) < 500000
      cropFrame(:) = 0; 
   end
   
   [locs1, locs2] = matchPics(cv_cover, bookFrame);
   [H,~] = computeH_ransac(locs1, locs2);
      
   scaled_source = imresize(cropFrame, [size(cv_cover,1) size(cv_cover,2)]);
   
   compositeFrame = compositeH(H, scaled_source, bookFrame);
      
   writeVideo(v,compositeFrame);

end

close(v);




