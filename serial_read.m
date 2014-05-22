try,

arduino = serial('COM9', 'BaudRate', 9600);

fopen(arduino);
resistor_temp = 0;
resistor_temp_size = 0;
temp_1 = 0;
temp_1_size = 0;
temp_2 = 0;
temp_2_size = 0;
temp_3 = 0;
temp_3_size = 0;
temp_4 = 0;
temp_4_size = 0;
temp_5 = 0;
temp_5_size = 0;

figure
while 1
   read_string = fscanf(arduino, '%s');
   if (0==isempty(strfind(read_string, 'resistor')))
      resistor_temp(resistor_temp_size + 1) = temp_from_10bit(str2num(read_string(9:end)));
      resistor_temp_size = resistor_temp_size + 1;
   end
   if (0==isempty(strfind(read_string, 'temp1')))
      temp_1(temp_1_size + 1) = temp_from_10bit(str2num(read_string(6:end)));
      temp_1_size = temp_1_size + 1;
   end
   if (0==isempty(strfind(read_string, 'temp2')))
      temp_2(temp_2_size + 1) = temp_from_10bit(str2num(read_string(6:end)));
      temp_2_size = temp_2_size + 1;
   end
   if (0==isempty(strfind(read_string, 'temp3')))
      temp_3(temp_3_size + 1) = temp_from_10bit(str2num(read_string(6:end)));
      temp_3_size = temp_3_size + 1;
   end
   if (0==isempty(strfind(read_string, 'temp4')))
      temp_4(temp_4_size + 1) = temp_from_10bit(str2num(read_string(6:end)));
      temp_4_size = temp_4_size + 1;
   end
   if (0==isempty(strfind(read_string, 'temp5')))
      temp_5(temp_5_size + 1) = temp_from_10bit(str2num(read_string(6:end)));
      temp_5_size = temp_5_size + 1;
   end
   
   
   hold off
   plot(1:length(resistor_temp), resistor_temp, 'b');
   hold on
   plot(1:length(temp_1), temp_1, 'r');
   plot(1:length(temp_2), temp_2, 'c');
   plot(1:length(temp_3), temp_3, 'g');
   plot(1:length(temp_4), temp_4, 'k');
   plot(1:length(temp_5), temp_5, 'y');
   drawnow;
end

fclose(arduino);

catch,
    fclose(arduino);
    disp('There was an error! :(');
end