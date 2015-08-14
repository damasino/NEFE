function SampleImpulseTrials(subID,trials)

%subId is subject id so that we can save each subjects stimuli
%trials is number of trials needed

trial_dir='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\';
outfid = strcat('subject', num2str(subID),'trials');
output = fullfile(trial_dir,outfid);

%read in csv file from folder
[price, item, priceTraj, utilRev, socRev, name]=textread('C:\Users\dra12\Documents\NEFE\NEFE_Items_final.txt','%s%s%s%s%s%s','delimiter','\t','whitespace','');

%pick max price as list price and normalize all prices such that the
%highest is $20
for i=1:trials;
    maximum=max(str2num(priceTraj{i}));
    %if str2num(price{i})>20
    if maximum>20
        priceTraj{i}=num2str(str2num(priceTraj{i})*19.99/maximum);
    end
end
%randomize money distribution
randomOrd=randperm(length(price));
%shuffprice=price(randomOrd);
shufftraj=priceTraj(randomOrd);
priceInfo=[price shufftraj];

%randomize 6 and 7 distribution--but want to preserve half 6's and half 7's
vec(1:trials/2)=1;
vec(trials/2+1:trials)=2;
vec=vec(randperm(trials));

rev=cell(trials,1);
for i=1:trials
    if vec(i)==1;
        rev{i,1}=utilRev{i};
    elseif vec(i)==2;
        rev{i,1}=socRev{i};
    end
end

all=[item priceInfo rev name];

% %randomize everything such that individual rows are preserved
trialRand=randperm(trials);
for i=1:trials
    allNew(i+2,1:5)=all(trialRand(i),1:5);
end
allNew(1:2,1:5)={'/GlassBottle','18','[ 5.10 4.45  6.00 15.00 8.80 7.65  8.08 13.50  2.02  5.00 8.50  6.00  10.99  8.08  4.46 12.67 10.00 12.38  5.25 10.77  5.25  4.04  5.38  4.17  2.62  5.38  4.17  5.38  4.17  5.38  4.17  9.41  5.38 12.12 11.58 14.27  5.38  9.56 20.00  9.56 10.15  9.56 12.59  9.56 13.46  5.38  9.37  5.37  9.10  5.25  7.65 13.46  7.95 13.46  7.95 13.46  7.95  5.25]','It''s very attractive. I am always complimented on \n my stylish glass bottle.','Glass Water Bottle';'/FlowerCanvas','20','[20.00 15.95 12.50 19.95 15.43 20.00 10.00 20.00 15.16 18.99 15.00 13.68 10.94 5.66 20.00 12.55 17.32 12.00 15.86 12.05 13.18 15.50 17.14 19.18 15.50 12.86 16.32 17.18 12.05 14.82 13.73 15.18 16.55 14.09 12.72 14.09 15.36 12.72 13.86 13.09 11.71 13.32 12.45 15.91 12.45 14.64 16.55 18.14 18.64 14.64 16.14 14.64 11.91 14.59 13.64 14.09 14.64 11.95 13.68 11.95 12.77 11.95 14.59 14.09 13.09 14.45 12.91 14.68 13.82 14.68 11.81 16.41 12.72 14.73 16.51 14.69 17.25 14.54 18.14 14.69]','It brightens up the wall and gives a very modern \n artistic look to the room.','Flower Paintings'};

% %output stim file with subject id as identifier
save(output, 'allNew')