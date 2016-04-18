function out = endtask(task_name)
%ENDTASK is used to close tasks running in Windows/Linux by providing the process name.
%This function returns 0 or 1 based on success of killing a process. 
% 
% NOTE: This function requires the file isprocess.m to be on the path
% 
%
% Syntax: endtask('firefox')
%
% See also isprocess

% Copyright 2009 - 2013 The MathWorks, Inc.
% Written by Varun Gandhi 13-May-2009
error(nargchk(1,1,nargin))
error(nargoutchk(0,1, nargout));

if ischar(task_name)
    [test,pnum,pid]=isprocess(task_name);
else
    error('Input name of process');
end

if (test == 1 && pnum >= 1)
    for i= 1:pnum
	if ispc
            s=['taskkill /fi "PID eq ', num2str(pid{i}), '"'];
	end
	if isunix
            s=['kill -9 ', num2str(pid{i})];
	end
        [chk,result]=system(s);
    end
end

if (test == 0 || pnum==0 || chk ==1)
    disp('Either an error occured or no processes were found')
    out = false;
else
    disp('ENDTASK Successfully shutdown process')
    out = true;
end