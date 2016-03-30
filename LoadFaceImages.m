
function [ambimage,imarray,lightdirs] = LoadFaceImages(pathname, subject_name, num_images)

filename = [pathname subject_name '_P00_Ambient.pgm'];
ambimage = load_pgm(filename);
[h, w] = size(ambimage);

d = dir([pathname subject_name '_P00A*.pgm']);

filenames = {d(:).name};
total_images = numel(filenames);
filenames = {d( 1:num_images ).name};

Nimages = numel(filenames);
angle = zeros(2, Nimages);

imarray = zeros(h, w, Nimages);

for j = 1 : Nimages
	m = findstr(filenames{j},'A')+1;
	angle(1,j) = str2num(filenames{j}(m:(m+3)));
	m = findstr(filenames{j},'E')+1;
	angle(2,j) = str2num(filenames{j}(m:(m+2)));
	imarray(:,:,j) = load_pgm([pathname filenames{j}]);
end

[X,Y,Z]= sph2cart(pi*angle(1,:)/180,pi*angle(2,:)/180,1);
lightdirs = [Y;Z;X];
lightdirs = lightdirs';

