function [v0,v1,v2,v3] = read_voltage()
delete(instrfindall);
arduino = serial('COM9', 'BaudRate', 9600);
fopen(arduino);

read_string = fscanf(arduino, '%s');
counted = 0;
d0 = 0;
d1 = 0;
d2 = 0;
d3 = 0;
while (counted < 4)
    read_string = fscanf(arduino, '%s'); 
    if (0==isempty(strfind(read_string, 'temp1_')))
        d0 = str2num(read_string(7:end));
        counted = counted + 1;
    end
    if (0==isempty(strfind(read_string, 'temp2_')))
        d1 = str2num(read_string(7:end));
        counted = counted + 1;
    end
    if (0==isempty(strfind(read_string, 'temp3_')))
        d2 = str2num(read_string(7:end));
        counted = counted + 1;
    end
    if (0==isempty(strfind(read_string, 'temp4_')))
        d3 = str2num(read_string(7:end));
        counted = counted + 1;
    end
end
v0 = 5 / 1024 * d0;
v1 = 5 / 1024 * d1;
v2 = 5 / 1024 * d2;
v3 = 5 / 1024 * d3;
end