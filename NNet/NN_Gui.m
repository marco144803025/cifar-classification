function varargout = NN_Gui(varargin)
% NN_GUI MATLAB code for NN_Gui.fig
%      NN_GUI, by itself, creates a new NN_GUI or raises the existing
%      singleton*.
%
%      H = NN_GUI returns the handle to a new NN_GUI or the handle to
%      the existing singleton*.
%
%      NN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NN_GUI.M with the given input arguments.
%
%      NN_GUI('Property','Value',...) creates a new NN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NN_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NN_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NN_Gui

% Last Modified by GUIDE v2.5 06-Feb-2016 09:33:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NN_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @NN_Gui_OutputFcn, ...
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


% --- Executes just before NN_Gui is made visible.
function NN_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NN_Gui (see VARARGIN)

handles.database_name='MNIST';
handles.current_data=load('MINST');
handles.classifier='MLP';
handles.trainsamples=1000;
handles.batch_size=200;
handles.train_epochs=100;
handles.hidden_layer=0;
handles.hidden_nodes=100; 
handles.testsamples=100;
handles.learningrate=0.01;
handles.regularization=2.5e-3;
handles.plot_results =' ';
handles.Train_out=[ ];

% Choose default command line output for NN_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NN_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NN_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in database_name.

function database_name_Callback(hObject, eventdata, handles)
%% Chose the database
% hObject    handle to database_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
switch str{val};
    case 'MNIST'  % load MINST database.
        handles.current_data = load('MINST');
        handles.database_name='MNIST';
    case 'CIFAR10' % User selects Membrane.
        handles.current_data = load('CIFAR10');
        handles.database_name='CIFAR10';
end

guidata(hObject, handles)

% Hints: contents = cellstr(get(hObject,'String')) returns database_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from database_name

% --- Executes on button press in Show_samples.
function Show_samples_Callback(hObject, eventdata, handles)
%% show the images
% hObject    handle to Show_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % figure;
axes(handles.axes1);
Img_sample=Show_samples(handles);
figure, imshow(Img_sample/255);

% --- Executes during object creation, after setting all properties.
function database_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to database_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_Classifier.
function Set_Classifier_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.classifier=str{val};
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_Classifier contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_Classifier


% --- Executes during object creation, after setting all properties.
function Set_Classifier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_Classifier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_trainsamples.
function Set_trainsamples_Callback(hObject, eventdata, handles)
% hObject    handle to Set_trainsamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.trainsamples=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_trainsamples contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_trainsamples


% --- Executes during object creation, after setting all properties.
function Set_trainsamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_trainsamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_batchsize.
function Set_batchsize_Callback(hObject, eventdata, handles)
% hObject    handle to Set_batchsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.batch_size=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_batchsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_batchsize


% --- Executes during object creation, after setting all properties.
function Set_batchsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_batchsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_trainepochs.
function Set_trainepochs_Callback(hObject, eventdata, handles)
% hObject    handle to Set_trainepochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.

handles.train_epochs=str2double(str{val});

guidata(hObject, handles)

% Hints: contents = cellstr(get(hObject,'String')) returns Set_trainepochs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_trainepochs


% --- Executes during object creation, after setting all properties.
function Set_trainepochs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_trainepochs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_hiddenlayer.
function Set_hiddenlayer_Callback(hObject, eventdata, handles)
% hObject    handle to Set_hiddenlayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.

handles.hidden_layer=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_hiddenlayer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_hiddenlayer


% --- Executes during object creation, after setting all properties.
function Set_hiddenlayer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_hiddenlayer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_hiddennodes.
function Set_hiddennodes_Callback(hObject, eventdata, handles)
% hObject    handle to Set_hiddennodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.hidden_nodes=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_hiddennodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_hiddennodes


% --- Executes during object creation, after setting all properties.
function Set_hiddennodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_hiddennodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Call_train.
function Call_train_Callback(hObject, eventdata, handles)
% hObject    handle to Call_train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % axes(handles.axes2);
Out=Train_NN(handles);
handles.Train_out=Out;
handles.Train_loss=Out.loss;
[train_res, test_res]=Test_NN(handles);
handles.train_res=train_res;
handles.test_res=test_res;
guidata(hObject, handles)

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
% % function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Set_testsamples.
function Set_testsamples_Callback(hObject, eventdata, handles)
% hObject    handle to Set_testsamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.testsamples=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_testsamples contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_testsamples


% --- Executes during object creation, after setting all properties.
function Set_testsamples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_testsamples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Call_test.
function Call_test_Callback(hObject, eventdata, handles)
% hObject    handle to Call_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[train_res, test_res]=Test_NN(handles);
handles.train_res=train_res;
handles.test_res=test_res;
guidata(hObject, handles);

% --- Executes on selection change in Call_plotresults.
function Call_plotresults_Callback(hObject, eventdata, handles)
% hObject    handle to Call_plotresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
switch str{val};
    case 'Train error'  % 
        handles.plot_results ='Train error';
    case 'Train acc' % 
        handles.plot_results ='Train acc';
    case 'Test acc' % 
        handles.plot_results ='Test acc';   
     case 'Train Confusion matrix' % 
        handles.plot_results ='Train Confusion matrix';
     case 'Test Confusion matrix' % 
        handles.plot_results ='Test Confusion matrix';   
end
axes(handles.axes2);
Show_results(handles);
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Call_plotresults contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Call_plotresults


% --- Executes during object creation, after setting all properties.
function Call_plotresults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Call_plotresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_learningrate.
function Set_learningrate_Callback(hObject, eventdata, handles)
% hObject    handle to Set_learningrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.learningrate=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_learningrate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_learningrate


% --- Executes during object creation, after setting all properties.
function Set_learningrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_learningrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_regularization.
function Set_regularization_Callback(hObject, eventdata, handles)
% hObject    handle to Set_regularization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.regularization=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_regularization contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_regularization


% --- Executes during object creation, after setting all properties.
function Set_regularization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_regularization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
