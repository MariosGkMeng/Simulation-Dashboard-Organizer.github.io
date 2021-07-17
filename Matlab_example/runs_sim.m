% Example: get the time history of pro and anti-inflammatory cytokyne
% concentrations

read_parameters;

% Signals to print (user-modifiable)
sig_txt = {'tj' 'Aj' 'Pj' 'dAj' 'dPj' 'phi_pj' 'psi_pj' 'theta_aj'};

n_print = 10;
T_delay = 2.5; %add some delay to showcase the live plot production
prnt = @(fid, x)fprintf(fid, x); fnln = @(fid)fprintf(fid, '\n');
t = 0:d.dt:d.t_end;
zr0 = zeros(length(t), 1);
P = zr0; P(1) = d.P0;
A = zr0; A(1) = d.A0;
dP = zr0; dA = zr0;
phi_p = zr0; psi_p = zr0; theta_a = zr0;
z=0;

for i = 1:length(t)-1
    tic
    phi_p(i) = d.c0 + d.c1*(P(i)/(P(i)+d.c2));
    theta_a(i) = d.c3*d.c4/(d.c4 + A(i));
    psi_p(i) = d.c5*P(i)/(d.c6+P(i));
    dA(i) = -d.da*A(i)+psi_p(i);
    dP(i) = phi_p(i)*theta_a(i)-d.dp*P(i);
    A(i+1) = A(i)+dA(i)*d.dt;
    P(i+1) = P(i)+dP(i)*d.dt;
    
    
    if mod(i, n_print) == 0
        pause(T_delay);
        z = z + 1;
        for k = 1:length(sig_txt)
            eval([sig_txt{k}, '=', sig_txt{k}(1:end-1), '(i-',num2str(n_print),'+1:i);'])
        end
        % write current simulation data
        filePrnt = ['iter_data_print_to_dashb_',...
            num2str(z),  '.txt'];
        print_curr_iter_res
        if z > 1
            fid = fopen(d.md_sol_track,'a');
        else
            fid = fopen(d.md_sol_track,'w');
        end
        
        prnt(fid, [num2str(z), ' t = ', num2str(toc), ' s']);
        fnln(fid); fnln(fid); fnln(fid);
        fclose(fid);
    end
    
    read_command_stop_sim = ...
        read_marios_command(d.autoCmdFile, 'stop_sim');
    
    if strcmp(read_command_stop_sim, 'stop_sim')
        disp('EXITING SIMULATION!!')
        break;
    end
end




