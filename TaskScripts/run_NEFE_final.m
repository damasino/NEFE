function runAll()
% This runs the NEFE decision making experiment
    %ask for subID and condition
    subID = input('Enter Subject-ID: ', 's');
    condition = input('Enter condition: ');
    
       % Turn annoying warning messages off
    warning off
    
    % Set experiment parameters
    [params,dev,stim] = setParams(subID,condition);
    
    %create trials for all tasks
    TD_Trials(subID)
    SampleImpulseTrials(subID,50)
    BDM_trials(subID)
    
     rand('state', sum(100*clock));	
%     
     if rand()>.5
         params.phase='TDFirst';
         showInstructions(params,dev,'TD');
         TD_task(params,stim,dev,subID,condition); 
         pause(params,dev);
         showInstructions(params,dev,'Impulse');
         Impulse_task(params,stim,dev,subID,condition)
         pause(params,dev);
         showInstructions(params,dev,'BDM');
         BDM_task(params,dev,stim,subID,condition);  
     else
        params.phase='ImpulseFirst';
        showInstructions(params,dev,'Impulse');
        Impulse_task(params,stim,dev,subID,condition)
        pause(params,dev);
        showInstructions(params,dev,'BDM');
        BDM_task(params,dev,stim,subID,condition); 
        pause(params,dev);
        showInstructions(params,dev,'TD');
        TD_task(params,stim,dev,subID,condition);  
      end
    
    %Assign Payment
    Payouts(subID);
    
    % end of experiment routine
    ptbcleanup();
    fclose('all');
    
end

%Parameter function
function [params,dev,stim] = setParams(subID,condition)

rand('state', sum(100*clock));	
% Timing parameters
% ------------------
    params.timing.fix 		= .5;		% duration of fixation cross in s		
    params.timing.choice	= 10.0;		% maximum duration of choice phase in s
    params.timing.shortRem  = .5;       % Cue display
    params.timing.longRem   = 2.5;      % Longer cue display
    params.timing.feedback 	= 1;		% duration of feedback frame in s
    params.scenario = 1;                % scenario initialized to 0 to display practice stimuli

% ---------------------
    params.view.viewdist = 65; 			% 65 cm = 25.6 inches; Tobii best viewing distance
    params.view.scrdiag  = 43; 			% 43 cm for an 17-inch monitor; 34 cm for 13.3-inch
    params.scrid = max(Screen('Screens')); % maximum screen number usually refers to external display (if one is connected)

% Colors
% -------
    dev.white 	= WhiteIndex(params.scrid); % dev = device variables
    dev.black 	= BlackIndex(params.scrid);
    dev.green 	= [0 153 0];
    dev.red 	= [255 0 0];
    dev.blue	= [85 141 213];    
    
% Appearance
% ---------------------
    params.fix_color     = dev.white;	% fixation cross color = white
    params.fix_stroke    = 4;   		% fixation cross stroke thickness in pixel
    params.fix_visang    = 0.5;
    params.fix_textSize  = 50;
    % half width of fixation cross (in visual angle degrees)
    params.font 		 = 'Arial';	% used font throughout the experiment
    params.textcolor 	 = dev.white;
    params.bgcolor1= dev.black;	% background color used during choice phase

    params.trialtextsize = 40;			% stimulus text size
    params.instrtextsize = 24;			% instruction text size
    
% Buttons
% ---------------------
    KbName('UnifyKeyNames'); % make keyboard mapping the same on all PTB-supported operating systems (OSX, Windows, Linux)

    dev.keyF  = KbName('F');
    dev.keyJ  = KbName('J');
    dev.space = KbName('space');
    dev.keyR  = KbName('R');
    dev.keyQ  = KbName('Q');
    if isequal(computer, 'MACI64') || isequal (computer, 'MACI')
        dev.esc = KbName('escape');
    else
        dev.esc = KbName('ESCAPE');
    end
    dev.keys = [dev.keyF, dev.keyJ dev.space dev.esc dev.keyR, dev.keyQ];
  
% Instructions images 
% --------------------- 
%params.instrDirImp='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\';
params.instrDirImp='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\';
    params.instrImp = cell(8,1);
    params.instrImp{1,1} = 'instr1';
    params.instrImp{2,1} = 'instr2';
    params.instrImp{3,1} = 'instr3';
    params.instrImp{4,1} = 'instr4';
    params.instrImp{5,1} = 'instr5';
    params.instrImp{6,1} = 'instr6';
    params.instrImp{7,1} = 'instr7';
    params.instrImp{8,1} = 'instr8';
 %params.instrDirBDM='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\BDM\';
 params.instrDirBDM='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\BDM\';
 if condition==1;
    params.instrBDM = cell(5,1);
    params.instrBDM{1,1} = 'instr1';
    params.instrBDM{2,1} = 'instr2';
    params.instrBDM{3,1} = 'instr3';
    params.instrBDM{4,1} = 'instr4';
    params.instrBDM{5,1} = 'instr5neut';
 elseif condition==2;
      %neutral instructions
    params.instrBDM=cell(5,1);
    params.instrBDM{1,1} = 'instr1';
    params.instrBDM{2,1} = 'instr2';
    params.instrBDM{3,1} = 'instr3';
    params.instrBDM{4,1} = 'instr4';
    params.instrBDM{5,1} = 'instr5soc';
 end
%params.instrDirTD='C:\Users\dra12\Documents\NEFE\Stimuli\TD\Design\'; % get info for all files in folder
params.instrDirTD='C:\Users\dra12\Documents\NEFE\Stimuli\TD\Design\'; % get info for all files in folder
if condition==1;
    params.instrTD = cell(5,1);
    params.instrTD{1,1} = 'instr1';
    params.instrTD{2,1} = 'instr2';
    params.instrTD{3,1} = 'instr3';
    params.instrTD{4,1} = 'instr4neut';
    params.instrTD{5,1} = 'instr5';
 elseif condition==2;
      %neutral instructions
    params.instrTD=cell(5,1);
    params.instrTD{1,1} = 'instr1';
    params.instrTD{2,1} = 'instr2';
    params.instrTD{3,1} = 'instr3';
    params.instrTD{4,1} = 'instr4soc';
    params.instrTD{5,1} = 'instr5';
 end
%      
   %other files and stuff
   stim.datadir='C:\Users\dra12\Documents\NEFE\Data\Behavioral'; 
   %TD
    stim.TDdir='C:\Users\dra12\Documents\NEFE\Stimuli\TD\Design\';
    stim.TDtrialFile=strcat(stim.TDdir,'subject', num2str(subID),'TD_trials');
    
%     %other files and stuff
%    stim.datadir='G:\HuettelLab\Dianna\NEFE\NEFE\Data\Behavioral'; 
%    %TD
%     stim.TDdir='G:\HuettelLab\Dianna\NEFE\NEFE\Stimuli\TD\Design\';
%     stim.TDtrialFile=strcat(stim.TDdir,'subject', num2str(subID),'TD_trials');
    
    
    %Impulse & BDM
    stim.ExpDir='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\';
    stim.ImptrialFile=strcat(stim.ExpDir,'subject', num2str(subID),'trials');
    stim.ItemDir='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\Items';
    stim.buttonDir='C:\Users\dra12\Documents\NEFE\Stimuli\Impulse\Design\Buttons';
    stim.BDMtrialFile=strcat(stim.ExpDir,'subject', num2str(subID),'BDM_trials');
%     %Impulse & BDM
%     stim.ExpDir='G:\HuettelLab\Dianna\NEFE\NEFE\Stimuli\Impulse\Design\';
%     stim.ImptrialFile=strcat(stim.ExpDir,'subject', num2str(subID),'trials');
%     stim.ItemDir='G:\HuettelLab\Dianna\NEFE\NEFE\Stimuli\Impulse\Design\Items';
%     stim.buttonDir='G:\HuettelLab\Dianna\NEFE\NEFE\Stimuli\Impulse\Design\Buttons';
%     stim.BDMtrialFile=strcat(stim.ExpDir,'subject', num2str(subID),'BDM_trials');
    
    if condition ==1
    stim.reminder='\neutral2';
    stim.rem_text=['Remember to think about your financial situation and \n\n'...
            'goals before making your decision.'];
    elseif condition == 2
    stim.reminder='\social4';
    stim.rem_text=['Remember to think about what advice your friend would\n\n'...
            'give before making your decision.'];
    end
    
    %make reminder image
    reminderIm=strcat(stim.buttonDir, stim.reminder, '.png');
    stim.reminderImg=imread(reminderIm,'png');
    remSize=size(stim.reminderImg);
    stim.reminderDim=remSize*.8;
    
    %Make option images for impulse
    buttons={'/Checkout';'/Update';'/Skip'};
    params.shufflebuttons=randperm(3);
    
    params.btn1=buttons{params.shufflebuttons(1)};
    btn_1=strcat(stim.buttonDir, params.btn1, '.png');
    stim.btn_img1=imread(btn_1,'png');
    stim.btn_Dim1=size(stim.btn_img1)*.3;
    
    params.btn2=buttons{params.shufflebuttons(2)};
    btn_2=strcat(stim.buttonDir, params.btn2, '.png');
    stim.btn_img2=imread(btn_2,'png');
    stim.btn_Dim2=size(stim.btn_img2)*.3;
    
    params.btn3=buttons{params.shufflebuttons(3)};
    btn_3=strcat(stim.buttonDir, params.btn3, '.png');
    stim.btn_img3=imread(btn_3,'png');
    stim.btn_Dim3=size(stim.btn_img3)*.3;  
    
% PTB Screen set up and other set up   
    [params,dev] = runSetup(params,dev);
end

%% Setup function
% =====================
function [params,dev] = runSetup(params,dev)
%[params,data,dev] = runSetup(params,dev)

   Screen('Preference', 'SkipSyncTests', 0); 	% 1 means skip synchronization error !!! remove for actual experiment !!!
    
    % rand seed replaced by rng command
    rand('state', sum(100*clock));	% reseed the random number generator for each experiment 
    % seed the random number generator
    %rng shuffle
    
    % ADDITIONAL SETUP
    % ---------------------
    dev.win = Screen('OpenWindow', params.scrid, params.bgcolor1); 	% open window:
    Screen('TextColor', dev.win, params.textcolor);				% set text color
    Screen('TextFont', dev.win, params.font);					% set font

    [params.scrw, params.scrh] = Screen('WindowSize', dev.win);	% get screen dimensions
    params.centerx = params.scrw / 2;							% calculate coordinates of screen center
    params.centery = params.scrh / 2;

    % pixel to degree conversion (courtesy of Dr Youngbin Kwak):
    params.aspect = params.scrw / params.scrh;
    params.pixperunitx = params.scrw / (params.view.scrdiag * sin(atan(params.aspect)));
    params.pixperunity = params.scrh / (params.view.scrdiag * cos(atan(params.aspect)));
    if abs(params.pixperunitx - params.pixperunity) > 5
        warning('PsychToolbox:aspectratio','Pixels per unit different for width and height.');
    end
    params.pixperunit = mean([params.pixperunitx params.pixperunity]);
    params.pixperdeg  = params.pixperunit * params.view.viewdist * tan(deg2rad(1));

    Screen('TextStyle', dev.win, 0); %set font style to normal (0), not bold (1)

    %ListenChar(2);		% disables keyboard output to MATLAB
    HideCursor;			% hides cursor

    %params.stimpos = stimpos1x2(params); % set stimulus positions to 1x2 grid using nested function
end

%% Instructions Function
function showInstructions(params,dev,task) 
    
    % set KbCheck and Text parameters
    RestrictKeysForKbCheck(horzcat(dev.keys(3)));
    %Screen('TextSize', dev.win, params.instrtextsize);
    
        if strcmp(task,'TD')
            for j = 1:size(params.instrTD(),1);
            instr=strcat(params.instrDirTD,params.instrTD{j,1},'.jpg');     
            instr_img=imread(instr,'jpg');
            instrScreen=Screen('MakeTexture', dev.win,instr_img);
            Screen('DrawTexture', dev.win, instrScreen);
            Screen('Flip', dev.win);
            WaitSecs(0.5); % to prevent stuck keys and skipping of instruction screens
            KbWait(-1); 
            end
        elseif strcmp(task,'Impulse')
            for j = 1:size(params.instrImp(),1);
            instr=strcat(params.instrDirImp,params.instrImp{j,1},'.jpg');     
            instr_img=imread(instr,'jpg');
            instrScreen=Screen('MakeTexture', dev.win,instr_img);
            Screen('DrawTexture', dev.win, instrScreen);
            Screen('Flip', dev.win);
            WaitSecs(0.5); % to prevent stuck keys and skipping of instruction screens
            KbWait(-1); 
            end
        elseif strcmp(task,'BDM')
            for j = 1:size(params.instrBDM(),1);
            instr=strcat(params.instrDirBDM,params.instrBDM{j,1},'.jpg');     
            instr_img=imread(instr,'jpg');
            instrScreen=Screen('MakeTexture', dev.win,instr_img);
            Screen('DrawTexture', dev.win, instrScreen);
            Screen('Flip', dev.win);
            WaitSecs(0.5); % to prevent stuck keys and skipping of instruction screens
            KbWait(-1); 
            end
        end
end

%% Display Fixation function
% =====================
function vbl = displayFixation(dev, params)
	% Display fixation cross on the center of the screen 
    Screen('TextSize', dev.win, params.fix_textSize);%params.fix_textSize
    DrawFormattedText(dev.win, '+', 'center', 'center', dev.white);
	vbl = Screen('Flip', dev.win);
    WaitSecs(params.timing.fix + unifrnd(0,1));
end % displayFixation

%Reminder function
function displayReminder(dev,params,stim,trials)
        Screen('TextSize', dev.win, params.instrtextsize);
        remImage=Screen('MakeTexture', dev.win, stim.reminderImg);
        Screen('DrawTexture', dev.win, remImage, [], [(params.centerx-stim.reminderDim(2)/2) (params.centery-100-stim.reminderDim(1))  (params.centerx+stim.reminderDim(2)/2) (params.centery-100)]);
        a=factor(trials+2);  
        if any(5==a) || trials==1 || trials==2;
            DrawFormattedText(dev.win,stim.rem_text,'center','center',dev.white);
            Screen('Flip',dev.win);
            WaitSecs(params.timing.longRem);
        else
            Screen('Flip',dev.win);
            WaitSecs(params.timing.shortRem);
        end
end

%Run TD_task experiment
function TD_task(params,stim,dev,subID,condition) 

subdir = fullfile(stim.datadir,subID);
outfid = strcat('TD_',num2str(subID),'.mat');
output = fullfile(subdir,outfid);

% Create backup if data file already exists
if exist(output) == 2;
	str = dir(output);
    str = str.date;
    str = regexprep(str,'-','');
    str = regexprep(str,':','');
    str = regexprep(str,' ','');
    
	backup = strcat(output(1:end-4),'_',str,'.mat');
	movefile(output,backup,'f');
end
mkdir(subdir);

% Select Trial Schedule
load(stim.TDtrialFile,'TDtrials');
    
try   
    %set up frames for choice feedback
    %should probs do this in a more flexible way
    Dec_Frame=[0 0 350 700];
    Left_Frame=CenterRectOnPoint(Dec_Frame, params.centerx-400, params.centery+25);
    Right_Frame=CenterRectOnPoint(Dec_Frame, params.centerx+400, params.centery+25);
    
    for c=1:2
        if c==1;
            RestrictKeysForKbCheck(horzcat(dev.keys(1:4)));            
            x=1;
            y=2;
            taskStart=0;
        else
            RestrictKeysForKbCheck(horzcat(dev.keys(6)));
            Screen('TextSize', dev.win, params.instrtextsize);
            pretask=['This experiment takes about 15 minutes to complete\n\n'...
                'with a break in the middle. \n\n\n\n\n\n'...
             'Do you have any questions before beginning the experiment?\n\n\n\n\n\n'...
             'When you are ready to begin, press "Q."'];
            DrawFormattedText(dev.win, pretask, 'center', 'center', dev.white);
            Screen('Flip', dev.win,[]);
            KbWait([], 2);
            taskStart=GetSecs;            
            RestrictKeysForKbCheck(horzcat(dev.keys(1:4)));
            Screen('TextSize', dev.win,params.trialtextsize);
            x=3;
            y=length(TDtrials);
        end    
    pauseTime=0;
    endPause=0;
    %start trials loop
    for trials =x:y
        trialStart=GetSecs;       
        
        if trials>3 && trials==round(y/2);
            pauseTime=GetSecs;
            pause(params,dev);
            endPause=GetSecs;
        end
        
        fixStart=GetSecs-trialStart;
        displayFixation(dev, params);
        remStart=GetSecs-trialStart;
        displayReminder(dev,params,stim,trials);
        
        Screen('TextSize', dev.win,params.trialtextsize);       
        money1 = ['$' num2str(TDtrials{trials,(1)},'%5.2f')];
        TextWidth1=Screen(dev.win,'TextBounds', money1);
        
        money2 = ['$' num2str(TDtrials{trials,(3)},'%5.2f')];
        TextWidth2=Screen(dev.win,'TextBounds', money2);

        delay1 = TDtrials{trials,(2)};
        TextWidth3=Screen(dev.win,'TextBounds', delay1);

        predelay2=TDtrials{trials,(4)};
        if predelay2==1;
            delay2=[num2str(predelay2),' day'];
        else
            delay2 = [num2str(predelay2), ' days'];
        end
        TextWidth4=Screen(dev.win,'TextBounds', delay2);
        
        %randomly present immediate/delay on different sides of screen.
        %immediate is on the left when flipped/side=0 and the reverse is
        %true when side/flipped=1.
        if rand() > .5;		
            flipped = 0;
            money1x=[params.centerx-400-(TextWidth1(3)/2)];
            money2x=[params.centerx+400-(TextWidth2(3)/2)];
            delay1x=[params.centerx-400-(TextWidth3(3)/2)];
            delay2x=[params.centerx+400-(TextWidth4(3)/2)];
        else
            flipped = 1;
            money1x=[params.centerx+400-(TextWidth1(3)/2)];
            money2x=[params.centerx-400-(TextWidth2(3)/2)];  
            delay1x=[params.centerx+400-(TextWidth3(3)/2)];
            delay2x=[params.centerx-400-(TextWidth4(3)/2)];  
        end

        DrawFormattedText(dev.win,money1,money1x,(params.centery-300),dev.white);
        DrawFormattedText(dev.win,money2,money2x,(params.centery-300),dev.white);
        DrawFormattedText(dev.win,delay1,delay1x,(params.centery+300),dev.white);
        DrawFormattedText(dev.win,delay2,delay2x,(params.centery+300),dev.white);
        
        Screen('FrameRect',dev.win,dev.white,Left_Frame,3);
        Screen('FrameRect',dev.win,dev.white,Right_Frame,3);
        
        %screen flip for expt screen
        Screen('Flip',dev.win,[],1);
        
        RT = 0;
		press = 0;
        StimLimit=10;
        choiceStart=GetSecs;
        
        while press==0 && (GetSecs-choiceStart) < StimLimit;
	
	        [z,b,c] = KbCheck;
	
	        if     (find(c)==dev.keyF); press = 1; RT = GetSecs-choiceStart;                
            elseif (find(c)==dev.keyJ); press = 2; RT = GetSecs-choiceStart;            
            elseif (find(c)==dev.esc);  press = 9;
                ptbcleanup()
	            %Screen('CloseAll')
	            return
            end
        end 
        
        if press == 1;
            Screen('FrameRect',dev.win,dev.blue,Left_Frame,3);
            choice=1;
            if flipped==1;
                choice=2;
            end
		elseif press == 2;
			Screen('FrameRect',dev.win,dev.blue,Right_Frame,3);
            choice=2;
            if flipped==1;
                choice=1;
            end
        end
        
		Screen('Flip',dev.win);   
        WaitSecs(params.timing.feedback); 
        trialEnd=GetSecs;
        
        % Organize Behavioral Data
		data.subject		= subID;
        data.condition      = condition;
		data.taskStart		= taskStart;
		data.trial(trials) 	= trials;
        data.trialStart(trials) = trialStart;
		data.fixTime(trials)    = fixStart;
        data.remTime(trials)    = remStart;
        data.choiceTime(trials) = choiceStart;
        data.endTime(trials)= trialEnd;
        data.pauseStart     = pauseTime;
        data.pauseEnd       = endPause;
		data.money1{trials}	= money1;
		data.money2{trials}	= money2;
		data.delay1{trials} = delay1; 
		data.delay2{trials} = delay2;
		data.resp(trials) 	= choice;
        data.side(trials)   = flipped;
		data.RT(trials)     = RT;
		data.k{trials} 	    = TDtrials{trials,(5)};

        save(output,'data')
    end
    end
	allfid = strcat('TD_',num2str(subID),'_ALL.mat');
	alloutput = fullfile(subdir,allfid);
	save(alloutput)
    
    Screen('TextSize', dev.win, params.instrtextsize);
    DrawFormattedText(dev.win,'Thank you for your participation!', 'center', 'center');
    Screen('Flip',dev.win);
    WaitSecs(2);
catch
    % This section is executed only in case an error happens in the
    % experiment code implemented between try and catch...
    ShowCursor;
    Screen('CloseAll'); %or sca
    %output the error message
    psychrethrow(psychlasterror);
    
end % try ... catch %
end

%Run Impulse_task experiment
function Impulse_task(params,stim,dev,subID,condition)

    Screen('TextSize', dev.win, params.instrtextsize);
   
    subdir = fullfile(stim.datadir,num2str(subID));
    outfid = strcat('Impulse_',num2str(subID),'.mat');
    output = fullfile(subdir,outfid);

    if exist(output) == 2;
        str = dir(output);
        str = str.date; 
        str = regexprep(str,'-','');
        str = regexprep(str,':','');
        str = regexprep(str,' ','');

        backup = strcat(output(1:end-4),'_',str,'.mat');
        movefile(output,backup,'f');
    end
    mkdir(subdir);

    load(stim.ImptrialFile,'allNew');
    
    try
    %set up frames for choice feedback
    %should probs do this in a more flexible way
    Button_Frame=[0 0 120 80];
    Frame1=CenterRectOnPoint(Button_Frame, params.centerx-400, params.centery+430);
    Frame2=CenterRectOnPoint(Button_Frame, params.centerx, params.centery+430);
    Frame3=CenterRectOnPoint(Button_Frame, params.centerx+400, params.centery+430);
    
    %button images
     posName1=Screen('MakeTexture', dev.win, stim.btn_img1);
     posName2=Screen('MakeTexture', dev.win, stim.btn_img2);
     posName3=Screen('MakeTexture', dev.win, stim.btn_img3);
    fprintf('Put stickers on the keyboard.')
       Text1 = ['You will make your decisions using key presses:\n\n\n\n'...
        'F = \n\n\n\n space bar = \n\n\n\n J = ' ...
        '\n\n\n\n\n\n The experimenter will place reminder stickers on these keys.\n\n'...
        'Then, position your hands comfortably on these keys. \n\n\n\n '...
        'Press the spacebar to start key practice.'];
    DrawFormattedText(dev.win, Text1,'center', 'center', [255 255 255]);
    Screen('DrawTexture', dev.win, posName1, [], [params.centerx+100 (params.centery-220)  (params.centerx+100+stim.btn_Dim1(2)) (params.centery-220+stim.btn_Dim1(1))]);
    Screen('DrawTexture', dev.win, posName2, [], [params.centerx+100 (params.centery-120) (params.centerx+100+stim.btn_Dim2(2)) (params.centery-120+stim.btn_Dim1(1))]);
    Screen('DrawTexture', dev.win, posName3, [], [params.centerx+100 (params.centery-20) (params.centerx+100+stim.btn_Dim3(2)) (params.centery-20+stim.btn_Dim1(1))]);
    Screen('Flip', dev.win,[]);
    KbWait([], 2);
    
    buttonprac=['During the experiment, we ask that you look at the screen \n\n'...
        'and not at your hands, so that we can track where you''re looking.\n\n\n\n'...
        'Now you will practice pressing keys. If you press the correct key, \n\n'... 
        'it will be highlighted and a new key will appear (it may be the same key).\n\n\n\n'...
        'If you feel ready to move on at any point during the practice, \n\n'...
        'you can press "R." \n\n\n\n\n\n Press the spacebar to continue.'];
    DrawFormattedText(dev.win, buttonprac, 'center', 'center', [255 255 255]);
    Screen('Flip', dev.win,[]);
    KbWait([], 2); 
   
   %Practice buttons
   RestrictKeysForKbCheck(horzcat(dev.keys(1:5)));
   start=GetSecs;
   time=60;
    while time>GetSecs-start;
        press = 0;
        
        Screen('DrawTexture', dev.win, posName1, [], [(params.centerx-400-stim.btn_Dim1(2)/2) (params.centery+400)  (params.centerx-400+stim.btn_Dim1(2)/2) (params.centery+400+stim.btn_Dim1(1))]);
        Screen('DrawTexture', dev.win, posName2, [], [(params.centerx-stim.btn_Dim2(2)/2) (params.centery+400) (params.centerx+stim.btn_Dim2(2)/2) (params.centery+400+stim.btn_Dim1(1))]);
        Screen('DrawTexture', dev.win, posName3, [], [(params.centerx+400-stim.btn_Dim3(2)/2) (params.centery+400) (params.centerx+400+stim.btn_Dim3(2)/2) (params.centery+400+stim.btn_Dim1(1))]);
        
        button=randi([1 3]);
        text=['Press button: '];
        texta=['Press "R" when you are ready to end the practice.'];
        if button==1;
            ptr=posName1;
        elseif button==2;
            ptr=posName2;
        elseif button==3;
            ptr=posName3;
        end
        DrawFormattedText(dev.win, text,params.centerx-100, params.centery-300, [255 255 255]);
        DrawFormattedText(dev.win, texta,'center', params.centery-400, [255 255 255]);
        
        Screen('DrawTexture', dev.win, ptr, [], [params.centerx+100 (params.centery-300)  (params.centerx+100+stim.btn_Dim1(2)) (params.centery-300+stim.btn_Dim1(1))]);
        Screen('Flip', dev.win,[],1);
       while press==0;
        [z,b,c] = KbCheck;
            if     (find(c)==dev.keyF) & button==1; press = 1;
                Screen('FrameRect',dev.win,dev.blue,Frame1,3);
            elseif (find(c)==dev.space)& button==2; press = 2;
                Screen('FrameRect',dev.win,dev.blue,Frame2,3);
            elseif (find(c)==dev.keyJ)& button==3; press = 3; 
                Screen('FrameRect',dev.win,dev.blue,Frame3,3);
	        elseif (find(c)==dev.keyR); press = 5;
                break
            end	
       end
       if press==5;
           Screen('Flip', dev.win,[]);
           break
       end
       Screen('Flip', dev.win,[]);
       WaitSecs(1); 
    end
    
    RestrictKeysForKbCheck(horzcat(dev.keys(3)));
   %instructions about cue reminder
    instrRem=strcat(params.instrDirBDM,params.instrBDM{5,1},'.jpg');     
    instrRem_img=imread(instrRem,'jpg');
    instrScreen=Screen('MakeTexture', dev.win,instrRem_img);
    Screen('DrawTexture', dev.win, instrScreen);
    Screen('Flip', dev.win,[]);
    KbWait([], 2);
    
    trialprac=['Now you will practice with 2 sample items. \n\n\n\n'...
        'You may want to experiment with pressing "update" a few times \n\n'...
        'so that you understand how it works before pressing "checkout" or "skip."\n\n'...
        'You may also want to wait and see that the price updates every 5 seconds.'...
        '\n\n\n\n\n\n Press the spacebar continue.'];
    DrawFormattedText(dev.win, trialprac, 'center', 'center', [255 255 255]);
    Screen('Flip', dev.win,[]);
    KbWait([], 2);
    
    for c=1:2
        if c==1;
            x=1;
            y=2;
             
            RestrictKeysForKbCheck(horzcat(dev.keys(1:4)));
            taskStart=0;
        else
            pretask=['This experiment takes about 10 minutes to complete. \n\n\n\n\n\n'...'
                'Do you have any questions before beginning the experiment?\n\n\n\n\n\n'...
                'When you are ready to begin, press "Q."'];
            DrawFormattedText(dev.win, pretask, 'center', 'center', [255 255 255]);
            RestrictKeysForKbCheck(dev.keyQ);
            Screen('Flip', dev.win,[]);
            KbWait([], 2);
            RestrictKeysForKbCheck(horzcat(dev.keys(1:4)));
            taskStart=GetSecs;
            x=3;
            y=length(allNew);
        end
    
    %start trials loop
    for trials =x:y
        trialStart=GetSecs;
        presses=[];
        RTs=[];
         
        %n keeps track of number of times wait has been pressed
        n=1;

        %Extract original price for item
        monOffer=allNew{trials,(2)};
        price=str2num(monOffer);
        price1=num2str(price,'%.2f');
        monOpt=['$ ' price1];
        
        %Extract review of item (util or social, randomly)
        review=allNew{trials,(4)}; 
        
        %get name of item
        name=allNew{trials,(5)};
        
         %make item image
        val_item=strcat(stim.ItemDir, allNew{trials,(1)}, '.jpg');
        valImg1=imread(val_item,'jpg');
        valDim1=size(valImg1)*.7;
        
        fixStart=GetSecs-trialStart;
        displayFixation(dev, params);
        remStart=GetSecs-trialStart;
        displayReminder(dev,params,stim,trials);
        
        %Go back up here if wait is pressed
        trial='going';
        while strcmp(trial,'going')==1;
        
        %Extract current price for item
        offerPath=allNew{trials,(3)};
        newPrice=str2num(offerPath);
        
        %go to next trial if run out of prices    
         if numel(newPrice)<n;
             press=5;
             RT=5;
             presses(n) = press;
             trial='not';
             break
         end
        %add in probability of going to next item
       if n>2;
           %probability starts at 1/32 and increases. 16 is avg.
            randgen=(34-n)*rand();
            %randgen
             if randgen<1;
           %if rand()<.1;  
                press=5;
                RT=5;
                presses(n) = press;
                trial='not';
                break
            end
       end
       %new price det.
        newOffer=newPrice(n);
        newPrice1=num2str(newOffer,'%.2f');
        newOpt=['Current Price: $ ' newPrice1];
        
        %Calculate % discount
        perc=((price-newOffer)/price)*100;
        PercDisc=num2str(perc,'%.f');
        PercDiscount=['Discount: ' PercDisc '% off'];

        %Item screen
        valName1=Screen('MakeTexture', dev.win, valImg1);
        Screen('DrawTexture', dev.win, valName1, [], [(params.centerx-.5*valDim1(2)) (params.centery-100-.5*valDim1(1))  (params.centerx+.5*valDim1(2)) (params.centery-100+ .5*valDim1(1))]);
        %posName1=Screen('MakeTexture', dev.win, btn_img1);
        Screen('DrawTexture', dev.win, posName1, [], [(params.centerx-400-stim.btn_Dim1(2)/2) (params.centery+400)  (params.centerx-400+stim.btn_Dim1(2)/2) (params.centery+400+stim.btn_Dim1(1))]);
        %posName2=Screen('MakeTexture', dev.win, btn_img2);
        Screen('DrawTexture', dev.win, posName2, [], [(params.centerx-stim.btn_Dim2(2)/2) (params.centery+400) (params.centerx+stim.btn_Dim2(2)/2) (params.centery+400+stim.btn_Dim1(1))]);
        %posName3=Screen('MakeTexture', dev.win, btn_img3);
        Screen('DrawTexture', dev.win, posName3, [], [(params.centerx+400-stim.btn_Dim3(2)/2) (params.centery+400) (params.centerx+400+stim.btn_Dim3(2)/2) (params.centery+400+stim.btn_Dim1(1))]);
        
        TextWidth=Screen(dev.win,'TextBounds', newOpt);
        TextWidth2=Screen(dev.win,'TextBounds', PercDiscount);
        
        DrawFormattedText(dev.win,newOpt,params.centerx-(TextWidth(3)+TextWidth2(3))/2-200,(params.centery-300),[255 255 255]);
        DrawFormattedText(dev.win,PercDiscount,params.centerx+200-(TextWidth2(3)-TextWidth(3))/2,(params.centery-300),[255 255 255]);
        DrawFormattedText(dev.win,review,'center',(params.centery+200),dev.white,[],[],[],1.5);
        DrawFormattedText(dev.win,monOpt,'center',(params.centery-450),dev.white);
        DrawFormattedText(dev.win,name,'center',(params.centery+70),dev.white); 
        Screen('DrawLine',dev.win,[255 0 0], params.centerx-70, params.centery-430, params.centerx+70, params.centery-430,2);
        Screen('Flip',dev.win,[],1);
        imarray=Screen('GetImage',dev.win);
        imwrite(imarray,'bottle.jpg')
        
       RT = 0;
	   press = 0;
       
       %Choice feedback
       if n==1;
           StimLimit=10;
       else
           StimLimit=5;
       end
       choiceStart = GetSecs;
       while press==0 && (GetSecs-choiceStart) < StimLimit;
        
	        [z,b,c] = KbCheck;
	
            if     (find(c)==dev.keyF); press = 1; RT = GetSecs-choiceStart;
            elseif (find(c)==dev.space); press = 2; RT = GetSecs-choiceStart;
            elseif (find(c)==dev.keyJ); press = 3; RT = GetSecs-choiceStart;
	        elseif (find(c)==dev.esc);  press = 4;
	            Screen('CloseAll')
	            return
            else RT=5;
            end	
            presses(n) 	= press;
            RTs(n) 	= RT;
       end
       
       if press == 0;
           RT=5;
           n=n+1;
           trial='going';
       elseif press == 1;           
            if strcmp(params.btn1,'/Update')==1;
                n=n+1;
                trial='going';
            else
                trial='not';
            end
            %Frame feedback of choice
            Screen('FrameRect',dev.win,dev.blue,Frame1,3);
       elseif press == 2;            
            if strcmp(params.btn2,'/Update')==1;
                n=n+1;
                trial='going';
            else
                trial='not';
            end
            Screen('FrameRect',dev.win,dev.blue,Frame2,3);
       elseif press == 3;            
            if strcmp(params.btn3,'/Update')==1;
                n=n+1;
                trial='going';
            else
                trial='not';
            end
            Screen('FrameRect',dev.win,dev.blue,Frame3,3);
       end
        Screen('Flip',dev.win);
        WaitSecs(1); 
        feedbackEnd=GetSecs-choiceStart-RT;
    end        
        trialEnd=GetSecs-trialStart;

        % Organize Behavioral Data
		data.subject		= subID;
        data.condition      = condition;
		data.start			= taskStart;
		data.trial(trials) 	= trials;
        data.trialStart(trials) = trialStart;
        data.fixStart(trials) = fixStart;
        data.remStart(trials) = remStart;
        data.StimTime{trials} = choiceStart;
		data.feedbackEnd{trials} = feedbackEnd;
        data.trialEnd(trials) = trialEnd;
        data.price(trials)  = price;
        data.item{trials}   = name;
        data.review{trials} = review;
        data.monPath{trials}= offerPath;
        data.currentPrice{trials} = newOffer;
		data.resp{trials} 	= presses;
		data.RT{trials} 	= RTs;
        data.resp1          = params.btn1;
        data.resp2          = params.btn2;
        data.resp3          = params.btn3;
    
        save(output,'data');
    end %of trials loop 
    end
    
	allfid = strcat('Impulse_',num2str(subID),'_ALL.mat');
	alloutput = fullfile(subdir,allfid);
	save(alloutput);
    
    DrawFormattedText(dev.win,'Thank you for your participation!', 'center', 'center');
    Screen('Flip',dev.win);
    WaitSecs(2);
    catch
    % This section is executed only in case an error happens in the
    % experiment code implemented between try and catch...
    ShowCursor;
    Screen('CloseAll'); %or sca
    %output the error message
    psychrethrow(psychlasterror);
    
    end % try ... catch %
end

%Run BDM_task experiment
function BDM_task(params,dev,stim,subID,condition)

Screen('TextSize', dev.win, params.instrtextsize);

 subdir = fullfile(stim.datadir,num2str(subID));
 outfid = strcat('BDM_',num2str(subID),'.mat');
 output = fullfile(subdir,outfid);

    if exist(output) == 2;
        str = dir(output);
        str = str.date; 
        str = regexprep(str,'-','');
        str = regexprep(str,':','');
        str = regexprep(str,' ','');

        backup = strcat(output(1:end-4),'_',str,'.mat');
        movefile(output,backup,'f');
    end
    mkdir(subdir);

    load(stim.BDMtrialFile,'allItems') ;

try
%slider practice screen
    text4=['You will use a slider to enter the amount you are willing to pay \n\n'...
        'for an item. Move the mouse to change the amount, and click the mouse\n\n'...
        ' to enter the amount and move to the next item.\n\n\n\n\n\n'...
        'You can practice with the slider below:']; 
    text5=['Click the mouse when you are ready to continue'];
    
     %slider
    slack = Screen('GetFlipInterval', dev.win); %/2
    vbl = Screen('Flip', dev.win);

    baseRect = [0 0 10 20];
    LineX = params.centerx+1920;
    %LineX=params.centerx;
    LineY = params.centery+200;
    pixelsPerPress = 1;
    waitframes = 1;
    
    SetMouse(LineX,LineY,dev.win);
    %ShowCursor;
    %while KbCheck; end
    while true
        [ keyIsDown, secs, keyCode ] = KbCheck;
        pressedKeys = find(keyCode);
        [x,y,buttons]=GetMouse(dev.win);
        if pressedKeys == dev.esc;
            return
            Screen('CloseAll')
	                    
        elseif buttons(1)==1;
            StopPixel_M = ((LineX - params.centerx) + 500)/5;
            finalWTP=WTP;
            break;
            Screen('Flip', dev.win);
        end

        LineX = x;

        if LineX < (params.centerx-500);
            LineX = (params.centerx-500);
        elseif LineX > (params.centerx+500);
            LineX = (params.centerx+500);
        end

        WTP=num2str((LineX-140)/50,'%.2f');

        DrawFormattedText(dev.win, text4,'center', params.centery-400, dev.white);
        DrawFormattedText(dev.win, text5,'center', params.centery+400, dev.white);
        %text_P = 'How much are you willing to pay for this item?';
        centeredRect = CenterRectOnPointd(baseRect, LineX, LineY);
        %DrawFormattedText(dev.win, text_P ,'center', (params.centery-100), [255 255 255],...
            %[],[],[],5)
        Screen('DrawLine', dev.win, dev.white, (params.centerx+500), (params.centery+200),(params.centerx-500), (params.centery+200), 1);
        Screen('DrawLine', dev.win, dev.white, (params.centerx+500), (params.centery+210),(params.centerx+500), (params.centery+190), 1);
        Screen('DrawLine', dev.win, dev.white, (params.centerx-500), (params.centery+210),(params.centerx-500), (params.centery+190), 1); 
        Screen('DrawText', dev.win,'$0.00', (params.centerx-500), (params.centery+225),dev.white);
        Screen('DrawText', dev.win,'$20.00', (params.centerx+500), (params.centery+225), dev.white);
        Screen('DrawText', dev.win,strcat('$ ', WTP), (params.centerx), (params.centery+250),dev.white);
        Screen('FillRect', dev.win, dev.white, centeredRect);
        vbl = Screen('Flip', dev.win, vbl + (waitframes - 0.5) * slack);
    end
    
     pretask=['This experiment takes about 10 minutes to complete. \n\n\n\n\n\n'...'
             'Do you have any questions before beginning the experiment?\n\n\n\n\n\n'...
             'When you are ready to begin, press "Q."'];
    DrawFormattedText(dev.win, pretask, 'center', 'center', [255 255 255]);
    RestrictKeysForKbCheck(dev.keyQ);
    Screen('Flip', dev.win,[]);
    KbWait([], 2);
    
    RestrictKeysForKbCheck([]);
     
    taskStart=GetSecs;
    
    x=1;
    y=50;
    for trials =x:y
    trialStart=GetSecs;
    %Fixation
    fixStart=GetSecs-trialStart;
    displayFixation(dev, params);   
    %Reminder
    remStart=GetSecs-trialStart;
    displayReminder(dev,params,stim,trials);
  
    %get name of item
    name=allItems{trials,(2)};

     %make item image
    item=allItems{trials,(1)};
    val_item=strcat(stim.ItemDir, item, '.jpg');
    valImg1=imread(val_item,'jpg');
    valSize1=size(valImg1);
    valDim1=valSize1*.7; 
    
    LineY = params.centery+300;
    LineX=params.centerx+1920;
    %LineX=params.centerx;
    
    SetMouse(LineX,LineY,dev.win);
    %ShowCursor;
    text_P = 'How much are you willing to pay for this item?';
    valName1=Screen('MakeTexture',dev.win, valImg1);
         
    while true
        choiceStart=GetSecs-trialStart;
        [ keyIsDown, secs, keyCode ] = KbCheck;
        pressedKeys = find(keyCode);
        [x,y,buttons]=GetMouse(dev.win);
        if pressedKeys == dev.esc;
            sca;
            close all;
        elseif buttons(1)==1;
            RT=GetSecs-choiceStart;
            StopPixel_M = ((LineX - params.centerx) + 500)/5;
            finalWTP=WTP;
            break;
            Screen('Flip', dev.win);
        end

        LineX = x;
        if LineX < (params.centerx-500);
            LineX = (params.centerx-500);
        elseif LineX > (params.centerx+500);
            LineX = (params.centerx+500);
        end

        WTP=num2str((LineX-140)/50,'%.2f');
        Screen('DrawLine', dev.win, dev.white, (params.centerx+500), (params.centery+300), (params.centerx-500), (params.centery+300), 1);
        Screen('DrawLine', dev.win, dev.white, (params.centerx+500), (params.centery+310),(params.centerx+500), (params.centery+290), 1);
        Screen('DrawLine', dev.win, dev.white, (params.centerx-500 ), (params.centery+310),(params.centerx-500), (params.centery+290), 1); 
        Screen('DrawText', dev.win,'$0.00', (params.centerx-500), (params.centery+325),dev.white);
        Screen('DrawText', dev.win,'$20.00', (params.centerx+500), (params.centery+325),dev.white);
        DrawFormattedText(dev.win, text_P ,'center', (params.centery-400), dev.white,[],[],[],5);
        DrawFormattedText(dev.win, name,'center', params.centery+130, dev.white);
        Screen('DrawTexture', dev.win, valName1, [], [(params.centerx-.5*valDim1(2)) (params.centery-100-.5*valDim1(1))  (params.centerx+.5*valDim1(2)) (params.centery-100+ .5*valDim1(1))]);
        
        centeredRect = CenterRectOnPointd(baseRect, LineX, LineY);
       
        Screen('DrawText', dev.win,strcat('$ ', WTP), (params.centerx), (params.centery+350),dev.white);
        Screen('FillRect', dev.win, dev.white, centeredRect);
        
        vbl = Screen('Flip', dev.win, vbl + (waitframes - 0.5) * slack);
    end
    
    data.subject		= subID;
    data.order          = params.phase;
    data.condition      = condition;
    data.start			= taskStart;
    data.trialStart(trials) = trialStart;
    data.fixStart(trials) = fixStart;
    data.remStart(trials) = remStart;
    data.choiceStart(trials) = choiceStart;
    data.RT(trials)     = RT;
    data.trial(trials) 	= trials;
    data.item{trials}   = name;
    data.WTP{trials}    = finalWTP;

    save(output,'data')
    end
    
    allfid = strcat('BDM_',num2str(subID),'_ALL.mat');
	alloutput = fullfile(subdir,allfid);
	save(alloutput)
    
    DrawFormattedText(dev.win,'Thank you for your participation!', 'center', 'center');
    Screen('Flip',dev.win);
    WaitSecs(2);

    %ptbcleanup()

catch
    % This section is executed only in case an error happens in the
    % experiment code implemented between try and catch...
    ShowCursor;
    Screen('CloseAll'); %or sca
    %output the error message
    psychrethrow(psychlasterror);
end
end

function pause(params,dev)
Screen('TextSize', dev.win, params.instrtextsize);
RestrictKeysForKbCheck(horzcat(dev.keys(1:5)));
pauseText=['You can take a short break if you would like now.\n\n'...
        'When you are ready to continue to the next task, press the space bar. \n\n'];
     DrawFormattedText(dev.win, pauseText,'center', 'center', dev.white);
    Screen('Flip', dev.win,[]);
    KbWait([], 2);
end

%% Code to close psychtoolbox stuff cleanly
% ======================================
function ptbcleanup()
    % perform Psychtoolbox Cleanup
	Screen('CloseAll'); 	% close all screens
	ShowCursor;				% show cursor if it was hidden
	Priority(0);			% set priority back to 0
	ListenChar(0);			% enable keyboard output to MATLAB
end