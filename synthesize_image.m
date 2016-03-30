
function synthesize_image(new_light_dir, albedo_image, surface_normals, image_size, algo_name)

new_light_dir  = reshape(new_light_dir, 1,3);
albedo_reshape = reshape(albedo_image, image_size(1) * image_size(2), 1 );
normal_reshape = reshape(surface_normals, image_size(1) * image_size(2), 3 );

B = zeros(image_size(1)* image_size(2), 3 );
for i = 1:1:image_size(1) * image_size(2)
	B(i, :) = normal_reshape(i,:) .* albedo_reshape(i,1);
end

E = B * new_light_dir';
syn_image = reshape(E, image_size(1), image_size(2));

figure;
imshow( syn_image )
title(strcat(algo_name, ' Synthesized Image' ) )

end

