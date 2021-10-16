%function [result] = ComputeAdjacency(x, csvFilePath)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%inputArray = csvread(csvFilePath);
%disp('inputArray =');
%disp(inputArray);
%if x == 4
%    [newArray, result] = bwlabel(inputArray, 4);
%    disp('newArray =');
%    disp(newArray);
%else 
%    [newArray, result] = bwlabel(inputArray, 8);
%    disp('newArray =');
%    disp(newArray);
%end
function [ num ] = ComputeAdjacency(x, csvFilePath)

inputArray = csvread(csvFilePath);
disp('inputArray =');
disp(inputArray);

if (x == 4)    
    connectivity = 4;
else
    connectivity = 8;
end

[x,y] = size(inputArray);

inputArray = [zeros(1,y+2);[zeros(x,1) inputArray zeros(x,1)]];
[x,y] = size(inputArray);

newArray = zeros(size(inputArray));
nextlabel = 1;
linked = [];

for i = 2:x                       
    for j = 2:y-1                
        if inputArray(i,j) ~= 0         
            if (connectivity == 8)
                neighboursearch = [inputArray(i-1,j-1), inputArray(i-1,j), inputArray(i-1,j+1),inputArray(i,j-1)];
            elseif (connectivity == 4)
                neighboursearch = [inputArray(i-1,j),inputArray(i,j-1)];
            end
                      
            [~,n,neighbours] = find(neighboursearch==1);
                     
            if isempty(neighbours)
                linked{nextlabel} = nextlabel;
                newArray(i,j) = nextlabel;
                nextlabel = nextlabel+1;                
            
            else
                if (connectivity == 8)
                    neighboursearch_label = [newArray(i-1,j-1), newArray(i-1,j), newArray(i-1,j+1),newArray(i,j-1)];
                elseif (connectivity == 4)
                    neighboursearch_label = [newArray(i-1,j), newArray(i,j-1)];
                end
                L = neighboursearch_label(n);
                newArray(i,j) = min(L);
                for num = 1:length(L)
                    label = L(num);
                    linked{label} = unique([linked{label} L]);
                end                
            end
        end
    end
end

newArray = newArray(2:end,2:end-1);

change2 = 1;
while change2 == 1
    change = 0;
    for i = 1:length(linked)
        for j = 1:length(linked)
            if i ~= j
                if sum(ismember(linked{i},linked{j}))>0 && sum(ismember(linked{i},linked{j})) ~= length(linked{i})
                    change = 1;
                    linked{i} = union(linked{i},linked{j});
                    linked{j} = linked{i};
                end
            end
        end
    end
    
    if change == 0
        change2 = 0;
    end
    
end

linked = unique(cellfun(@num2str,linked,'UniformOutput',false));
linked = cellfun(@str2num,linked,'UniformOutput',false);

K = length(linked);
templabels = newArray;
newArray = zeros(size(newArray));

for num = 1:K
    for l = 1:length(linked{num})
        newArray(templabels == linked{num}(l)) = num;
    end
end

disp('newArray =');
disp(newArray);
end
            