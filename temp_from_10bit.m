function temp = temp_from_10bit(data)
voltage = 5 / 1024 * data;
temp = voltage;
end