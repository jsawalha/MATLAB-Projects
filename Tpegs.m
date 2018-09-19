clc
clear all
close all

% INPUT USER FOR T SHAPE SIZE PROJECT
% A user inputs how big and how wide they want their T to be, and we will
% create a black background to which to T falls on that will be roughly 25%
% larger than the T
height = input('How tall (in pixels) do you want your T to be? ','s')
wide=input('T width in pixels? make sure width is smaller than height: ','s');
height = str2num(height) %This converts the strings into actual values
wide = str2num(wide)


bg = height * 1.25; %this bg command is to increase height by 25% so we can make the background
bg = round(bg); %this rounds bg
vert = (bg-height)/2:(bg+height)/2 ; %vert is what we will use to center our T on the verital axis, it needs to be in the middle columns
vert = round([vert]);
interval = wide/2
interval = round(interval)
P = zeros(bg,bg,3); %This creates out black background that is 25% bigger than the height of T

width = height; %Width equal to height 
center = bg/2; %center is what we will use to center our T on the horizantal axis, it needs to be in the middle rows
center = round(center);

%Here, we make our vertical dash for our T. we use 1's to make sure the
%color is white on all 3 dimensions of P.
P( vert, center-interval:center+interval,1) = 1; %we take rows from vert (which is the background size / height * 10) to our background-vert to cover all of our row columns we will be filling in
P( vert, center-interval:center+interval,2) = 1; %Likewise, we take the width of the columns (in the center of the image) to draw our white line
P( vert, center-interval:center+interval,3) = 1; %This is the veritcal part of our T that we created by centering it

%here, we make our horizantal dash for our T, Again, we use ones  through all 3 RGB matrices to make
%sure the color is white

P(vert(1):vert(1)+interval*2, vert,1) = 1; %This is the horizantal part of our T
P(vert(1):vert(1)+interval*2, vert,2) = 1; %We take the rows from vert, by wide, to vert to get our rows for drawing the horizantal part of our T
P(vert(1):vert(1)+interval*2, vert,3) = 1; %Then we take the columns from vert to our background size - our vert again to get our columns for drawing the horizantal part of T




image(P)
axis off
axis equal


if length(1:vert) ~= length(P(end-vert:end)) %Here we ask if the size of black space above the T is equal to below the T
    
    P(end,:,:)=[] %If not, we will delete the bottom row of the matrix to ensure that both sides are equal. If they are uneven, the bottom is ALWAYS greater than the top
    disp('Now there is the same amount of space above and below the T')
end

if length(P(vert,1:vert)) ~= length(P(vert, end-vert:end)) %Here, we ask if the size of the black space to the left of the T is equal to the right
    
    P(:,end,:) = [] %If it is not equal then we delete a column to the right of the T. My code will always ensure that the right side has more columns than the left
    disp('Now there is the same amount of space besides the T')
end

    
    





    
    
    
    



