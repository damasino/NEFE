function BDM_trials(subID,trials)

% Created on 5/10/2015
% By Dianna Amasino
% This script reads in a csv file of items that people can purchase in the  
% BDM auction portion of NEFE_run_final. It randomizes the order they are
% presented.

%Input: subId (subject id) and trials (# trials)
%Output: "subject(subID#)BDM_trials," a mat file containing the items in randomized order.

%Set file directory in which to put output files
trial_dir='~/Documents/NEFE/Stimuli/Impulse/Design/';
outfid = strcat('subject', num2str(subID),'BDM_trials');
output = fullfile(trial_dir,outfid);

%read in csv file from folder (extract picture file and name of item)
[~, item, ~, ~, ~, name]=textread('~/Documents/NEFE/NEFE_Items_final.txt','%s%s%s%s%s%s','delimiter','\t','whitespace','');

%randomize order of items
randomOrd=randperm(length(name));
shuffItem=item(randomOrd);
shuffName=name(randomOrd);
allItems=[shuffItem shuffName];

save(output, 'allItems')
