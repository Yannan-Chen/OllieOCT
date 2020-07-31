function [handles,hObject] = buttonCalls(type,Tag,handles,hObject)

fprintf('The call came from %s \n',Tag)

switch type
    case 'Open'
        [localfilename,localfilepath] = uigetfile({'*.jpeg';'*.png'},'MultiSelect','on');
        if localfilepath ~= 0
            handles.filename = localfilename;
            handles.filepath = localfilepath;
            
            try
                img = imread([handles.filepath handles.filename{1}]);
            catch
                handles.filename = {localfilename};
            end
            
            % Diagnose and generate table
            Score = cell(size(handles.filename,2),1);
            Referral = cell(size(handles.filename,2),1);
            Disease = cell(size(handles.filename,2),1);
            for i = 1:size(handles.filename,2)
                img = imread([handles.filepath handles.filename{i}]);
                
                img = imresize3(repmat(img,[1 1 3]),[224,224,3]);
                    
                Score{i} = predict(handles.net.net,img);
                [~, maxScore] = max(Score{i});
                switch maxScore
                    case 1
                        Disease{i} = 'CNV';
                        Referral{i} = 'Urgent';
                    case 2
                        Disease{i} = 'DME';
                        Referral{i} = 'Urgent';
                    case 3
                        Disease{i} = 'Drusen';
                        Referral{i} = 'Routine';
                    case 4
                        Disease{i} = 'Normal';
                        Referral{i} = ' ';
                end
            end
            
            FileName = handles.filename';
            T = table(FileName,Disease,Referral);
            handles.Table_1.Table = T;
            handles.score = Score;
            handles.diagnosis = Referral;
            handles.disease = Disease;
            
            handles.text.String = {handles.filepath};
            set(handles.text,'visible', 'off');
        end
    case 'Save'
        if handles.filepath ~= 0
            handles.savepath = uigetdir(handles.filepath,'Pick a Directory');
            
            if handles.savepath~=0
                mkdir([handles.savepath '/Normal']);
                mkdir([handles.savepath '/Abnormal']);
                for i = 1:size(handles.filename,2)
                    img = imread([handles.filepath handles.filename{i}]);
                    
                    if strcmp(handles.diagnosis{i}, 'Abnormal')
                        save([handles.savepath '/Abnormal/Abnormal_' handles.filename{i}],'img');
                    else
                        save([handles.savepath '/Normal/Normal_' handles.filename{i}],'img');
                    end
                end
                handles.Label.Text = ['Saved in ' handles.savepath];
            end
        end
    case 'CNV'
        handles = Diagnosing(handles,1);
        
        FileName = handles.filename';
        Referral = handles.diagnosis;
        Disease = handles.disease;
        
        T = table(FileName,Disease,Referral);
        handles.Table_1.Table = T;
        
        handles = ButtonHighlight(handles,3,3:6);
    case 'DME'
        handles = Diagnosing(handles,2);
        
        FileName = handles.filename';
        Referral = handles.diagnosis;
        Disease = handles.disease;
        
        T = table(FileName,Disease,Referral);
        handles.Table_1.Table = T;
        
        handles = ButtonHighlight(handles,4,3:6);
    case 'Drusen'
        handles = Diagnosing(handles,3);
        
        FileName = handles.filename';
        Referral = handles.diagnosis;
        Disease = handles.disease;
        
        T = table(FileName,Disease,Referral);
        handles.Table_1.Table = T;
        
        handles = ButtonHighlight(handles,5,3:6);
    case 'Normal'
        handles = Diagnosing(handles,4);
        
        FileName = handles.filename';
        Referral = handles.diagnosis;
        Disease = handles.disease;
        
        T = table(FileName,Disease,Referral);
        handles.Table_1.Table = T;
        
        handles = ButtonHighlight(handles,6,3:6);
end


end

