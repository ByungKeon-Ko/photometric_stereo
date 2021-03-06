function plot_surface_normals(surface_normals, algo_name )
% surface_normals: h x w x 3 matrix
  
    figure;
    subplot(1,3,1);
    imagesc(surface_normals(:,:,1), [-1 1]); colorbar; axis equal; axis tight; axis off;
    title(strcat(algo_name, ' X' ) )
    subplot(1,3,2);
    imagesc(surface_normals(:,:,2), [-1 1]); colorbar; axis equal; axis tight; axis off;
    title(strcat(algo_name, ' Y' ) )
    subplot(1,3,3);
    imagesc(surface_normals(:,:,3), [-1 1]); colorbar; axis equal; axis tight; axis off; 
    title(strcat(algo_name, ' Z' ) )
    
end

