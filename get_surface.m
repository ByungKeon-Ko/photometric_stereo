function  height_map = get_surface(surface_normals, image_size)
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object


p_array = zeros( image_size(1), image_size(2) );
q_array = zeros( image_size(1), image_size(2) );

for pos_y = 1:1:image_size(1)
	for pos_x = 1:1:image_size(2)
		if surface_normals(pos_y,pos_x,3) == 0
			fprintf('hello surf normal')
		end
		p_array(pos_y,pos_x) = - surface_normals(pos_y,pos_x,2) / surface_normals(pos_y,pos_x,1);
		q_array(pos_y,pos_x) = - surface_normals(pos_y,pos_x,3) / surface_normals(pos_y,pos_x,1);
	end
end

% p_array = imgaussfilt( p_array, 3);
% q_array = imgaussfilt( q_array, 3);

% height_map = zeros( image_size(1), image_size(2) )+50;
height_map = zeros( image_size(1), image_size(2) );

for pos_y = 1:1:image_size(1)
	for pos_x = 1:1:image_size(2)
		% % x-direction first, and y-direction later
		x_height_map = sum(p_array(1, 1:pos_x) ) + sum(q_array(1:pos_y, pos_x) );
		% y-direction first, and x-direction later
		y_height_map = sum(p_array(pos_y, 1:pos_x) ) + sum(q_array(1:pos_y, 1) );
		height_map(pos_y,pos_x) = (x_height_map + y_height_map ) / 2.0;

		% height_map(pos_y,pos_x) = x_height_map;
		% height_map(pos_y,pos_x) = y_height_map;

		%	incr_x = 1;
		%	incr_y = 1;
		%	random_seq = randi([0,1], [pos_x+pos_y-2]);
		%	for incr = 1:1:pos_x+pos_y-2
		%		if ((random_seq(incr) == 0 ) & ( incr_x <= pos_x-1)) | (incr_y > pos_y-1)
		%			incr_x = incr_x + 1;
		%			height_map(pos_y, pos_x) = height_map(pos_y, pos_x) + p_array(incr_y, incr_x);
		%		elseif random_seq(incr) == 1
		%			incr_y = incr_y + 1;
		%			height_map(pos_y, pos_x) = height_map(pos_y, pos_x) + q_array(incr_y, incr_x);
		%	end

		% height_map(pos_y, pos_x) = height_map(pos_y, pos_x) - (pos_x+pos_y-2)*0.0;
		% height_map(pos_y, pos_x) = height_map(pos_y, pos_x) + (pos_y-1)*0.6 + ( pos_x-pos_y)*0.25;
	end
end

% height_map = imgaussfilt( height_map, 5);

end

