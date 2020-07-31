function [handles,hObject] = TableCallback(Tag,handles,hObject)

%% Get idx
try
    filename = hObject.String;
    for i = 1:numel(handles.filename)
        if strcmp(filename, handles.filename{i})
            break;
        else
            if i == numel(handles.filename)
                return;
            end
        end
    end
catch
    return
end

% save('obj.mat','handles','hObject')
handles.currentID = i;

%% Show image
axes(handles.axes1);
axis off;
set(handles.axes1,'visible', 'on');

img = imread([handles.filepath handles.filename{handles.currentID}]);
imshow(img)
title(handles.filename{handles.currentID},'Interpreter','none')

%% Show diagnosis buttons
flds = {'CNV','DME','Drusen','Normal'};

for maxScore = 1:4
    if strcmp(flds{maxScore},handles.disease{handles.currentID})
        break;
    end
end

flds = [flds(maxScore),flds];
flds(maxScore+1) = [];

Callback = {'WheelCallback'};
pos = handles.spinner.NormPos;

s = funBuildo('wheel','spinner',pos,flds,...
    [1 0 0 0],'Callback',Callback);
handles = funControl('wheel',handles,s);

handles.Button_3.Visible = 'on';
handles.Button_4.Visible = 'on';
handles.Button_5.Visible = 'on';
handles.Button_6.Visible = 'on';

handles = ButtonHighlight(handles,maxScore+2,3:6);



end

