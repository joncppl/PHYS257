try
    
    delete(instrfindall);
    arduino = serial('COM9', 'BaudRate', 9600);
    filename = ['data_' datestr(now)];
    filename = strrep(filename, ' ', '_');
    filename = strrep(filename, ':', '_');
    log_file = fopen(filename, 'w', 'n', 'UTF-8');

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
    iterator = 0;
    while 1
       read_string = fscanf(arduino, '%s');
        fprintf(log_file, '%s\n', read_string);
       if (0==isempty(strfind(read_string, 'resistor_')))
          resistor_temp(resistor_temp_size + 1) = temp_from_10bit(str2num(read_string(10:end)));
          resistor_temp_size = resistor_temp_size + 1;
       end
       if (0==isempty(strfind(read_string, 'temp1_')))
          temp_1(temp_1_size + 1) = temp_from_10bit(str2num(read_string(7:end)));
          temp_1_size = temp_1_size + 1;
       end
       if (0==isempty(strfind(read_string, 'temp2_')))
          temp_2(temp_2_size + 1) = temp_from_10bit(str2num(read_string(7:end)));
          temp_2_size = temp_2_size + 1;
       end
       if (0==isempty(strfind(read_string, 'temp3_')))
          temp_3(temp_3_size + 1) = temp_from_10bit(str2num(read_string(7:end)));
          temp_3_size = temp_3_size + 1;
       end
       if (0==isempty(strfind(read_string, 'temp4_')))
          temp_4(temp_4_size + 1) = temp_from_10bit(str2num(read_string(7:end)));
          temp_4_size = temp_4_size + 1;
       end
       if (0==isempty(strfind(read_string, 'temp5_')))
          temp_5(temp_5_size + 1) = temp_from_10bit(str2num(read_string(7:end)));
          temp_5_size = temp_5_size + 1;
       end

       if (mod(iterator, 25) ==0)
           hold off
           whitebg(gcf,'k');
           hold on
           plot(1:length(resistor_temp), resistor_temp, 'b');
           plot(1:length(temp_1), temp_1, 'r');
           plot(1:length(temp_2), temp_2, 'c');
           plot(1:length(temp_3), temp_3, 'g');
           %plot(1:length(temp_4), temp_4, 'w');
           %plot(1:length(temp_5), temp_5, 'y');
           
           l = length(temp_5);
           axis([l-20,l,0,5]);
           
           legend('pin 0', 'pin 1', 'pin 2', 'pin 3', 'pin 4', 'pin 5', 'Location', 'NorthEastOutside');
           drawnow;
       end
       
       iterator = iterator + 1;
    end

catch exc
    disp(getReport(exc, 'basic'));
    fclose(arduino);
    fclose(log_file);
    delete(instrfindall);
    %close gcf;    
end