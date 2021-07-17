function report_struct(d, res, comm_usr, varargin)


% d is the struct that contains all the simulation related parameters
% res is the struct that contains all the desired output variables
% comm_usr: user comment for the simulation


global assess_switch
path_write_results = d.path_write_results;
path_struct_report = d.path_struct_report;
treat_mthd = '';
asc = @(x)any(strcmp(varargin, x)); fsc = @(x)find(strcmp(varargin, x));
% stf = @(x)(~isempty(strfind(varargin, x)));
switch nargin
    case 0
        % do nothing
    otherwise
        tmpStr = 'treatment';
        if asc(tmpStr)
            pos_last = fsc(tmpStr);
            try
                treat_mthd = varargin(pos_last + 1);
            catch
                error('You have not added a treatment method!')
            end
        end   
end

n_runs = length(fields(assess_switch));
new_run = ['run', num2str(n_runs+1)];

messr = ['RUN ', num2str(n_runs+1), ', REPORTING...'];
disp(messr);

ttmp.deb = d.deb; ttmp.sol = d.sol; ttmp.sim = d.sim;
ttmp.d = d; ttmp.comment = comm_usr;
if ~isempty(treat_mthd), ttmp.treatment = treat_mthd; end
ttmp.date = datestr(now);
fldr = fields(res);
for i = 1:len(fldr), ttmp.(fldr{i}) = res.(fldr{i});  end


nm = 'assess_switch';
try
    assess_switch.(new_run) = ttmp;
    sv_nm = [path_struct_report, '\', nm, '.mat']; save(sv_nm, nm)
catch
    dsp = 'Could not save the "assess_switch" log variable!'; disp(dsp)
end
disp(messr);

source = strrep([path_write_results, '\', d.new_run_fldr], '\\', '\');
destination = strrep([path_write_results, '\', new_run], '\\', '\');
movefile(source, destination);