fileName_pars_excel = 'myParameters__from_EXCEL.m';
fid = fopen(fileName_pars_excel);
tline = 'g';
while ~isempty(tline)
    tline = fgetl(fid);
    try
        eval(tline);
    catch
        tline = '';
    end
end
fclose(fid);
