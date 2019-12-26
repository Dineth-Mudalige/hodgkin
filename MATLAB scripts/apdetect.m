function n=apdetect(to,tf,amp1,amp2)
%
% Numerical solution of the Hodgkin Huxley equations
% for parameters as set from file hhconst
%
% Gives the number of APs detected in the given time
%

global yo e_vr minfr hinfr ninfr;
global g_na_max g_k_max g_l;
global e_na e_k e_l e_vr;
global g_na_vr g_k_vr;
global delay1  width1;
global width2  delay2 ic vclamp;

% update all neccessary precalculated parameters

hhparams;

[ti,yi] = hode('hh',[to,to+delay1],yo);  % do not really need to integrate here but it makes the code more readable
yo = yi';
if vclamp~=0;
        yo = [vclamp; yo(2:4)];
        [t1,y1] = hode('hh',[to+delay1,to+delay1+width1],yo);
        len = length(t1);
        yo = [e_vr; y1(len,2:4)'];
        [t2,y2] = hode('hh',[to+delay1+width1,tf],yo);
        t = [ti;t1;t2];
        y = [yi;y1;y2];
elseif amp1~=0;
        ic = amp1;
        [t1,y1] = hode('hh',[to+delay1,to+delay1+width1],yo);
        len = length(t1);
        yo = y1(len,1:4)';
        ic = 0;
        [t2,y2] = hode('hh',[to+delay1+width1,to+delay1+width1+delay2],yo);
        len = length(t2);
        yo = y2(len,1:4)';
        ic = amp2;
        [t3,y3] = hode('hh',[to+delay1+width1+delay2,to+delay1+width1+delay2+width2],yo);
        len = length(t3);
        yo = y3(len,1:4)';
        ic = 0;
        [t4,y4] = hode('hh',[to+delay1+width1+delay2+width2,tf],yo);
        t = [ti;t1;t2;t3;t4];
        y = [yi;y1;y2;y3;y4];
end 

zci = @(v) find(v(:).*circshift(v(:), [-1 0]) <=0);                    % Returns Zero-Crossing Indices Of Argument Vector
zx = zci(y(:,1));                                                            % Approximate Zero-Crossing Indices
n = size(zx,1)/2; %Gives the number of APs generated