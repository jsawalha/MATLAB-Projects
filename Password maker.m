% User password program
% Jeff S.
% Feb 6, 2017
% This program asks the users for a password but has certain requirements
% to accept a password
% Outputs a history of invalid and valid attempts

clc
clear all
clear

invalid= 1; %A way to break the while loop
attnum = 1; %the number of times there is an attempt on getting a correct password
S = {}; % A cell matrix for our eventual table

while invalid == 1 %while loop breaks when invalid = 1
    password = input('Enter a password 6 letters or more, must have at least one digit, and an upper case letter: ','s')
    
    
    if length(password) >= 6 % if password is greater than 6 characters
        if any(double(password) < 90) % if password has a captial letter. Capital letters are below 90 on the double function
            if any(double(password) < 58 ) %If password has a number. Numbers are below 58 on double
                if  any(double(password) > 96) %If password has a lower case letter. numbers over 96 are lower case letters in the double function
                    invalid = 0; %accepts the password, breaks the while loop
                    disp('OK, password is valid')
                else
                    disp('Your password does not have a lower case letter in it')
                    S{attnum,1} = password; %adds password attempt to S matrix
                    S{attnum,2} = attnum; %adds attember number to S matrix
                    S{attnum,3} = 'Error code 4'; %adds error code
                    attnum = attnum + 1; %attempt number goes up by 1
                    clear password
                    
                    
                end
                
            else
                disp('Your password does not have a number in it')
                S{attnum,1} = password;
                S{attnum,2} = attnum;
                S{attnum,3} = 'Error code 3';
                attnum = attnum + 1;
                clear password
                
                
            end
        else
            disp('Your password does not have a upper case letter in it')
            S{attnum,1} = password;
            S{attnum,2} = attnum;
            attnum = attnum + 1;
            S{attnum,3} = 'Error code 2';
            clear password
            
            
        end
        
    else
        disp('Your password is not 6 characters long')
        S{attnum,1} = password;
        S{attnum,2} = attnum;
        S{attnum,3} = 'Error code 1';
        attnum = attnum + 1;
        clear password
        
    end
end
Tbl = cell2table(S,'VariableNames',{'AttempedPass' 'AttemptedNum' 'ErrorCode'}) %table for results of password entries


