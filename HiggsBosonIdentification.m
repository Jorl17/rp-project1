function varargout = HiggsBosonIdentification(varargin)
% HIGGSBOSONIDENTIFICATION MATLAB code for HiggsBosonIdentification.fig
%      HIGGSBOSONIDENTIFICATION, by itself, creates a new HIGGSBOSONIDENTIFICATION or raises the existing
%      singleton*.
%
%      H = HIGGSBOSONIDENTIFICATION returns the handle to a new HIGGSBOSONIDENTIFICATION or the handle to
%      the existing singleton*.
%
%      HIGGSBOSONIDENTIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HIGGSBOSONIDENTIFICATION.M with the given input arguments.
%
%      HIGGSBOSONIDENTIFICATION('Property','Value',...) creates a new HIGGSBOSONIDENTIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HiggsBosonIdentification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HiggsBosonIdentification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HiggsBosonIdentification

% Last Modified by GUIDE v2.5 31-May-2015 15:38:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HiggsBosonIdentification_OpeningFcn, ...
                   'gui_OutputFcn',  @HiggsBosonIdentification_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HiggsBosonIdentification is made visible.
function HiggsBosonIdentification_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HiggsBosonIdentification (see VARARGIN)

% Choose default command line output for HiggsBosonIdentification
handles.output = hObject;

% SETUP DEFAUL VARIABLES DEFAULT VALUES. FIXME: THIS SHOULD BE IN ONE
% FUNCTION BUT I CANNOT MAKE THIS WORK LIKE THAT
% Show default Panel
setVisibility(handles, 1);

handles.useDefaultFile = 1;
handles.defaultFilePath = 'dataset/higgs_data.mat';
handles.inputFilePath = handles.defaultFilePath; %Default file

handles.balanceTrainingData = 'undersample';

% Set inputFile default text
set(handles.inputFileText, 'String', 'No Input File Selected!');
set(handles.browseFileTrainText, 'String', 'No Input File Selected!');
set(handles.inputFileText, 'Visible', 'off');
set(handles.browseFileButton, 'Visible', 'off');
handles.trainFilePath = char();
handles.classifierFilePath = char();
handles.classificationFilePath = char();
handles.useDifferentDatasetForClassification = 0;
set(handles.selectFileForValidationPanel, 'Visible', 'off');

handles.useSameFileForTrainingAndValidation = 1;
set(handles.selectFileForValidationPanel, 'Visible', 'off');
set(handles.selectClassifierPanel, 'Visible', 'off');

set(handles.classifierParameterText, 'Visible', 'on');
set(handles.classifierParameterEdit, 'Visible', 'on');

set(handles.saveClassifierButton, 'Visible', 'off');

set(handles.knnParameterText, 'Visible', 'off');
set(handles.knnParameterFillMissingValuesEdit, 'Visible', 'off');

% Set default training file and percentage
handles.percentageTraining = 100;
handles.percentageTest = 0;
set(handles.trainPercentageText, 'Visible', 'on');
set(handles.trainPercentageText, 'String', 'Train: 70%');
set(handles.testPercentageText, 'String', 'Test: 30%');
handles.percentageTraining = 70;
handles.percentageTest = 30;
set(handles.trainingPercentageSlider, 'Visible', 'on');
set(handles.fillMissingValuesCheckbox, 'Visible', 'on');
set(handles.fillMissingValuesListBox, 'Visible', 'on');
handles.fillMissingValues = 0;
handles.fillMissingValuesMethod = 'Discard';
handles.fillMissingValuesKNNParameter = 5;
handles.performFeatureReduction = 0;
handles.targetNumberFeaturesFeatureReduction = 5;
handles.targetNumberFeaturesFeatureSelection = 2;
handles.featureSelection = 1;
set(handles.featureSelectionListBox, 'Visible', 'on');
handles.featureSelectionMethod = 'fskruskalwallis';
handles.featureReduction = 1;
set(handles.featureReductionListBox, 'Visible', 'on');
handles.featureReductionMethod = 'lda';
handles.classifier = 'knn';
handles.loadClassifier = 0;
handles.classifierParameter = 40;

set(handles.selectTrainAndValidationPercentagesPanel, 'Visible', 'on');

set(handles.featureReductionTargetNumberFeaturesText, 'Visible', 'on');
set(handles.featureReductionTargetNumberFeaturesEdit, 'Visible', 'on');
set(handles.featureSelectionTargetNumberFeaturesText, 'Visible', 'on');
set(handles.featureSelectionTargetNumberFeaturesEdit, 'Visible', 'on');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HiggsBosonIdentification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HiggsBosonIdentification_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in preProcessingTabButton.
function preProcessingTabButton_Callback(hObject, ~, handles)
% hObject    handle to preProcessingTabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hide all the remaining tabs and display preProcessingPanel
    setVisibility(handles, 1);

    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in trainClassificationTabButton.
function trainClassificationTabButton_Callback(hObject, ~, handles)
% hObject    handle to trainClassificationTabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hide all the remaining tabs and display trainClassificationPanel
    setVisibility(handles, 2);

    % Update handles structure
    guidata(hObject, handles);

% --- Executes on button press in validationTabButton.
function validationTabButton_Callback(hObject, ~, handles)
% hObject    handle to validationTabButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hide all the remaining tabs and display validationPanel
    setVisibility(handles, 3);

    % Update handles structure
    guidata(hObject, handles);

    
function setVisibility(handles, tabNumber)
% SETVISIBILITY defines which panel to show and which panels to hide
% depending on the selected tab
% handles    structure with handles and user data (see GUIDATA)
% tabNumber  the number of the tab selected
    set(handles.higgsBosonIdentificationPanel, 'Visible', 'on');
    if tabNumber == 1
        set(handles.preProcessingPanel,'Visible','on');
        set(handles.trainClassificationPanel, 'Visible', 'off');
        set(handles.validationPanel, 'Visible', 'off');
    elseif tabNumber == 2
        set(handles.preProcessingPanel,'Visible','off');
        set(handles.trainClassificationPanel, 'Visible', 'on');
        set(handles.validationPanel, 'Visible', 'off');
    else
        set(handles.preProcessingPanel,'Visible','off');
        set(handles.trainClassificationPanel, 'Visible', 'off');
        set(handles.validationPanel, 'Visible', 'on');
    end
    

% --- Executes during object creation, after setting all properties.
function trainClassificationPanel_CreateFcn(hObject, ~, handles)
% hObject    handle to linearmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in browseFileButton.
function browseFileButton_Callback(hObject, ~, handles)
% hObject    handle to browseFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Select the input file
    [filename, pathname] = uigetfile({'*.mat','Binary MATLAB format file (*.mat)'},'Choose an Input File');
    handles.inputFilePath = [pathname filename];
    
    % Update the filename in the handles structure
    set(handles.inputFileText, 'String', filename);
    
    % Update handles structure
    guidata(hObject, handles);
    
    
% --- Executes on slider movement.
function trainingPercentageSlider_Callback(hObject, ~, handles)
% hObject    handle to trainingPercentageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

    handles.percentageTraining = 100 - int64(get(hObject, 'Value') * 100);
    handles.percentageTest = int64(get(hObject, 'Value') * 100);
    % Update text and slider
    set(handles.trainPercentageText, 'String', strcat('Train: ', num2str(handles.percentageTraining), '%'));
    set(handles.testPercentageText, 'String', strcat('Test: ', num2str(handles.percentageTest), '%'));
    
    % Update handles structure
    guidata(hObject, handles);
    


% --- Executes during object creation, after setting all properties.
function trainingPercentageSlider_CreateFcn(hObject, ~, ~)
% hObject    handle to trainingPercentageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


% --- Executes on slider movement.
function validationPercentageSlider_Callback(hObject, ~, handles)
% hObject    handle to validationPercentageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'Value') returns position of slider
    %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    
    handles.percentageValidation = int64(get(hObject, 'Value') * 100);
    % Update text and slider
    set(handles.validationPercentageText, 'String', strcat('Validation: ', num2str(handles.percentageValidation), '%'));
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function validationPercentageSlider_CreateFcn(hObject, ~, ~)
% hObject    handle to validationPercentageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


% --- Executes on button press in fillMissingValuesCheckbox.
function fillMissingValuesCheckbox_Callback(hObject, ~, handles)
% hObject    handle to fillMissingValuesCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of fillMissingValuesCheckbox
    handles.fillMissingValues = get(hObject, 'Value');
    if handles.fillMissingValues == 1
        % Show list box with fill missing values methods
       set(handles.fillMissingValuesListBox, 'Visible', 'on');
    else
        % Hide list box with fill missing values methods
        set(handles.fillMissingValuesListBox, 'Visible', 'off');
    end

    % Update handles structure
    guidata(hObject, handles);


% --- Executes on selection change in fillMissingValuesListBox.
function fillMissingValuesListBox_Callback(hObject, ~, handles)
% hObject    handle to fillMissingValuesListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns fillMissingValuesListBox contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from fillMissingValuesListBox
    contents = cellstr(get(hObject,'String'));
    handles.fillMissingValuesMethod = strtrim(contents{get(hObject,'Value')});
    
    if strcmp(handles.fillMissingValuesMethod, 'KNN')
        % Show
        set(handles.knnParameterText, 'Visible', 'on');
        set(handles.knnParameterFillMissingValuesEdit, 'Visible', 'on');
    else
        % Hide
        set(handles.knnParameterText, 'Visible', 'off');
        set(handles.knnParameterFillMissingValuesEdit, 'Visible', 'off');
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function fillMissingValuesListBox_CreateFcn(hObject, ~, ~)
% hObject    handle to fillMissingValuesListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in featureReductionCheckbox.
function featureReductionCheckbox_Callback(hObject, ~, handles)
% hObject    handle to featureReductionCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of featureReductionCheckbox
    handles.performFeatureReduction = get(hObject,'Value');
    
    if handles.performFeatureReduction == 1
        % Show input text
        set(handles.targetNumberOfFeaturesText, 'Visible', 'on');
        set(handles.targetNumberOfFeatures, 'Visible','on');
    else
        % Hide input text
        set(handles.targetNumberOfFeaturesText, 'Visible', 'off');
        set(handles.targetNumberOfFeatures, 'Visible','off');
    end
    
    % Update handles structure
    guidata(hObject, handles);
    

function targetNumberOfFeatures_Callback(hObject, ~, handles)
% hObject    handle to targetNumberOfFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of targetNumberOfFeatures as text
    %        str2double(get(hObject,'String')) returns contents of targetNumberOfFeatures as a double
    handles.targetNumberFeatures = str2double(get(hObject,'String'));
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function targetNumberOfFeatures_CreateFcn(hObject, ~, ~)
% hObject    handle to targetNumberOfFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in featureSelectionCheckbox.
function featureSelectionCheckbox_Callback(hObject, ~, handles)
% hObject    handle to featureSelectionCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of featureSelectionCheckbox
    handles.featureSelection = get(hObject,'Value');
    if handles.featureSelection == 1
        % Show feature selection list box
        set(handles.featureSelectionListBox, 'Visible', 'on');
        set(handles.featureSelectionTargetNumberFeaturesText, 'Visible', 'on');
        set(handles.featureSelectionTargetNumberFeaturesEdit, 'Visible', 'on');
    else
        % Hide feature selection list box
        set(handles.featureSelectionListBox, 'Visible', 'off');
        set(handles.featureSelectionTargetNumberFeaturesText, 'Visible', 'off');
        set(handles.featureSelectionTargetNumberFeaturesEdit, 'Visible', 'off');
    end
    
    % Update handles structure
    guidata(hObject, handles);
    


% --- Executes on selection change in featureSelectionListBox.
function featureSelectionListBox_Callback(hObject, ~, handles)
% hObject    handle to featureSelectionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns featureSelectionListBox contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from featureSelectionListBox
    contents = cellstr(get(hObject,'String'));
    value = strtrim(contents{get(hObject,'Value')});
    
    %disp(value)
    if strcmp(value, 'Fisher')
        %disp('Fisher')
        handles.featureSelectionMethod = 'fisher';
    elseif strcmp(value,  'KruskalWallis')
        %disp('KruskalWallis')
        handles.featureSelectionMethod = 'fskruskalwallis';
    elseif strcmp(value,  'Area Under Curve')
        %disp('Area Under Curve')
        handles.featureSelectionMethod = 'auc';
    elseif strcmp(value,  'MRMR Additive')
        %disp('MRMR Additive')
        handles.featureSelectionMethod = 'mrmra';
    elseif strcmp(value,  'MRMR Multiplicative')
        %disp('MRMR Multiplicative')
        handles.featureSelectionMethod = 'mrmrm';
    elseif strcmp(value,  'Sequential FS Forward')
        %disp('Sequential FS Forward')
        handles.featureSelectionMethod = 'sequentialFSForward';
    elseif strcmp(value,  'Sequential FS Backward')
        %disp('Sequential FS Backward')
        handles.featureSelectionMethod = 'sequentialFSBackward';
    else
        %disp('corrcoef')
        handles.featureSelectionMethod = 'corrcoef';
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function featureSelectionListBox_CreateFcn(hObject, ~, ~)
% hObject    handle to featureSelectionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in featureReductionCheckBox.
function featureReductionCheckBox_Callback(hObject, ~, handles)
% hObject    handle to featureReductionCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of featureReductionCheckBox
    handles.featureReduction = get(hObject,'Value');
    
    if handles.featureReduction == 1
        % Show feature reduction list box
        set(handles.featureReductionListBox, 'Visible', 'on');
        set(handles.featureReductionTargetNumberFeaturesText, 'Visible', 'on');
        set(handles.featureReductionTargetNumberFeaturesEdit, 'Visible', 'on');
    else
        % Hide feature reduction list box
        set(handles.featureReductionListBox, 'Visible', 'off');
        set(handles.featureReductionTargetNumberFeaturesText, 'Visible', 'off');
        set(handles.featureReductionTargetNumberFeaturesEdit, 'Visible', 'off');
    end 
        
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on selection change in featureReductionListBox.
function featureReductionListBox_Callback(hObject, ~, handles)
% hObject    handle to featureReductionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns featureReductionListBox contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from featureReductionListBox
    contents = cellstr(get(hObject,'String'));
    value = strtrim(contents{get(hObject,'Value')});
    
    switch value
        case 'PCA'
            handles.featureReductionMethod = 'pca';
        case 'LDA'
            handles.featureReductionMethod = 'lda';
        case 'Kernel-PCA'
            handles.featureReductionMethod = 'kpca';
        otherwise
            handles.featureReductionMethod = 'gda';
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function featureReductionListBox_CreateFcn(hObject, ~, ~)
% hObject    handle to featureReductionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    
% --- Executes when selected object is changed in classifierButtonGroup.
function classifierButtonGroup_SelectionChangedFcn(hObject, ~, handles)
% hObject    handle to the selected object in classifierButtonGroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    selectedObject = get(handles.classifierButtonGroup, 'SelectedObject');
    selectedObjectString = get(selectedObject, 'String');
    
    if strcmp(selectedObjectString, 'SVM') == 1
            handles.classifier = 'svm';
            % Hide classifier parameter
            set(handles.classifierParameterText, 'Visible', 'on');
            set(handles.classifierParameterEdit, 'Visible', 'on');
    elseif strcmp(selectedObjectString, 'LIBSVM') == 1
            handles.classifier = 'libsvm';
            % Hide classifier parameter
            set(handles.classifierParameterText, 'Visible', 'on');
            set(handles.classifierParameterEdit, 'Visible', 'on');
    elseif strcmp(selectedObjectString, 'KNN') == 1
            handles.classifier = 'knn';
            % Show classifier parameter
            set(handles.classifierParameterText, 'Visible', 'on');
            set(handles.classifierParameterEdit, 'Visible', 'on');
    elseif strcmp(selectedObjectString, 'Naive Bayes')
            handles.classifier = 'naive_bayes';
            % Hide classifier parameter
            set(handles.classifierParameterText, 'Visible', 'off');
            set(handles.classifierParameterEdit, 'Visible', 'off');
    elseif strcmp(selectedObjectString, 'Reg Tree')
            handles.classifier = 'fitrtree';
            % Hide classifier parameter
            set(handles.classifierParameterText, 'Visible', 'off');
            set(handles.classifierParameterEdit, 'Visible', 'off');
    elseif strcmp(selectedObjectString, 'Class Tree')
            handles.classifier = 'fitctree';
            % Hide classifier parameter
            set(handles.classifierParameterText, 'Visible', 'off');
            set(handles.classifierParameterEdit, 'Visible', 'off');
    end
    
    % Update handles structure
    guidata(hObject, handles);    


% --- Executes on button press in useDefaultFileCheckbox.
function useDefaultFileCheckbox_Callback(hObject, ~, handles)
% hObject    handle to useDefaultFileCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of useDefaultFileCheckbox
    handles.useDefaultFile = get(hObject,'Value');
    if handles.useDefaultFile == 0
        set(handles.inputFileText, 'Visible', 'on');
        set(handles.browseFileButton, 'Visible', 'on');
    else
        set(handles.inputFileText, 'Visible', 'off');
        set(handles.browseFileButton, 'Visible', 'off');
        handles.inputFilePath = handles.defaultFilePath; %Default file
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in browseFileTrainButton.
function browseFileTrainButton_Callback(hObject, ~, handles)
% hObject    handle to browseFileTrainButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Select the input file
    [filename, pathname] = uigetfile({'*.mat','Binary MATLAB format file (*.mat)'},'Choose an Input File');
    handles.trainFilePath = [pathname filename];
    
    % Update the filename in the handles structure
    set(handles.browseFileTrainText, 'String', filename);
    
    % Update handles structure
    guidata(hObject, handles);
    
    
% --- Executes on button press in brosweFileClassificationButton.
function brosweFileClassificationButton_Callback(hObject, ~, handles)
% hObject    handle to brosweFileClassificationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Select the input file
    [filename, pathname] = uigetfile({'*.mat','Binary MATLAB format file (*.mat)'},'Choose an Input File');
    handles.classificationFilePath = [pathname filename];
    
    % Update the filename in the handles structure
    set(handles.browseFileClasificationText, 'String', filename);
    
    % Update handles structure
    guidata(hObject, handles);
    

% --- Executes on button press in browseClassifierButton.
function browseClassifierButton_Callback(hObject, ~, handles)
% hObject    handle to browseClassifierButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Select the input file
    [filename, pathname] = uigetfile({'*.mat','Binary MATLAB format file (*.mat)'},'Choose an Input File');
    handles.classifierFilePath = [pathname filename];
    
    % Update the filename in the handles structure
    set(handles.browseClassifierText, 'String', filename);
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in usePreviousFileForTrainingAndValidationCheckbox.
function usePreviousFileForTrainingAndValidationCheckbox_Callback(hObject, ~, handles)
% hObject    handle to usePreviousFileForTrainingAndValidationCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of usePreviousFileForTrainingAndValidationCheckbox
    handles.useSameFileForTrainingAndValidation = get(hObject, 'Value');
    if handles.useSameFileForTrainingAndValidation == 1
       set(handles.selectFileForValidationPanel, 'Visible', 'off');
       handles.loadClassifier = 0;
       handles.useDifferentDatasetForClassification = 0;
       set(handles.selectDifferentdataSetClassification, 'Value', 0.0);
       set(handles.loadClassifierCheckbox, 'Value', 0.0);
       set(handles.classifierButtonGroup, 'Visible', 'on');
       set(handles.selectClassifierPanel, 'Visible', 'off');
       set(handles.browseClassifierText, 'String', 'No Input File Selected!');
       set(handles.selectTrainAndValidationPercentagesPanel, 'Visible', 'on');
    else
       % set(handles.selectFileForValidationPanel, 'Visible', 'on');
       set(handles.selectTrainAndValidationPercentagesPanel, 'Visible', 'off');
       set(handles.classifierButtonGroup, 'Visible', 'off');
    end

    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in selectDifferentdataSetClassification.
function selectDifferentdataSetClassification_Callback(hObject, ~, handles)
% hObject    handle to selectDifferentdataSetClassification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of selectDifferentdataSetClassification
    handles.useDifferentDatasetForClassification = get(hObject, 'Value');
    if handles.useDifferentDatasetForClassification == 1
        set(handles.selectFileForValidationPanel, 'Visible', 'on');
        set(handles.loadClassifierCheckbox, 'Value', 0.0);
        handles.loadClassifier = 0;
        handles.useSameFileForTrainingAndValidation = 0;
        set(handles.classifierButtonGroup, 'Visible', 'on');
        set(handles.browseClassifierText , 'String', 'no Input File Selected!');
        set(handles.usePreviousFileForTrainingAndValidationCheckbox, 'Value', 0.0);
        set(handles.selectTrainAndValidationPercentagesPanel, 'Visible', 'off');
        set(handles.selectClassifierPanel, 'Visible', 'off');
        set(handles.browseClassifierText , 'String', 'No Input File Selected!');
    else
        set(handles.selectFileForValidationPanel, 'Visible', 'off');
        set(handles.classifierButtonGroup, 'Visible', 'off');
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in loadClassifierCheckbox.
function loadClassifierCheckbox_Callback(hObject, ~, handles)
% hObject    handle to loadClassifierCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of loadClassifierCheckbox
    handles.loadClassifier = get(hObject,'Value');
    
    if handles.loadClassifier == 1
        set(handles.usePreviousFileForTrainingAndValidationCheckbox, 'Value', 0.0);
        set(handles.selectDifferentdataSetClassification, 'Value', 0.0);
        handles.useSameFileForTrainingAndValidation = 0;
        handles.useDifferentDatasetForClassification = 0;
        set(handles.selectTrainAndValidationPercentagesPanel, 'Visible', 'off');
        set(handles.classifierButtonGroup, 'Visible', 'off');
        set(handles.selectFileForValidationPanel, 'Visible', 'on');
        set(handles.browseFileTrainText, 'String', 'No Input File Selected!');
        set(handles.selectClassifierPanel, 'Visible', 'on');
        set(handles.browseClassifierText , 'String', 'No Input File Selected!');
    else
        % set(handles.classifierButtonGroup, 'Visible', 'on');
        set(handles.selectFileForValidationPanel, 'Visible', 'off');
        set(handles.browseFileTrainText, 'String', 'No Input File Selected!');
        set(handles.selectClassifierPanel, 'Visible', 'off');
        set(handles.browseClassifierText , 'String', 'No Input File Selected!');
    end
    
    % Update handles structure
    guidata(hObject, handles);    


% --- Executes on button press in undersampleTrainingDataCheckbox.
function undersampleTrainingDataCheckbox_Callback(hObject, ~, handles)
% hObject    handle to undersampleTrainingDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of undersampleTrainingDataCheckbox
    if get(hObject, 'Value') == 1
        handles.balanceTrainingData = 'undersample';
        set(handles.oversampleTrainingDataCheckbox, 'Value', 0.0);
    else
        handles.balanceTrainingData = 'oversample';
        set(handles.oversampleTrainingDataCheckbox, 'Value', 1.0);
    end
    
    % Update handles structure
    guidata(hObject, handles)


% --- Executes on button press in oversampleTrainingDataCheckbox.
function oversampleTrainingDataCheckbox_Callback(hObject, ~, handles)
% hObject    handle to oversampleTrainingDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of oversampleTrainingDataCheckbox
    if get(hObject, 'Value') == 1
        handles.balanceTrainingData = 'oversample';
        set(handles.undersampleTrainingDataCheckbox, 'Value', 0.0);
    else
        handles.balanceTrainingData = 'undersample';
        set(handles.undersampleTrainingDataCheckbox, 'Value', 1.0);
    end
    
    % Update handles structure
    guidata(hObject, handles)
    
% --- Executes during object creation, after setting all properties.
function resultsTable_CreateFcn(hObject, ~, handles)
% hObject    handle to resultsTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'Data', -1*ones(2));
    set(hObject, 'RowName', {'Predicted correct', 'Predicted Incorrect'}, 'ColumnName', {'Real Correct', 'Real Incorrect'});
    
    % Update handles structure
    guidata(hObject, handles);
    
    
% --- Executes during object creation, after setting all properties.
function furtherResultsTable_CreateFcn(hObject, ~, handles)
% hObject    handle to furtherResultsTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    set(hObject, 'Data', -1*ones(4,1));
    set(hObject, 'RowName', {'Accuracy', 'Sensitivity', 'Specificity', 'F-Measure'}, 'ColumnName', {'Value'});
    
    % Update handles structure
    guidata(hObject, handles);
    
% --- Executes on button press in oversampleTrainingDataCheckbox.
function svmRadioButton_Callback(~, ~, ~)
% hObject    handle to oversampleTrainingDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in oversampleTrainingDataCheckbox.
function libsvmRadioButton_Callback(~, ~, ~)
% hObject    handle to oversampleTrainingDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in oversampleTrainingDataCheckbox.
function knnRadioButton_Callback(~, ~, ~)
% hObject    handle to oversampleTrainingDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in oversampleTrainingDataCheckbox.
function naiveBayesRadionButton_Callback(~, ~, ~)
% hObject    handle to oversampleTrainingDataCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in fitrtreeButton.
function fitrtreeButton_Callback(~, ~, ~)
% hObject    handle to fitrtreeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fitrtreeButton

% --- Executes on button press in classificationTreeRadioButton.
function classificationTreeRadioButton_Callback(~, ~, ~)
% hObject    handle to classificationTreeRadioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of classificationTreeRadioButton


function classifierParameterEdit_Callback(hObject, ~, ~)
% hObject    handle to classifierParameterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of classifierParameterEdit as text
    %        str2double(get(hObject,'String')) returns contents of classifierParameterEdit as a double
    handles.classifierParameter = str2num(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function classifierParameterEdit_CreateFcn(hObject, ~, ~)
% hObject    handle to classifierParameterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function featureReductionTargetNumberFeaturesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to featureReductionTargetNumberFeaturesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of featureReductionTargetNumberFeaturesEdit as text
    %        str2double(get(hObject,'String')) returns contents of featureReductionTargetNumberFeaturesEdit as a double
        handles.targetNumberFeaturesFeatureReduction = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function featureReductionTargetNumberFeaturesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to featureReductionTargetNumberFeaturesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function featureSelectionTargetNumberFeaturesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to featureSelectionTargetNumberFeaturesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of featureSelectionTargetNumberFeaturesEdit as text
    %        str2double(get(hObject,'String')) returns contents of featureSelectionTargetNumberFeaturesEdit as a double
    handles.targetNumberFeaturesFeatureSelection = str2num(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function featureSelectionTargetNumberFeaturesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to featureSelectionTargetNumberFeaturesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function knnParameterFillMissingValuesEdit_Callback(hObject, ~, handles)
% hObject    handle to knnParameterFillMissingValuesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of knnParameterFillMissingValuesEdit as text
    %        str2double(get(hObject,'String')) returns contents of knnParameterFillMissingValuesEdit as a double
    handles.fillMissingValuesKNNParameter = str2num(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function knnParameterFillMissingValuesEdit_CreateFcn(hObject, ~, ~)
% hObject    handle to knnParameterFillMissingValuesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    
% --- Executes on button press in saveClassifierButton.
function saveClassifierButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveClassifierButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    [user_selected_file, user_selected_path] = uiputfile('*.mat','Save File as');
    pathname = [user_selected_path user_selected_file];
    save_trained_model(pathname, handles.trained_model);

    
% --- Executes on button press in runButon.
function runButon_Callback(hObject, ~, handles)
% hObject    handle to runButon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    addpath('libsvm-3.20/matlab');
    addpath('mi');
    
    handles.featureSelection

    if handles.loadClassifier == 1
        fprintf('Loading trained model...\n');
        trained_model = load_trained_model(handles.classifierFilePath);
        fprintf('Loading dataset...\n');
        [~, higgs_data] = load_dataset(handles.trainFilePath);        
        fprintf('Classifying...\n');
        [labels, sprt_test] = classify(trained_model, 'preprocess', higgs_data);
    elseif handles.useSameFileForTrainingAndValidation == 1
        % load dataset and pre-process the data 
        handles.classifierParameter = str2num(get(handles.classifierParameterEdit,'String'));
        fprintf('[1]Loading dataset...\n');
        [~, higgs_data] = load_dataset(handles.inputFilePath);
        fprintf('Preprocessing dataset...\n');
        [selected_features, feature_extraction_module, sprt_data ] = preprocess(higgs_data, lower(handles.fillMissingValuesMethod), handles.featureSelection, lower(handles.featureSelectionMethod), handles.performFeatureReduction, lower(handles.featureReductionMethod), handles.targetNumberFeaturesFeatureSelection, handles.targetNumberFeaturesFeatureReduction, handles.fillMissingValuesKNNParameter);
        fprintf('Splitting dataset...\n');
        [sprt_train, sprt_test, ~] = split_training_test_validate(sprt_data, handles.percentageTraining/100.0, handles.percentageTest/100.0, 0);        
        fprintf('Balancing training dataset...\n');
        sprt_train = balance_dataset(sprt_train, handles.balanceTrainingData);
        fprintf('Training classifier...\n');
        model = train(sprt_train, handles.classifier, handles.classifierParameter);
        fprintf('Building the training model...\n');
        handles.trained_model = build_trained_model(model, selected_features, feature_extraction_module, lower(handles.fillMissingValuesMethod), handles.classifierParameter);
        fprintf('Classifying...\n');
        [labels, ~] = classify(handles.trained_model, 'Capitao_Iglo', sprt_test);
    elseif handles.selectDifferentdataSetClassification == 1
        handles.classifierParameter = str2num(get(handles.classifierParameterEdit,'String'));
        fprintf('Loading dataset...\n');
        [~, higgs_data] = load_dataset(handles.inputFilePath);
        fprintf('Preprocessing dataset...\n');
        [selected_features, feature_extraction_module, sprt_data ] = preprocess(higgs_data, lower(handles.fillMissingValuesMethod), handles.featureSelection, lower(handles.featureSelectionMethod), handles.performFeatureReduction, lower(handles.featureReductionMethod), handles.targetNumberFeaturesFeatureSelection, handles.targetNumberFeaturesFeatureReduction, handles.fillMissingValuesKNNParameter);
        %printf('Splitting dataset...\n');
        %[sprt_train, ~, ~] = split_training_test_validate(sprt_data_balanced, handles.percentageTraining/100.0, handles.percentageTest/100.0, 0);
        sprt_train = sprt_data;
        fprintf('Balancing training dataset...\n');
        sprt_train = balance_dataset(sprt_train, handles.balanceTrainingData);
        fprintf('Training classifier...\n');
        model = train(sprt_train, handles.classifier, handles.classifierParameter);
        fprintf('Building the training model...\n');
        handles.trained_model = build_trained_model(model, selected_features, feature_extraction_module, lower(handles.fillMissingValuesMethod), handles.classifierParameter);
        fprintf('Loading dataset to be classified...\n');
        [~, higgs_data_test] = load_dataset(handles.trainFilePath);
        fprintf('Classifying...\n');
        [labels, sprt_test] = classify(handles.trained_model, 'preprocess', higgs_data_test);
    else
        msgbox({'Invalid Parameters Specified!'}, 'Invalid Parameters', 'error');
        return ;
    end
    
    [FP, FN, TP, TN, accuracy, sensitivity, specificity, F1] = classifier_performance(labels, sprt_test.y);
    fprintf('Accuracy: %f\n', accuracy);
    fprintf('Sensitivity: %f\n', sensitivity);
    fprintf('Specificity: %f\n', specificity);
    fprintf('FP: %f, FN: %f\n', FP, FN);
    
    % Update the results tables
    set(handles.resultsTable, 'Data', [TP, FP;FN, TN]);
    set(handles.resultsTable, 'RowName', {'Predicted correct', 'Predicted Incorrect'}, 'ColumnName', {'Real Correct', 'Real Incorrect'});
    
    set(handles.furtherResultsTable, 'Data', [accuracy; sensitivity; specificity; F1]);
    set(handles.furtherResultsTable, 'RowName', {'Accuracy', 'Sensitivity', 'Specificity', 'F-Measure'}, 'ColumnName', {'Value'});
    
    set(handles.saveClassifierButton, 'Visible', 'on');
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes when classifierButtonGroup is resized.
function classifierButtonGroup_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to classifierButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.classifierParameter = str2num(get(handles.classifierParameterEdit,'String'));
    
    % Update handles structure
    guidata(hObject, handles);
    
 % --- Executes when classifierButtonGroup is resized.
function classifierButtonGroup_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to classifierButtonGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over classifierParameterEdit.
function classifierParameterEdit_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to classifierParameterEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.classifierParameter = str2num(get(hObject,'String'));
    
    % Update handles structure
    guidata(hObject, handles);
    