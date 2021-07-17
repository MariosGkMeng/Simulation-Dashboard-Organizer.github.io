
% ========================================================
% Author: Marios Gkionis                                 |
% Revision: 1                                            |
% Date: 20/4/2021                                        |
%                                                        |
% This script reads the Autorun file in order to trigger |
% the user-desired action 								 |
%                                                        |
% ========================================================

T_sampl = 0.01;

simulated_automatically = 0;
fileName = ['auto_commands2.txt'];
while true %(user_command == 0)
    pause(T_sampl)
    user_command = read_user_command(fileName, 'run');
    user_command_save_sim = ...
        read_user_command(fileName, 'save_sim');
    user_command_plot_res = ...
        read_user_command(fileName, 'plot_res');
    
    if strcmp(user_command, '1')

        simulated_automatically = 0;


        % YOUR INPUT ====================================================================================
        runs_sim; % the script that runs a simulation
        % ====================================================================================

        simulated_automatically = 1;
        fclose(fid); 
        % NOTE: fclose is used to prevent following MATLAB error:
        % "Too many open files. Close files to prevent MATLAB
        % instability.'

    end

    if strcmp(user_command_save_sim, 'save_sim') && simulated_automatically
        try
			% YOUR INPUT ====================================================================================
            report_struct(d, res, '')
			% ====================================================================================
        catch
            fprintf(1,'The identifier was:\n%s',e.identifier);
            fprintf(1,'There was an error! The message was:\n%s',e.message);
        end
        simulated_automatically = 0;
    end
    
    if strcmp(user_command_plot_res, 'plot_res') && simulated_automatically
		% YOUR INPUT ====================================================================================
        plots_res;
		% ====================================================================================
    end
end
