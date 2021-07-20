function [user_command, d_var] = read_user_command(fileName, cmode)

% ========================================================
% Author: Marios Gkionis                                 |
% Revision: 1                                            |
% Date: 20/4/2021                                        |
%                                                        |
% Read autorun file to get command from user interface   |
%                                                        |
% Under development:                                     |   
%   1. Passing "iRun" to the function that saves sim data|
%       in a struct variable                             |
% ========================================================

    d_var = struct();
    run_again_ln = 'run_again: ';
    fid = fopen(fileName); tline = fgetl(fid); user_command = '0';
    ctl = contains(tline, run_again_ln);
    switch cmode
        case 'run'
            if ctl
                user_command = tline(length(run_again_ln)+1);
            end
            rNum = 'rNum';
            if contains(tline, rNum)
                iRun = str2num(strrep(tline(ii+length(rNum):end), ' ', ''));
                d_var.iRun = iRun;
            end
            
        case 'save_sim'
            if ctl
                if contains(tline, 'save_sim')
                    user_command = 'save_sim';
                end
            end
            
        case 'stop_sim'
            if ctl
                if contains(tline, 'stop_sim')
                    user_command = 'stop_sim';
                end
            end
        case 'plot_res'
            if ctl
                if contains(tline, 'plot_res')
                    user_command = 'plot_res';
                end
            end
        otherwise
            error('Nothing coded here!')
    end
    fclose(fid);
end