function power = calc_average_power(onTime)
    %settings
    current = 1; %Amp
    resistance = 15; %Ohms
    
    %power for one interval (1 sec)
    p = current * resistance * resistance;
    
    length = size(onTime);
    
    sum = 0;
    for i = 1:length
        sum = sum + p;
    end
    
    power = 1;
    %power = sum / length;
end