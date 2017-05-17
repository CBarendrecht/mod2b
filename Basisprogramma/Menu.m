function [p, dt, T, minR, maxR]= Menu()
  prompt = {'Aantal Planeten', 
            'Stapgrootte', 
            'Stappen', 
            'Minstraal', 
            'Maxstraal'};
  
  dlg_title = 'Input';
  num_lines = 1;
  defaultans = {'20', '1','100', '1', '9'} ;
  options.Resize ='on';
  answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
  
  p = str2num(answer{1});
  dt = str2num(answer{2});
  T = str2num(answer{3});
  minR = str2num(answer{4});
  maxR = str2num(answer{5});

end