function pre_imarray = preproc(imarray, num_images, face_annot, ambient_image)

pre_imarray = zeros( face_annot(4)+1, face_annot(3)+1, num_images );

tmp_size = size(imarray(:,:,1));
threshold_array = zeros(tmp_size(1), tmp_size(2)) + 0./255.;

for i = 1:1:num_images
	imarray(:,:,i) = imarray(:,:,i)-ambient_image ;
	imarray(:,:,i) = imarray(:,:,i) / 255.0;
	imarray(:,:,i) = max(threshold_array, imarray(:,:,i) );
	pre_imarray(:,:,i) = imcrop(imarray(:,:,i), face_annot);
end

end

