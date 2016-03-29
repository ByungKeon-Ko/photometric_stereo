function [albedo_image, surface_normals] = photometric_stereo(imarray, light_dirs, num_images)

S = light_dirs;
E = imarray;
pre_size = size(imarray(:,:,1));

b = zeros( 3, pre_size(1), pre_size(2) );
E = permute(E, [3 1 2] );

for i = 1:1:pre_size(2)
	tmp_E = E(:,:,i);
	tmp_E = reshape(tmp_E, num_images, pre_size(1) );
	b(:,:,i) = inv(S'*S)*S' *tmp_E ;
end

albedo_image = zeros(pre_size(1), pre_size(2) );
surface_normals = zeros(pre_size(1), pre_size(2), 3);
for i = 1:1:pre_size(1)
	for j = 1:1:pre_size(2)
		albedo_image(i,j) = norm(b(:,i,j));
		surface_normals(i,j,:) = b(:,i,j) / albedo_image(i,j);
	end
end

end

