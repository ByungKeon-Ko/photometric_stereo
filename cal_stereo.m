function [albedo_image, surface_normals] = cal_stereo(imarray, light_dirs, num_images, image_size)

S = light_dirs;
imarray_reshape = reshape(imarray, image_size(1)*image_size(2), num_images);
E = imarray_reshape;

b = zeros( 3, image_size(1), image_size(2) );
% E = permute(E, [3 1 2] );
E = permute(E, [2 1] );

b = inv(S'*S)*S' * E;

b_matrix = reshape( b, 3, image_size(1), image_size(2) );

albedo_image = zeros(image_size(1), image_size(2) );
surface_normals = zeros(image_size(1), image_size(2), 3);

for i = 1:1:image_size(1)
	for j = 1:1:image_size(2)
		albedo_image(i,j) = norm(b_matrix(:,i,j));
		surface_normals(i,j,:) = b_matrix(:,i,j) / albedo_image(i,j);
	end
end


end


% for i = 1:1:image_size(2)
% 	tmp_E = E(:,:,i);
% 	tmp_E = reshape(tmp_E, num_images, image_size(1) );
% 	b(:,:,i) = inv(S'*S)*S' *tmp_E ;
% end
