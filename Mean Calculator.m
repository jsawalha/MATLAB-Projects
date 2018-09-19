%This program calculate the sum of numbers that the user has entered
%and calculates the mean. The numbers are saved on a matrix and the first value of
%the matrix is the number of numbers entered. The last value of the matrix
%is the mean of the numbers above.
%first I initialize my variables:

clc
clear all
close all

counter=0;
total(2)=0;   %initialize the mean value to zero.
total(1)=0;   %and the number of values in the matrix
done=0;       %initialize variables. This needs to be one so the while loop can start
firstime=1;
average = 0; %average was a command that did not exist, we needed to create this variable so our for loop can work properly
fprintf('Make me run. Please!\n'); %There needs to be a \n so both fprintfs aren't on one line
fprintf('Enter numbers now.');
while (done == 0)    % This changes from ~=0 to while done is equal to 0, then run this 
    counter=counter+1;
    if firstime == 1 %This had no == expression. If this is the first number being entered, firstime == 1. Also, firstime is mispelt from the original variable   
       number = input(' First number?\n' );
       firstime = 0;
       total = number %We must actually register our first number into the total variable
    end;
    more = input('More numbers? (y n) ','s');
    if (strcmp(more,'n')) %The n here needs to be in quotations so it can be a string, which is what the more variable is.   
        done = 1;   
        break
    else 
                %we do not need that continue variable anymore since we
                %changed our end placement for this if statement
        done =0;
    
    number=input('next number? \n');
    total(counter+1)= number;
    end; %end command is moved to include lines 32 and 33. It was originally above those two commands, therefore it could not output them
end;

for numnum = total(1:end)    %add the numbers. we need to change this to total to add the numbers correctly instead of using total(end). it is total(2:end)
    average=average+numnum;
end
total(end+1)=average/length(total); %total(end-2) is not consistent with the final fprintf command that says our average. So we must make it total(end+1). Also the equation has (end-2) which is contingent on nothing, so we must give it a command, that command is the length of the total 
total(1)=length(total)-1; %total(end)- 2 would give us the 3rd last variable. Instead we want the total digits we put into our forumla. That is length(total)-1
fprintf('You entered %d numbers, and the average is %f',total(1), total(end)); %change %d which has an exponent sign to %f so there is not exp sign