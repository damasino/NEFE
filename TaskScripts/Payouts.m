function Payouts(subID)
%subject is string for TD, session is 1
%subID is number for impulse

outdir=strcat('C:\Users\dra12\Documents\NEFE\Data\Behavioral\', num2str(subID));
TD_outdir=strcat(outdir, '\TD_',num2str(subID),'.mat');
load(TD_outdir ,'data') ;

numtrials=data.trial(end);
randtrial=randperm(numtrials);
trial=randtrial(1);
resp=data.resp(trial);
if resp==1;
    money=data.money1{trial};
    delay=data.delay1{trial};
elseif resp==2;
    money=data.money2{trial};
    delay=data.delay2{trial};
end
trial=num2str(trial);

outfid1 = 'TDpayout.txt';
output1 = fullfile(outdir,outfid1);
fileID1 = fopen(output1,'w');
fprintf(fileID1,['We randomly selected trial %s on which you chose a delay of %s' ... 
    '\n and payout of %s \n \n \n'] , trial, delay, money);
fclose(fileID1);
%save(output,'trial','resp','money','delay')

%Impulse or BDM

if rand()>.5
    task='impulse purchase task';
    Impulse_outdir=strcat(outdir,'\Impulse_',num2str(subID),'.mat');
    load(Impulse_outdir ,'data') ;
    
    numtrials=data.trial(end);
    randtrial=randperm(numtrials);
    trial=randtrial(1); 
    
    ImpResp=data.resp{1,trial}(end);
    if ImpResp==1;
        resp=data.resp1;
    elseif ImpResp==2;
        resp=data.resp2;
    elseif ImpResp==3;
        resp=data.resp3;
    elseif ImpResp==5;
        resp=lose;
    end
   
    currprice=data.currentPrice{1,trial};
    item=data.item{1,trial};
    
    if strcmp(resp,'/Checkout')
        giftcard=20-currprice;
        buy='the';
    else
        giftcard=20;
        buy='no';
    end
else
    task='BDM auction task';
    BDM_outdir=strcat(outdir,'\BDM_',num2str(subID),'.mat');
    load(BDM_outdir ,'data') ;
    
    numtrials=data.trial(end);
    randtrial=randperm(numtrials);
    trial=randtrial(1); 

    BDM_price=str2num(data.WTP{trial});
    item=data.item{1,trial};
    currprice=rand()*20;
    resp=strcat('bid $',num2str(BDM_price),' for ');
    if currprice>BDM_price
        giftcard=20;
        buy='no';
    else
        giftcard=20-currprice;
        buy='the';
    end
end
outfid = 'ImpulsePayout.txt';
output = fullfile(outdir,outfid);
fileID = fopen(output,'w');
fprintf(fileID,['We randomly selected %s and trial %d on which you chose \n' ... 
    'to %s the %s, at a price of $%.2f. \n You will get a $%.2f ' ...
    'Amazon gift card and %s item.'] ,task,trial, resp, item, currprice,giftcard,buy);
fclose(fileID);

%save(output,'task','trial','resp','item','currprice','giftcard','buy')

