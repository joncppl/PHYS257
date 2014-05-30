function temp = temp_from_ambient_10bit(data)
    %slope is 100C / V
    slope = 100;

    %get the voltage from the 10bit value
    voltage = 5.0 / 1024.0 * data;
    temp = slope * voltage;
end