try
    
    delete(instrfindall);
    arduino = serial('COM9', 'BaudRate', 9600, 'Timeout', 100);
    filename = ['data_' datestr(now)];
    filename = strrep(filename, ' ', '_');
    filename = strrep(filename, ':', '_');
    log_file = fopen(filename, 'w', 'n', 'UTF-8');
    
    fopen(arduino);
    resistor_temp = zeros(86400, 1)';
    resistor_temp_size = 0;
    temp_1 = zeros(86400, 1)';
    temp_1_size = 0;
    temp_2 = zeros(86400, 1)';
    temp_2_size = 0;
    temp_3 = zeros(86400, 1)';
    temp_3_size = 0;
    temp_4 = zeros(86400, 1)';
    temp_4_size = 0;
    temp_5 = zeros(86400, 1)';
    temp_5_size = 0;
    power_status = zeros(86400, 1)';
    power_status_size = 0;
    power_plot = zeros(86400, 1)';
    power_plot_size = 0;
    
    figure
    iterator = 0;
    while 1
        read_string = fscanf(arduino, '%s');
        fprintf(log_file, '%s\n', read_string);
        if (0==isempty(strfind(read_string, 'resistor_')))
            resistor_temp(resistor_temp_size + 1) = temp_from_ambient_10bit(str2num(read_string(10:end)));
            resistor_temp_size = resistor_temp_size + 1;
        end
        if (0==isempty(strfind(read_string, 'temp1_')))
            temp_1(temp_1_size + 1) = temp_from_10bit(str2num(read_string(7:end)), 0);
            temp_1_size = temp_1_size + 1;
        end
        if (0==isempty(strfind(read_string, 'temp2_')))
            temp_2(temp_2_size + 1) = temp_from_10bit(str2num(read_string(7:end)), 1);
            temp_2_size = temp_2_size + 1;
        end
        if (0==isempty(strfind(read_string, 'temp3_')))
            temp_3(temp_3_size + 1) = temp_from_10bit(str2num(read_string(7:end)), 2);
            temp_3_size = temp_3_size + 1;
        end
        if (0==isempty(strfind(read_string, 'temp4_')))
            temp_4(temp_4_size + 1) = temp_from_10bit(str2num(read_string(7:end)), 3);
            temp_4_size = temp_4_size + 1;
        end
        if (0==isempty(strfind(read_string, 'temp5_')))
            temp_5(temp_5_size + 1) = temp_from_ambient_10bit_amplified(str2num(read_string(7:end)));
            temp_5_size = temp_5_size + 1;
        end
        
        if (0==isempty(strfind(read_string, 'power_on')))
            power_status(power_status_size + 1) = 1;
            power_status_size = power_status_size + 1;
            power_plot(power_plot_size + 1) = calc_average_power(power_status);
            power_plot_size = power_plot_size + 1;
        elseif (0==isempty(strfind(read_string, 'power_off')))
            power_status(power_status_size + 1) = 0;
            power_status_size = power_status_size + 1;
            power_plot(power_plot_size + 1) = calc_average_power(power_status);
            power_plot_size = power_plot_size + 1;
        end
        
        if (mod(iterator, 5*6) ==0)
            hold off
            whitebg(gcf,'k');
            hold on
            plot(1:length(resistor_temp), resistor_temp, 'b');
            plot(1:length(temp_1), temp_1, 'r');
            plot(1:length(temp_2), temp_2, 'c');
            plot(1:length(temp_3), temp_3, 'g');
            plot(1:length(temp_4), temp_4, 'w');
            plot(1:length(temp_5), temp_5, 'y');
            plot(1:length(power_plot), power_plot, 'm');
            
            l = temp_5_size;
            axis([l-20,l,0,200]);
            
            legend(strcat('Resistor Temp (', num2str(resistor_temp(resistor_temp_size + 1)), ')'), ...
                strcat('pin 0 (', num2str(temp_1(temp_1_size + 1)), ')'), ...
                strcat('pin 1 (', num2str(temp_2(temp_2_size + 1)), ')'), ...
                strcat('pin 2 (', num2str(temp_3(temp_3_size + 1)), ')'), ...
                strcat('pin 3 (', num2str(temp_4(temp_4_size + 1)), ')'), ...
                strcat('Ambient Temperature (', num2str(temp_5(temp_5_size + 1)), ')'), ...
                'Avg. Power', ...
                'Location', 'NorthEastOutside');
            drawnow;
            
            save matlab.mat
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