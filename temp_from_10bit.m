function temp = temp_from_10bit(data, thermo_number)
persistent a0;
persistent a1;
persistent a2;
persistent a3;

%generate the fitting data
if (0~=isempty(a0))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Put Calibration Data Here! %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    temperatures = [
        68    65    60    55    50    47    45    42    40    36
        ];
    
    calibration_data_0 = [
        3.0469    3.0176    2.9443    2.8760    2.8223    2.7832    2.7686    2.7344    2.7148    2.6709
        ];
    calibration_data_1 = [
        3.0322    3.0078    2.9346    2.8711    2.8125    2.7734    2.7539    2.7295    2.7051    2.6660
        ];
    calibration_data_2 = [
        2.9785    2.9541    2.8809    2.8174    2.7686    2.7246    2.7100    2.6807    2.6611    2.6172
        ];
    calibration_data_3 = [
        2.9785    2.9492    2.8760    2.8174    2.7637    2.7246    2.7051    2.6758    2.6563    2.6123
        
        ];
    %%%%%%%%%%%%%%%%%
    % First calibration
    %%%%%%%%%%%%%%%%%
    %     temperatures = [
    %         75    70    65    60    55    50    45    40    35
    %         ];
    %     calibration_data_0 = [
    %         3.0469 2.9883 2.9346 2.8809 2.8564 2.8076 2.7539 2.7051 2.6514
    %         ];
    %     calibration_data_1 = [
    %         3.0322    2.9834    2.9297    2.8711    2.8467    2.7930    2.7393    2.6904    2.6416
    %         ];
    %     calibration_data_2 = [
    %         2.9736    2.9199    2.8613    2.8125    2.7979    2.7393    2.6904    2.6416    2.5928
    %         ];
    %     calibration_data_3 = [
    %         2.9736    2.9346    2.8711    2.8223    2.7930    2.7441    2.6953    2.6465    2.5928
    %         ];
    a0 = polyfit(temperatures, calibration_data_0, 1);
    a1 = polyfit(temperatures, calibration_data_1, 1);
    a2 = polyfit(temperatures, calibration_data_2, 1);
    a3 = polyfit(temperatures, calibration_data_3, 1);
end
voltage = 5 / 1024 * data;
%temp = polyval(a0, voltage);
if (thermo_number == 0)
    temp = (voltage - a0(2)) / a0(1);
elseif (thermo_number == 1)
    temp = (voltage - a1(2)) / a0(1);
elseif (thermo_number == 2)
    temp = (voltage - a2(2)) / a0(1);
elseif (thermo_number == 3)
    temp = (voltage - a3(2)) / a0(1);
end
end