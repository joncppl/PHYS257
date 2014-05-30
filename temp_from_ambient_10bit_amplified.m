function temp = temp_from_ambient_10bit_amplified(data)
    %slope is 100C / V
    slope = 100;

    %get the voltage from the 10bit value
    voltage = 5 / 1024 * data;
    
    
    R2 =    99400;
    R1 =    9890;
    amplification = (1 + R2/R1);
    temp = slope * voltage / amplification; 
end