function BDM_trials(subID,trials)

%subId is subject id so that we can save each subjects stimuli
%trials is number of trials needed

trial_dir='~/Documents/NEFE/Stimuli/Impulse/Design/';
outfid = strcat('subject', num2str(subID),'BDM_trials');
output = fullfile(trial_dir,outfid);

%read in csv file from folder
[~, item, ~, ~, ~, name]=textread('~/Documents/NEFE/NEFE_Items_final.txt','%s%s%s%s%s%s','delimiter','\t','whitespace','');

%randomize money distribution
randomOrd=randperm(length(name));
shuffItem=item(randomOrd);
shuffName=name(randomOrd);

allItems=[shuffItem shuffName];
save(output, 'allItems')
