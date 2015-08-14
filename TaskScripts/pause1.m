function pause1()
%Make sure the script is running on Psychtoolbox-3:
AssertOpenGL;

% Turn annoying warning messages off
warning off

% Enable unified mode of KbName, so KbName accepts identical key names on
    % all operating systems (not absolutely necessary, but good practice):
    KbName('UnifyKeyNames');

     KbCheck;
    WaitSecs(0.1);
    
    screens=Screen('Screens');
    screenNumber=max(screens);
    
    %open an onscreen Window, and one to mirror on experimenters monitor
    [expWin,rect]=Screen('OpenWindow',screenNumber,[0 0 0]);
    
    % Set priority for script execution to realtime priority:
    priorityLevel=MaxPriority(expWin);
    Priority(priorityLevel);
    
    %get the midpoint (mx, my) of this window, x and y
    [mx, my] = RectCenter(rect);
    
    %Preparing and displaying the welcome screen
    Screen('TextSize', expWin, 24);
    Screen(expWin,'TextFont', 'Arial');
    
    text1a=['You can take a short break if you would like now.\n\n'...
        'When you are ready to continue to the next task, press any key \n\n'];
     DrawFormattedText(expWin, text1a,'center', 'center', [255 255 255]);
    Screen('Flip', expWin,[]);
    KbWait([], 2);
    
    sca
end