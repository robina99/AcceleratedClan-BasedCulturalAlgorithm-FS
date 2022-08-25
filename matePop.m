%
%File name: matePop.m
%
% Programmed by Robina Rasanga

% Copyright (c) 2022 Robina Rasanga<robinarasanga@students.uonbi.ac.ke>.
%
% 
% This script is to perform migration and mating of the clans
% 


%% Migration
% generate the mating index 
migIndex = getMigration(migIndv,nPop);
% structure of the offspring
indv.Position  = []; % t
indv.nfeat     = 0;  % the number of features in the individual solution
indv.accuracy  = []; % store the accruracy values for each class
indv.AUCval    = []; % the AUC values of the individual
indv.OPTROCPT  = []; % the TPR and FPR values 
indv.precision = []; % the precion value
indv.recall    = []; % the precion value
indv.F1        = []; % the F1 values 
indv.mse       = []; % define the mean squared error for each class
% create the structure of the offsprings
o1 = repmat(indv,1,1);
o2 = repmat(indv,1,1);

mPerc = 0.10;% mutation percentage 

% randomly select the migrating individuals
%m11 = zeros(subpop);
for i = 1:subpop
    if (i == 1)
        m = randperm(nPop,migPopT); 
        mig1 = popCA_1(m); 
        m11(i).m = m;
    else, if(i==2)
                m = randperm(nPop,migPopT); 
                mig2 = popCA_2(m);  
                m11(i).m = m;
        else, if (i==3)
                  m = randperm(nPop,migPopT); 
                  mig3 = popCA_3(m); 
                  m11(i).m = m;
            else, if (i==4)
                    m = randperm(nPop,migPopT); 
                    mig4= popCA_4(m);  
                    m11(i).m = m;
                 end
              end
           end
    end
end
% % assign to destination populations
i1=0; i2=0; i3=0; i4=0;
%mPop1 = zeros(1,migPopT);
%mPop2 = zeros(1,migPopT);
%mPop3 = zeros(1,migPopT);
%mPop4 = zeros(1,migPopT);
for j=1:subpop
    for k=1:migPopT
        if (migIndex(k,j) == 1)
            i1 = i1+1;
            mPop1(1,(i1)) = mig1(k);
        else, if (migIndex(k,j) == 2)
                i2 = i2+1;
            mPop2((i2)) = mig2(k);
            else, if (migIndex(k,j) == 3) 
                    i3 = i3+1;
                mPop3((i3)) = mig3(k);
                else, if (migIndex(k,j) == 4) 
                        i4 = i4+1;
                       mPop4((i4)) = mig4(k);
                     end
                 end
              end
        end
    end
end

%% Mating
% % randomly select mating pairs for each populati
mate1 = popCA_1(randperm(nPop,min(nPop, size(mPop1,2))));
mate2 = popCA_2(randperm(nPop,min(nPop, size(mPop2,2))));
mate3 = popCA_3(randperm(nPop,min(nPop, size(mPop3,2))));
mate4 = popCA_4(randperm(nPop,min(nPop, size(mPop4,2))));

% % perform crossover using multi-point crossover
%
nCrpt = 3; % 3-point crossover

  
   
   mT1 = size(mate1,1);
   mT2 = size(mate2,1);
   mT3 = size(mate3,1);
   mT4 = size(mate4,1);
  mPopList = {mPop1,mPop2,mPop3,mPop4};
  mateList = {mate1,mate2,mate3,mate4};
  mTList = [mT1,mT2,mT3,mT4];
  PopList = {popCA_1,popCA_2,popCA_3,popCA_4}; 
  featSize    = size(X,2); 
  
 
 for y = 1:4

    e = 1: mTList(y);
        % perform crossover
      index = 1;
        
            p1 = mateList{y}(mTList(y));
            p2  = mPopList{y}(mTList(y));
           [o1,o2] = newFunc2(p1,p2,featSize,X,T); 
           
           off{y}(index,1) = o1;
           off{y}(index+e,1) = o2;  
         
        
   temp_off = off{y};
   p = (randperm(size(temp_off,1), round(mPerc * size(temp_off,1))));
   mutPop{y} = temp_off(randperm(size(temp_off,1), round(mPerc * size(temp_off,1))));

  for m = 1:size(mutPop{1,y})
        f = randperm(featSize, round((featSize*mPerc)));
        mutPop{y}(m).Position(f) = 0;
       
        %reassess 
        X1 = X(:,(find(mutPop{y}(m).Position ==1)));
      
        [mutPop{y}(m).accuracy,mutPop{y}(m).AUCval, ...
             mutPop{y}(m).OPTROCPT,mutPop{y}(m).mse,mutPop{y}(m).precision,mutPop{y}(m).F1,mutPop{y}(m).recall] = knn(X1,T);
  end
  
         % merge the all solutions
        sol{y} = SortPop([PopList{y};off{y};mutPop{y}]);
        PopList{y} =  sol{y}(1:30,1); % select the top solutions  

 end 
sol1 = sol{1};
sol2 = sol{2};
sol3 = sol{3};
sol4 = sol{4};
popCA_1 = PopList{1};
popCA_2 = PopList{2};
popCA_3 = PopList{3};
popCA_4 = PopList{4};
    

       
     
 

%%%%%%%%%%%%%%%%%%%%

%% Cleanup
% delete all temporary variables
clear sol{1} sol{2} sol{3} sol{4} ;
clear p1 p2 o1 o2 a1 a2 mT index crpt;
clear off{1} off{2} off{3} off{4};
clear  mate1 mate2 mate3 mate4;