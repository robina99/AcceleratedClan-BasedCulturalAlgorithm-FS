%
%File name: gBelief.m
%
%
% Programmed by Robina Rasanga

% 
% 
% This script is executed during the Global year. 
% New solutions are created across all clans based on the baset solution in
% the Global beliefspace
%   
% 
%


%disp('executing  gBelief script .... ')
% % select a certain percentage to impac
bPop  = (nPop*bGlobalRatio);
bPop1 = popCA_1(randperm(nPop,bPop));
bPop2 = popCA_2(randperm(nPop,bPop));
bPop3 = popCA_3(randperm(nPop,bPop));
bPop4 = popCA_4(randperm(nPop,bPop));
bPopList = {bPop1,bPop2,bPop3,bPop4};
PopList = {popCA_1,popCA_2,popCA_3,popCA_4}; 
b = [b1,b2,b3,b4];

% global impact
   % sub-population 1

   
   gbest =  Belief.Situational.accuracy;
 for v = 1:4
    for z = 1:size(bPopList{v},2)
        bdata = bPopList{v}(z);
            if (bdata.accuracy < gbest)
                % create new solution based on the global best 
                bdata = regeneratePop(bdata,Belief,X,T); 
            end
           bPopList{v}(z) = bdata;
    end
    bPopList{v} = SortPop([PopList{v}; bPopList{v}]);
    % select the best 
    PopList{v} = bPopList{v}(1:30,1);
    % update local belief    
    start      = false;
    newBeliefs = PopList{v}(1:newBeliefNo);
    worst      = PopList{v}(nPop);
    b(v)       = UpdateBeliefSystem(b(v), newBeliefs, worst, start ); 
 end 
b1 = b(1);
b2 = b(2);
b3 = b(3);
b4 = b(4);
