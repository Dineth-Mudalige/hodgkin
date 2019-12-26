hhconst;
% %Question 1
% Setting the two initial values as defined in the exercise. 
% 
width1 = 1;
amp1 = 6;
hhmplot(0,50,0);
amp1 = 7;
hhmplot(0,50,1);
% amp1 = 6 is below threshold and amp=7 is above threshold
% detecting the AP generation using zerocrossing as in apdetect.m and giving
% values according to bissection method
amp1 = 6;
b = 7;
while not(apdetect(0,50,amp1,0) & not(apdetect(0,50,amp1-0.01,0)) )
    if apdetect(0,50,amp1,0)
        b = amp1;
    else
        a = amp1;
    end
    amp1 = round(((a+b)/2),2);
end
fprintf('Sub-threshold = %.2f\nSupra-threshold = %.2f\n',amp1-0.01,amp1)
% %Plotting the sub and suprathresholds
% Figure 1 gives the new plots 

amp1 = 6.96;
hhmplot(0,50,0);
amp1 = 6.95;
hhmplot(0,50,1);

% Question 2
% To obtain the relationship between the inward current and the sum of ionic
% currents through the gates. Let amp1 be 6,8,10,15 and width be 5,7

for amp1 =[6,8,10,15]
    for width = [5,7]
        [qna,qkl,ql] = hhsplot(0,50);
        jk = qna+qkl+ql;%Total ionic current densities
        jei = amp1;
        fprintf('For amp1 %d and width %d\nThe total current density(jk)=%.3f+%.3f+%.3f =%.3f\nThe net inward current(jei) =%.3f\n',amp1,width,qna,qkl,ql,jk,jei)
    end
end
% Total ionic current = amp1 without width consideration

% %Question 3
amp1 = 26.8;
width1 = 0.5;
width2 = 0.5;
amp2 = 0;
for delay2 = [20,18,16,14,12,10,8,6]
    while (apdetect(0,30,amp1,amp2)<2)
        amp2=amp2+0.1;
    end
    fprintf('For delay of %d, I2th is %.1f\n',delay2,amp2)
    if (apdetect(0,30,amp1,amp2)>=2)
        amp2=0;
    end
end
% Question 4
% Using the values found in Question 3
I2 = [11.6,11.3,12.7,17,25.5,40.8,70.1,145.3];
t = [20,18,16,14,12,10,8,6];
I1 = 13.4;%Predefined first current threshold
figure;
plot(t,I2/I1,'-r');
xlabel('Delay(ms)');
ylabel('I2/I1 ratio');
title('I2/I1 ratio with time');
% Question 5
% By using the apdetect.m derived from hhmplot.m
for amp1=[5,10,20,30,50,70]
    width1=80;
    delay2=0;
    width2=0;
    fprintf('For a current stimulus of %d, there are %d action potentials in 0.1s\n.',amp1,apdetect(0,100,amp1,0));
end
width1=80;
delay2=0;
width2=0;
amp1=100;
% Need to plot for 100ms as the AP does not exceed zero
hhmplot(0,100,0);
I = [5,10,20,30,50,70,100];
f = [10,60,70,80,100,110,120];
figure;
plot(I,f,'-g');
xlabel('Stimulus current');
ylabel('AP frequency');
title('AP frequency with stimulus current');
%Question 6
width1=80;
delay2=0;
width2=0;
amp1=200;
hhmplot(0,100,0);
%Question 7
vclamp = 0;
amp1=20;
width1 = 0.5;
tempc=30;
hhmplot(0,30,0);
hhsplot(0,30);

