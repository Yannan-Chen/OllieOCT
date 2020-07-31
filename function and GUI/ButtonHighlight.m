function [handles] = ButtonHighlight(handles,maxScore,buttonIdx)
%BUTTONHIGHLIGHT Summary of this function goes here
%   Detailed explanation goes here
HighlightColor = [.149,.7608,.5059];
for i = buttonIdx
    if i == maxScore
        handles.(['Button_' num2str(i)]).Color =  HighlightColor;
        handles.(['Button_' num2str(i)]).CColor =  HighlightColor;
    else
        handles.(['Button_' num2str(i)]).Color =  [0.3430 0.4654 0.5750];
        handles.(['Button_' num2str(i)]).CColor =  [0.3430 0.4654 0.5750];
    end
end

