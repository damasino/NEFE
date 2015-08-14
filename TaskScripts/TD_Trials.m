function TD_Trials(subID)

trial_dir='~/Documents/NEFE/Stimuli/TD/Design/';
outfid = strcat('subject', num2str(subID),'TD_trials');
output = fullfile(trial_dir,outfid);

%subId is subject id so that we can save each subjects stimuli
money1=[.50 .75 1.00 1.50 2.00 2.50 3.00 3.50 4.00 4.50 5.00 5.50 ...
    6.00 6.50 7.00 7.50 8.00 8.50 9.00 9.50];
money2=10;
delay1='Today';
delay2=[1 7 15 30 90 180 365];

%create cell array with all possible combos
trials=length(money1)*length(delay2);
ones(1:trials+3)=1;
start(1:2,1:2)=[5.00,30;2.00,7];
start(3:trials+2,1:2)=combvec(money1,delay2)';
start(trials+3,1:2)=[10,1];
startCell=mat2cell(start,ones,[1,1]);

money2Cell=repmat({money2},trials+3,1);
money2nd=cell2mat(money2Cell);

delay1Cell=repmat({delay1},trials+3,1);

k=(money2nd(1:trials+3)./start(1:trials+3,1)-1)./start(1:trials+3,2);
k2=mat2cell(k,ones,1);

all=[startCell(1:trials+3,1) delay1Cell money2Cell startCell(1:trials+3,2) k2];

%randomize trial order
randomize=randperm(trials+3);
for i=1:trials+1
    TDtrials(i+2,1:5)=all(randomize(i+2),1:5);
end
TDtrials(1,1:5)=all(1,1:5);
TDtrials(2,1:5)=all(2,1:5);
% %output stim file with subject id as identifier
save(output, 'TDtrials')