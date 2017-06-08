function [p, dt, T, minR, maxR, minM, maxM] = Menu()
    prompt = {'Aantal Planeten', 
              'Stapgrootte', 
              'Stappen (jaren)', 
              'Minstraal', 
              'Maxstraal'
              'Minmassa',
              'Maxmassa'};

    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'1000', '1','20000', '1', '7','0.001','0.01'} ;
    options.Resize = 'on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

    p = str2num(answer{1});
    dt = str2num(answer{2});
    T = 12*str2num(answer{3});
    minR = str2num(answer{4});
    maxR = str2num(answer{5});
    minM = str2num(answer{6});
    maxM = str2num(answer{7});
end