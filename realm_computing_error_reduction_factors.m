% Code to implement Equation (11) in REALM paper
%---------------------------------------------------------------------------
close all
clear all
clc
warning off
%---------------------------------------------------------------------------
% paramters: used in paper
M_values = [4 8 16];
q_bits   = 6;
%---------------------------------------------------------------------------

% defining symbols
syms x y c

% defining numerator and denominator of equation (11) of paper
E_rel(x,y) = piecewise(    x+y<1,  (1+x+y)/(1+x)/(1+y) -1 ,...
                        x+y>=1, 2*(x+y)/(1+x)/(1+y) -1 )  % Eq (5)
fden(x,y) =  (1)/(1+x)/(1+y)                               % Eq (11)

for M = [4 8 16]    % compute for 3 values of M
    for i=0:M-1     % segment id along x 
        for j=0:M-1 % segment id along y
            % integral limits (Equation 11)
            v_xlolim = (i)/M;
            v_xuplim = (i+1)/M;
            v_ylolim = (j)/M;
            v_yuplim = (j+1)/M;
            Limits  = [v_xlolim v_xuplim v_ylolim,v_yuplim];
            
            % evaluation numerator and denominator of Eq (11)
            r1 = int(int(E_rel(x,y),y,v_ylolim,v_yuplim),x,v_xlolim,v_xuplim);
            r2 = int(int( fden(x,y),y,v_ylolim,v_yuplim),x,v_xlolim,v_xuplim);
            
            v_r = vpa(-r1/r2); % completing the equation 11 as r2 and r1 are two seprate parts of the same integeral
            
            % storing values in the table
            Table(i+1,j+1) = v_r;
            pause(0.01)
        end
    end
    
    % output
    Table
    
    % quantizing output to 6 bit precision
    QTable = round(Table*(2^q_bits))
    clear Table
end

%---------------------------------------------------------------------------


