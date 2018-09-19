clc
clear all; close all

%Jeff Sawalha
%This assignment is an experiment where the subject is to select between
%two targets that are displayed on a screen. The goal is the determine
%which target showed up first, then to rate the confidence of your
%selection for each trial. There are 6 trials in this pilot experiment 

% THIS SCRIPT REQUIRES PSYCHTOOLBOX! MUST BE INSTALLED FIRST

%%

Data = repmat(struct('trial',1,'SOA',1, 'Side',0, 'resp',-1, 'confidence', -1),1,40);

count = 0;
for rep = 1:2
for side = 1:2
    for val = 1:10
        count = count+1
        Data(count).Side = side
        if (val <= 3)
            Data(count).SOA = 0
        end
        if (val <= 6 && val > 3)
            Data(count).SOA = 1
        end
        if (val <= 8 && val > 6)
            Data(count).SOA = 2
        end
        if (val <= 10 && val > 8)
            Data(count).SOA = 3
        end
    end
end
end

Dummy=Data;
sequence = randperm(40);
Data = Dummy(sequence);

for i=1:40
	Data(i).trial = i;
end

DataTable=struct2table(Data);




warning off MATLAB:DeprecatedLogicalAPI 
Screen('Preference', 'SkipSyncTests', 1); 

[window,rect] = Screen('OpenWindow', 0  , 255); %open the canvas, call it window, and get the 4 coordinates, and call it rect

WaitSecs(2); %wait to start the trial
while KbCheck end;  %clear keyboard buffer
[keyisDown,keypresstime,keyCode,deltaSecs]=KbCheck; %initialize keyboard

centerx = rect(3)/2; %center x coordinate
centery = rect(4)/2; %center y coordinate
xbox= rect(3)/14 %split the horizantal screen in 14 seperate parts to draw the rectangles for the "rate your confidence part"
xbox= round(xbox) %round xbox
left = KbName('a') %We are getting the Kb number for the letter a since people will either be hitting a or l to choose which target they saw first
right = KbName('l') %this is l, and it will be for the right target
keys = [left; right] %this is a variabled called keys where the left and right buttons will be placed in for the keyboard part of the experiment
a = 0
centerboxy = (rect(4)/2) - (rect(4)/2) * 0.1852 %this will be the horizantal center of the center rectangle for the rate your confidence part 
centerboxy= round(centerboxy)
boxy2 = centerboxy + (rect(4)/2) * 0.2212389 %this will be the center of the vertical center of the rectangle for the rate your confidence part
boxy2 = ceil(boxy2)
box = [0, 0, 274, 400] %This is the size of the box for the rate your confidence part. We will have 7 boxes
counter = 0




recta = [centerx - centerx/2, centery]; %this is the coordinates of the left target that will appear 
recta2 = [centerx + centerx/2, centery]; %this is the coordinates for the right target that will appear

for trials = 1:7   % 6 trials
fin = [recta; recta2]; %fin will place both coordinates in an array
refresh=Screen('GetFlipInterval',window);
slack = refresh/2
counter = counter + 1 

Screen('DrawDots', window, fin(DataTable.Side(counter),:), 80, [0 0 0], [],1) %this draws the target first potentially. fin(choice,:) will be random, so either the left or the right target gets drawn first
Screen('Flip', window, [], 1) %here we flip the first target 
vbl = GetSecs

if DataTable.Side(counter) == 1  %if choice was a 1, then that means the left target was flipped first, therefore, the 2nd target is choice = 2
    other = 2; %other = choice # 2
Screen('DrawDots', window, fin(other,:), 80, [0 0 0], [],1) %this draws the second target
else
    other = 1; %if orginally choice was 2, then other equals 1
    Screen('DrawDots', window, fin(other,:), 80, [0 0 0], [],1) %draws the other target
end

switch DataTable.SOA(counter)

    case 0
        Screen('Flip', window, [], 1) %refresh rate is 50 ms, so we can times 50 ms by 1, 2, 3, or 4. If randi =1, they will appear at the same framerate, if 2, it will be double the frame rates etc..
        WaitSecs(0.5);  %wait one second 
    case 1
        Screen('Flip', window, vbl + 1*refresh-slack, 1) %refresh rate is 50 ms, so we can times 50 ms by 1, 2, 3, or 4. If randi =1, they will appear at the same framerate, if 2, it will be double the frame rates etc..
        WaitSecs(0.5);  %wait one second
    case 2
        Screen('Flip', window, vbl + 2*refresh-slack, 1) %refresh rate is 50 ms, so we can times 50 ms by 1, 2, 3, or 4. If randi =1, they will appear at the same framerate, if 2, it will be double the frame rates etc..
        WaitSecs(0.5);  %wait one second
    case 3
        Screen('Flip', window, vbl + 4*refresh-slack, 1) %refresh rate is 50 ms, so we can times 50 ms by 1, 2, 3, or 4. If randi =1, they will appear at the same framerate, if 2, it will be double the frame rates etc..
        WaitSecs(0.5);  %wait one second
         
end




Screen('TextSize', window, 30); %text size 30
Screen('DrawText', window, 'Left (A) or Right (L)', centerx-300, centery-40 , [0,0,0]) %Text shows up between the two targets asking if it is left or right, if left, press a, if right, press l
Screen('Flip', window, [], 1) %flip the text onto the screen while keeping everything else
while keyCode(keys) == 0 %While the keycodes for keys (a and l {which is kbnumber 65 and 76 for a and l} are 0, keep running this loop. So if the keys a OR l haven't been pressed, keep running this loop
        [keyisDown,keypresstime,keyCode,deltaSecs]=KbCheck;%this will check to see what keys have been pressed during this time. ONLY if a or l have been pressed, the while loop will then stop
end
if keyCode(65) == 1
    DataTable.resp(counter) = 0
elseif keyCode(76) == 1
    DataTable.resp(counter) = 1
end
keyCode(1:end) = zeros; % This resets the keycodes for the next trial so the while loop continues to work


 Screen('FillRect',window,[255,255,255],rect); %after the subject has pressed a or l, we basically clear the screen of everything for 1 second
    Screen('Flip',window,[],1);
    WaitSecs(1);  
    
    centeredRect = CenterRectOnPointd(box, centerx, centery); %this is the rectangle coordinates for the center rectangle. We are making 7 rectangles with the numbers 1:7 in them to display to the subject. This centers the size of [box], making it the middle rectangle
    Screen('FillRect', window, [0,0,0], centeredRect); %This draws the rectanlge in the center, and it will be 274 x 480 size [because of the box command]
    Screen('TextSize', window, 100); %text size 100
    Screen('DrawText', window, '4', centerx-75, centery-115, [255,255,255]) %the center rectangle will have a 4 in it

    Screen('FillRect', window, [0,0,0], [centeredRect(1)-(xbox*2), centeredRect(2), centeredRect(3)-(xbox*2), centeredRect(4)]); %this is the rectangle to the left of the center rectangle, it is 2 [box] sizes over so there will be a space between the 2
    Screen('DrawText', window, '3', (centerx-(xbox*2)-75), centery-115, [255,255,255]) %this is a 3
    
    Screen('FillRect', window, [0,0,0], [centeredRect(1)-(xbox*4), centeredRect(2), centeredRect(3)-(xbox*4), centeredRect(4)]); %rectangle two boxes away from the center, has 4 box sizes between it and the center rectangle
    Screen('DrawText', window, '2', (centerx-(xbox*4)-75), centery-115, [255,255,255]) % 2

    Screen('FillRect', window, [0,0,0], [centeredRect(1)-(xbox*6), centeredRect(2), centeredRect(3)-(xbox*6), centeredRect(4)]);% rectangle 3 boxes away from the center, to the left to the left
    Screen('DrawText', window, '1', (centerx-(xbox*6)-75), centery-115, [255,255,255]) % number 1 on the far left

    Screen('FillRect', window, [0,0,0], [centeredRect(1)+(xbox*2), centeredRect(2), centeredRect(3)+(xbox*2), centeredRect(4)]); %rectangle to the right of the center
    Screen('DrawText', window, '5', (centerx+(xbox*2)-75), centery-115, [255,255,255])   
    
    Screen('FillRect', window, [0,0,0], [centeredRect(1)+(xbox*4), centeredRect(2), centeredRect(3)+(xbox*4), centeredRect(4)]); %rectangle two boxes to the right of the center
    Screen('DrawText', window, '6', (centerx+(xbox*4)-75), centery-115, [255,255,255])
    
    Screen('FillRect', window, [0,0,0], [centeredRect(1)+(xbox*6), centeredRect(2), centeredRect(3)+(xbox*6), centeredRect(4)]); %rectangle with 3 boxes from the center
    Screen('DrawText', window, '7', (centerx+(xbox*6)-75), centery-115, [255,255,255])
    
    Screen('TextSize', window, 15); %this part will make a new text size 15
    Screen('DrawText', window, 'Rate the confidence of your answer (by clicking on the box) where 1 = very confident for left target to 3 = not confident for left target, and 5 = confident on the right target to 7= not confident', rect(1)+150 , rect(4)-100, [0,0,0])
    %the above is instructions on the screen asking the subject to rate the
    %confidence of their selection from 1 to 7 by clicking on one of the 7
    %boxes
    Screen('Flip',window,[],1); %flips the instructions
    SetMouse(centerx, centery) %this centers the mouse
    [x, y, buttons] = GetMouse; %gets mouse coordinates and if the mouse has been pressed
    while buttons(1) == 0 %while the LEFT mouse button as not been pressed, do this while loop
        [x, y, buttons] = GetMouse; %gets the coordinates again
        Screen('TextSize', window, 100); %makes text size 100 again to replace the numbers so they don't disappear when a selection is made. 
        if any(buttons) %if any of the buttons on the mouse are pressed
            if x > centeredRect(1) && x < centeredRect(3) && y > centeredRect(2) && y < centeredRect(4) %IF the button is pressed while the mouse is within the coordinates of ALL and ONLY ALL 7 boxes, then register the press
                Screen('FillRect', window, [0, 255, 0], centeredRect); %this first nested if statement is saying IF the mouse is within the coordinates if the middle rectangle, and there is a mouse button press, then fill the middle box green immediately, and buttons(1) == 1, which will end the while loop
                Screen('DrawText', window, '4', centerx-75, centery-115, [255,255,255])        
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 4
                WaitSecs(3);  
            elseif x > centeredRect(1)-(xbox*2) && x < centeredRect(3)-(xbox*2) && y > centeredRect(2) && y < centeredRect(4) %Or else, if the mouse is within the coordinates of the box to the left of the center, and it is clicked, then fill it in green, and buttons(1) == 1
                Screen('FillRect', window, [0, 255, 0], [centeredRect(1)-(xbox*2), centeredRect(2), centeredRect(3)-(xbox*2),  centeredRect(4)]);
                Screen('DrawText', window, '3', (centerx-(xbox*2)-75), centery-115, [255,255,255])
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 3
                WaitSecs(3);
            elseif x > centeredRect(1)-(xbox*4) && x < centeredRect(3)-(xbox*4) && y > centeredRect(2) && y < centeredRect(4) %coordinates for the box that is 2 boxes away from the center to the left
                Screen('FillRect', window, [0, 255, 0], [centeredRect(1)-(xbox*4), centeredRect(2), centeredRect(3)-(xbox*4), centeredRect(4)]);
                Screen('DrawText', window, '2', (centerx-(xbox*4)-75), centery-115, [255,255,255])
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 2
                WaitSecs(3); 
            elseif x > centeredRect(1)-(xbox*6) && x < centeredRect(3)-(xbox*6) && y > centeredRect(2) && y < centeredRect(4) %3 boxes away from the center to the left
                Screen('FillRect', window, [0, 255, 0], [centeredRect(1)-(xbox*6), centeredRect(2), centeredRect(3)-(xbox*6), centeredRect(4)]);
                Screen('DrawText', window, '1', (centerx-(xbox*6)-75), centery-115, [255,255,255])
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 1
                WaitSecs(3);
            elseif x > centeredRect(1)+(xbox*2) && x < centeredRect(3)+(xbox*2) && y > centeredRect(2) && y < centeredRect(4) %one box away from the center to the right
                Screen('FillRect', window, [0, 255, 0], [centeredRect(1)+(xbox*2), centeredRect(2), centeredRect(3)+(xbox*2), centeredRect(4)]);
                Screen('DrawText', window, '5', (centerx+(xbox*2)-75), centery-115, [255,255,255]) 
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 5
                WaitSecs(3);
            elseif x > centeredRect(1)+(xbox*4) && x < centeredRect(3)+(xbox*4) && y > centeredRect(2) && y < centeredRect(4) %the second box away from the center to the right
                Screen('FillRect', window, [0, 255, 0], [centeredRect(1)+(xbox*4), centeredRect(2), centeredRect(3)+(xbox*4), centeredRect(4)]);
                Screen('DrawText', window, '6', (centerx+(xbox*4)-75), centery-115, [255,255,255])
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 6
                WaitSecs(3);
            elseif x > centeredRect(1)+(xbox*6) && x < centeredRect(3)+(xbox*6) && y > centeredRect(2) && y < centeredRect(4) %the third box away from the center to the right
                Screen('FillRect', window, [0, 255, 0], [centeredRect(1)+(xbox*6), centeredRect(2), centeredRect(3)+(xbox*6), centeredRect(4)]);
                Screen('DrawText', window, '7', (centerx+(xbox*6)-75), centery-115, [255,255,255]) 
                Screen('Flip', window,[],1);
                DataTable.confidence(counter) = 7
                WaitSecs(3);                
            else
             buttons(1:end) = 0 %if the mouse is pressed,, but not within any of the coordinates of the boxes, make buttons 0 again, and the while loop will continue until the mouse is pressed within one of these boxes
            end
      
        end
    end
         
   
 Screen('FillRect',window,[255,255,255],rect); %this will flip a white screen, wiping everything 
    Screen('Flip',window,[],1);
    WaitSecs(0.5);  
    
   
end
 Screen('FillRect',window,[255,255,255],rect); %this says thank you at the end of the entire experiment after the 6 trials
 [finx, finy] = RectCenter(rect)
 bound = Screen('TextBounds', window, 'Thank You!')
 xtext = finx - (bound(3)/2)
 ytext = finy
 Screen('TextSize', window, 100);
 Screen('DrawText', window, 'Thank You!', xtext, ytext, [0,0,0])
    Screen('Flip',window,[],1);
    WaitSecs(1);  
KbWait;
sca; 
 