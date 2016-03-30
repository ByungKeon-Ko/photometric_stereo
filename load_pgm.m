function [pic,maxgray]=load_pgm(filename)

 fid=fopen(filename);

 code=fscanf(fid,'%s',1);


 width=[];
 while (isempty(width))
   [width,cnt]=fscanf(fid,'%d',1);
   if (cnt==0)
     fgetl(fid);
   end
 end

 height=fscanf(fid,'%d',1);

 maxgray=fscanf(fid,'%d',1);

 cnt=fread(fid,1);		% newline
 pic=fread(fid,[width,height])';

 fclose(fid);


