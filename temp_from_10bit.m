function temp = temp_from_10bit(data)
    persistent a;
    if (0~=isempty(a))
        calibration_data = [
        100 40 %temperatures    
        5   3  %voltages
        ]; 
        x = calibration_data(2,:);
        y = calibration_data(1,:);
        a = polyfit(x, y, 1);
    end    
        voltage = 5 / 1024 * data;
        %temp = polyval(a, voltage);
        temp = voltage;
end