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

% Last Modified by GUIDE v2.5 27-May-2015 22:20:41

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
% Set inputFile default text
set(handles.inputFileText, 'String', 'No Input File Selected!');
% Set default training file and percentage
handles.inputFilePath=char();
handles.trainFilePath = char();
handles.useInputFileForTrainAndClassification = 0;
handles.useInputFileForTrainClassificationAndValidation = 0;
handles.percentageTraining = 0;
handles.percentageValidation = 0;
set(handles.trainPercentageText, 'Visible', 'off');
set(handles.trainPercentageText, 'String', 'Train: 0%');
set(handles.trainingPercentageSlider, 'Visible', 'off');
set(handles.validationPercentageText, 'Visible', 'off');
set(handles.validationPercentageText, 'String', 'Validation: 0%');
set(handles.validationPercentageSlider, 'Visible', 'off');
set(handles.fillMissingValuesCheckbox, 'Visible', 'on');
set(handles.fillMissingValuesListBox, 'Visible', 'off');
handles.fillMissingValues = 0;
handles.fillMissingValuesMethod = char();
set(handles.featureReductionCheckbox, 'Visible', 'on');
set(handles.targetNumberOfFeaturesText, 'Visible', 'off');
set(handles.targetNumberOfFeatures, 'Visible','off');
handles.performFeatureReduction = 0;
handles.targetNumberFeatures = 0;
handles.featureSelection = 0;
set(handles.featureSelectionListBox, 'Visible', 'off');
handles.featureSelectionMethod = char();
handles.featureReduction = 0;
set(handles.featureReductionListBox, 'Visible', 'off');
handles.featureReductionMethod = char();

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
    


% --- Executes on button press in useDatasetForTrainingClassificationCheckbox.
function useDatasetForTrainingClassificationCheckbox_Callback(hObject, ~, handles)
% hObject    handle to useDatasetForTrainingClassificationCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of useDatasetForTrainingClassificationCheckbox    
    handles.useInputFileForTrainAndClassification = get(hObject, 'Value');
    if handles.useInputFileForTrainAndClassification == 1
        handles.trainFilePath = handles.inputFilePath;
        set(handles.trainPercentageText, 'Visible', 'on');
        set(handles.trainingPercentageSlider, 'Visible', 'on');
    elseif handles.useInputFileForTrainClassificationAndValidation == 0
        set(handles.trainPercentageText, 'Visible', 'off');
        set(handles.trainingPercentageSlider, 'Visible', 'off');
        handles.trainFilePath = '';
        % FIXME: RESET TRAIN FILE IN THE TRAINING TAB
    end

    % Update handles structure
    guidata(hObject, handles);

    
% --- Executes on button press in useDatasetForTrainingClassificationValidationCheckbox.
function useDatasetForTrainingClassificationValidationCheckbox_Callback(hObject, ~, handles)
% hObject    handle to useDatasetForTrainingClassificationValidationCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: get(hObject,'Value') returns toggle state of useDatasetForTrainingClassificationValidationCheckbox
    handles.useInputFileForTrainClassificationAndValidation = get(hObject, 'Value');
    if handles.useInputFileForTrainClassificationAndValidation == 1
        handles.trainFilePath = handles.inputFilePath;
        %Show second slider and text
        set(handles.trainPercentageText, 'Visible', 'on');
        set(handles.trainingPercentageSlider, 'Visible', 'on');
        set(handles.validationPercentageSlider, 'Visible', 'on');
        set(handles.validationPercentageText, 'Visible', 'on');
    else
        % Hide second slider and text
        set(handles.validationPercentageSlider, 'Visible', 'off');
        set(handles.validationPercentageText, 'Visible', 'off');
        if handles.useInputFileForTrainAndClassification == 0
            set(handles.trainPercentageText, 'Visible', 'off');
            set(handles.trainingPercentageSlider, 'Visible', 'off');
            
            handles.trainFilePath = '';
            % FIXME: RESET TRAIN FILE IN THE TRAINING TAB
        end
    end
    
    % Update handles structure
    guidata(hObject, handles);
    
    
% --- Executes on slider movement.
function trainingPercentageSlider_Callback(hObject, ~, handles)
% hObject    handle to trainingPercentageSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

    handles.percentageTraining = int64(get(hObject, 'Value') * 100);
    % Update text and slider
    set(handles.trainPercentageText, 'String', strcat('Train: ', num2str(handles.percentageTraining), '%'));
    
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
    handles.fillMissingValuesMethod = contents{get(hObject,'Value')};
    
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
    else
        % Hide feature selection list box
        set(handles.featureSelectionListBox, 'Visible', 'off');
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
    value = contents{get(hObject,'Value')};
    
    switch value
        case 'Fisher'
            handles.featureSelectionMethod = 'fisher';
        case 'KruskalWallis'
            handles.featureSelectionMethod = 'fskruskalwallis';
        case 'Area Under Curve'
            handles.featureSelectionMethod = 'auc';
        case 'MRMR Additive'
            handles.featureSelectionMethod = 'mrmra';
        case 'MRMR Multiplicative'
            handles.featureSelectionMethod = 'mrmrm';
        case 'Sequential FS Forward'
            handles.featureSelectionMethod = 'sequentialFSForward';
        case 'Sequential FS Backward'
            handles.featureSelectionMethod = 'sequentialFSBackward';
        otherwise
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
    else
        % Hide feature reduction list box
        set(handles.featureReductionListBox, 'Visible', 'off');
    end 
        
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on selection change in featureReductionListBox.
function featureReductionListBox_Callback(hObject, eventdata, handles)
% hObject    handle to featureReductionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns featureReductionListBox contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from featureReductionListBox
    contents = cellstr(get(hObject,'String'));
    value = contents{get(hObject,'Value')};
    
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


% --- Executes on button press in runButon.
function runButon_Callback(hObject, eventdata, handles)
% hObject    handle to runButon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % FIXME: Check for valid parameters!
    
    % Check for input file
    if strcmp(handles.inputFilePath, '')
        msgbox({'No Input File Specified! Please specify an Input File!'}, 'Invalid Parameters', 'error');
        return ;
    end
    
    % FIXME: Check for reduced number of features! (check if introduced
    % number of features is smaller or equal to the dataset's number of
    % features
    
    % FIXME: Check for training data and validation
    if handles.useInputFileForTrainAndClassification == 1 && handles.useInputFileForTrainClassificationAndValidation == 1
        % Check if the sum of the two percentages is smaller than 100
        if handles.percentageTraining + handles.percentageValidation > 100
            return ;
        end
    end
    
    % FIXME: Check for Feature Selection
    
    % FIXME: Check for Feature Reduction
        
        
        
