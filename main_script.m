
full_path = './../images/';
subject_name = 'yaleB01';
num_images = 11;
% num_images = 3;
% face_annot = [210, 80, 270, 250 ];
% face_annot = [240, 100, 210, 220 ];
face_annot = [250, 110, 190, 200 ];
image_size = [face_annot(4)+1, face_annot(3)+1];

%% ------------------------------------------ %%
%% Image Load
%% ------------------------------------------ %%
[ambient_image, imarray, light_dirs] = LoadFaceImages(full_path, subject_name, num_images);

%% ------------------------------------------ %%
%% Preprocessing
%% ------------------------------------------ %%
pre_imarray = preproc(imarray, num_images, face_annot, ambient_image);
% pre_imarray = imgaussfilt(pre_imarray, 5);

%% %%%%%%%%%%%%%%%%% Tas 1 : Calibrated Photomatric Stereo %%%%%%%%%%%%%%%%%%%%%%%% %%
algo_name = 'Calib';
%% ------------------------------------------ %%
%% get albedo and surface normals
%% ------------------------------------------ %%
[albedo_image, surface_normals] = cal_stereo(pre_imarray, light_dirs, num_images, image_size);

%% ------------------------------------------ %%
%% Compute height_map from surface normals
%% ------------------------------------------ %%
height_map = get_surface(surface_normals, image_size);

%% ------------------------------------------ %%
%% Display outputs
%% ------------------------------------------ %%
display_output(albedo_image, height_map, algo_name );
plot_surface_normals(surface_normals, algo_name );

%	%% %%%%%%%%%%%%%%%%% Tas 2 : Uncalibrated Photomatric Stereo %%%%%%%%%%%%%%%%%%%%%%% %%
%	algo_name = 'UnCalib';
%	%% ------------------------------------------ %%
%	%% get albedo and surface normals
%	%% ------------------------------------------ %%
%	
%	[albedo_image_2, surface_normals_2, light_dirs_2] = uncal_stereo(pre_imarray, num_images, image_size);
%	
%	%% ------------------------------------------ %%
%	%% Compute height_map from surface normals
%	%% ------------------------------------------ %%
%	height_map_2 = get_surface(surface_normals_2, image_size);
%	
%	%% ------------------------------------------ %%
%	%% Display outputs
%	%% ------------------------------------------ %%
%	display_output(albedo_image_2, height_map_2, algo_name);
%	plot_surface_normals(surface_normals_2, algo_name);
%	
%	
