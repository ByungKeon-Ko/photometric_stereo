
full_path = './yale_FaceImages_For_Asgn#1/';
subject_name = 'yaleB01';
num_images = 11;
% face_annot = [210, 80, 270, 250 ];
% face_annot = [240, 100, 210, 220 ];
face_annot = [250, 110, 190, 200 ];
image_size = [face_annot(4)+1, face_annot(3)+1];
integration_method = 'average'; % 'column', 'row', 'average', 'random'

%% ------------------------------------------ %%
%% Image Load
%% ------------------------------------------ %%
[ambient_image, imarray, light_dirs] = LoadFaceImages(full_path, subject_name, num_images);

%% ------------------------------------------ %%
%% Preprocessing
%% ------------------------------------------ %%
pre_imarray = preproc(imarray, num_images, face_annot, ambient_image);

% imshow( pre_imarray(:,:,1) )

%% ------------------------------------------ %%
%% get albedo and surface normals
%% ------------------------------------------ %%
[albedo_image, surface_normals] = photometric_stereo(pre_imarray, light_dirs, num_images);

%% reconstruct height map (you need to fill in get_surface for different integration methods)
height_map = get_surface(surface_normals, image_size, integration_method);

%% display albedo and surface
display_output(albedo_image, height_map);

%% plot surface normal
plot_surface_normals(surface_normals);

%% save output (optional) -- note that negative values in the normal images will not save correctly!
save_flag = 0
if save_flag
    imwrite(albedo_image, sprintf('%s_albedo.jpg', subject_name), 'jpg');
    imwrite(surface_normals, sprintf('%s_normals_color.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,1), sprintf('%s_normals_x.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,2), sprintf('%s_normals_y.jpg', subject_name), 'jpg');
    imwrite(surface_normals(:,:,3), sprintf('%s_normals_z.jpg', subject_name), 'jpg');    
end


