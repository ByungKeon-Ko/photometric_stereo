
function [albedo_image, surface_normals, light_dirs] = uncal_stereo(imarray, num_images, image_size )

B_matrix = zeros( image_size(1), image_size(2), 3 );
% light_matrix = zeros( image_size(1), 3, num_images );

start_index = 1;

%% GBR transform
lambda = 0.5;
myu = 0.0;
v = 0.0;
%	lambda = 1.0;
%	myu = 0.5;
%	v = 0.5;
Gt = [	lambda	0		-myu; 
		0		lambda	-v;
		0		0		1	];

imarray_reshape = reshape(imarray, image_size(1)*image_size(2), num_images);
[U,S,V] = svds( imarray_reshape, 3 );

B_matrix	= reshape(U * S * Gt, image_size(1), image_size(2), 3 );
light_dirs = inv(Gt) * V';

albedo_image = zeros(image_size(1), image_size(2) );
surface_normals = zeros(image_size(1), image_size(2), 3);

for i = 1:1:image_size(1)
	for j = 1:1:image_size(2)
		albedo_image(i,j) = norm( reshape(B_matrix(i,j,:), 1, 3) );
		tmp_normal = B_matrix(i,j,:) / albedo_image(i,j);
		surface_normals(i,j,:) = [tmp_normal(2), tmp_normal(3), tmp_normal(1) ];
	end
end


end

%	for ind_y = 1:1:image_size(1)
%		for ind_x = 1:1:image_size(2)
%			if (albedo_image(ind_y, ind_x) == NaN )
%				fprintf('hello bug in albedo %d%d', ind_y, ind_x);
%			end
%		end
%	end
%	
%	for ind_y = 1:1:image_size(1)
%		for ind_x = 1:1:image_size(2)
%			if (surface_normals(ind_y, ind_x,1) == NaN ) | (surface_normals(ind_y, ind_x,2) == NaN ) | (surface_normals(ind_y, ind_x,3) == NaN ) 
%				fprintf('hello bug in surface normals');
%			end
%		end
%	end

