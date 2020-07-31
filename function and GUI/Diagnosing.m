function handles = Diagnosing(handles,maxScore)
%DIAGNOSING Summary of this function goes here
%   Detailed explanation goes here
currentID = handles.currentID;
switch maxScore
    case 1
        handles.disease{currentID} = 'CNV';
        handles.diagnosis{currentID} = 'Urgent';
    case 2
        handles.disease{currentID} = 'DME';
        handles.diagnosis{currentID} = 'Urgent';
    case 3
        handles.disease{currentID} = 'Drusen';
        handles.diagnosis{currentID} = 'Routine';
    case 4
        handles.disease{currentID} = 'Normal';
        handles.diagnosis{currentID} = ' ';
end
end

