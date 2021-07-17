% ========================================================
% Author: Marios Gkionis                                 |
% Revision: 1                                            |
% Date: 20/4/2021                                        |
%                                                        |
% This script prints the output signals generated from   | 
% the simulation in text files to be read by the User    | 
% Interface and be displayed in the live simulation      |
% dashboard											     | 
% sig_txt: a cell variable that contains the names of the| 
% signals to be printed. They can be of type cell, double| 
% or struct.       										 |
% Example: %sig_txt = {'Y1', 'Y2', 'Y3'};                |
% ========================================================

var_i_loop = {};
var_nm_loop = {};
zz = 0;
for i_stxt = 1:length(sig_txt)
    nar_nm = sig_txt{i_stxt}; var_i = eval(nar_nm);
    
    switch class(var_i)
        case 'double'
            zz = zz + 1;
            var_nm_loop{zz} = nar_nm;
			
            var_i_loop{zz} = var_i;
            
        case 'cell'
            n_var = length(var_i);
            for i_cv = 1:n_var
                zz = zz + 1;
                var_nm_loop{zz} = [nar_nm, '_', nst(i_cv)];
                var_i_loop{zz} = var_i{i_cv}; 
            end
            
        case 'struct'
            
            flds_i = fields(var_i);
            for i_sv = 1:length(flds_i)
                tmp_nm_i = flds_i{i_sv};
                tmp_var_i = var_i.(tmp_nm_i);
                switch class(tmp_var_i)
                    case 'cell'
                        for i_cv = 1:length(tmp_var_i)
                            zz = zz + 1;
                            var_nm_loop{zz} = [tmp_nm_i, '_', nst(i_cv)];
                            var_i_loop{zz} = tmp_var_i{i_cv}; 
                        end
                    otherwise
                        error('Nothing coded here.')      
                end              
            end
    end 
end
%%

n_vl = length(var_i_loop);
M_prnt_i = zeros(length(var_i_loop{1}), n_vl);


for izu = 1:n_vl
    tmpiz = (var_i_loop{izu}(:))';
    M_prnt_i(1:length(tmpiz), izu) = tmpiz;
    
end
line_0 = var_nm_loop{1};
for izu = 2:n_vl
    line_0 = [line_0, char(9), var_nm_loop{izu}];
end
writematrix(M_prnt_i, filePrnt, 'Delimiter', 'tab');
type(filePrnt);

fidi = fopen(filePrnt,'r');
itxt = 1;
clear Atxt;
Atxt{itxt} = line_0;

tline = fgetl(fidi);

while ischar(tline)
    itxt = itxt+1;
    Atxt{itxt} = tline;
    tline = fgetl(fidi); 
end
fclose(fidi);




fidi = fopen(filePrnt, 'w');
for izu = 1:numel(Atxt)
    if Atxt{izu} == -1
        fprintf(fidi,'%s', Atxt{izu});
        break
    else
        fprintf(fidi,'%s\n', Atxt{izu});
    end
end
fclose(fidi);