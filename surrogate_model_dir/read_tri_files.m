function [vertices,tri]=read_tri_files(filename)
    fid=fopen(filename,'r');
    number_of_points=-1*str2num(fgetl(fid));
    for idx=1:number_of_points
        x=str2num(fgetl(fid));
        vertices(idx,1)=x(1);
        vertices(idx,2)=x(2);
        vertices(idx,3)=x(3);
        
    end
    number=str2num(fgetl(fid));
    Num_triangles=number(2);
    for idx=1:Num_triangles
       x= str2num(fgetl(fid));
       tri(idx,1)=x(1);
       tri(idx,2)=x(2);
       tri(idx,3)=x(3);
       
    end
    
    
    fclose(fid);
end
