function varargout = CNN_Gui(varargin)
% CNN_GUI MATLAB code for CNN_Gui.fig
%      CNN_GUI, by itself, creates a new CNN_GUI or raises the existing
%      singleton*.
%
%      H = CNN_GUI returns the handle to a new CNN_GUI or the handle to
%      the existing singleton*.
%
%      CNN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CNN_GUI.M with the given input arguments.
%
%      CNN_GUI('Property','Value',...) creates a new CNN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CNN_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CNN_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CNN_Gui

% Last Modified by GUIDE v2.5 06-Feb-2016 09:31:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CNN_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @CNN_Gui_OutputFcn, ...
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


% --- Executes just before CNN_Gui is made visible.
function CNN_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CNN_Gui (see VARARGIN)
handles.database_name='MNIST';
handles.current_data=load('MINST');
handles.trainsamples=1000;
handles.batch_size=200;
handles.train_epochs=10;
handles.learningrate=0.25;
handles.testsamples=100;
handles.plot_results =' ';
handles.Train_out=[ ];
handles.Conv1=8;
handles.Conv2=8;
handles.Pool1='max';
handles.Pool2='max';

% Choose default command line output for CNN_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CNN_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CNN_Gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Show_samples.
function Show_samples_Callback(hObject, eventdata, handles)
% hObject    handle to Show_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
Img_sample=Show_samples(handles);
figure, imshow(Img_sample/255);

% --- Executes on selection change in Database_name.
function Database_name_Callback(hObject, eventdata, handles)
% hObject    handle to Database_name (see GCBO)
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
% Hints: contents = cellstr(get(hObject,'String')) returns Database_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Database_name


% --- Executes during object creation, after setting all properties.
function Database_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Database_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Plot_results.
function Plot_results_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_results (see GCBO)
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
% Hints: contents = cellstr(get(hObject,'String')) returns Plot_results contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Plot_results


% --- Executes during object creation, after setting all properties.
function Plot_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plot_results (see GCBO)
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


% --- Executes on button press in Call_train_test.
function Call_train_test_Callback(hObject, eventdata, handles)
% hObject    handle to Call_train_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[net, res]=Train_CNN(handles);
handles.Train_loss=res.loss;
handles.classifier='CNN';
handles.net=net;
handles.res=res;
[train_res, test_res]=Test_CNN(handles);
handles.train_res=train_res;
handles.test_res=test_res;
guidata(hObject, handles)


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


% --- Executes on selection change in Set_Conv1.
function Set_Conv1_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Conv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.Conv1=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_Conv1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_Conv1


% --- Executes during object creation, after setting all properties.
function Set_Conv1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_Conv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_Pool1.
function Set_Pool1_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Pool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.Pool1=str{val};
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_Pool1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_Pool1


% --- Executes during object creation, after setting all properties.
function Set_Pool1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_Pool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_Conv2.
function Set_Conv2_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Conv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.Conv2=str2double(str{val});
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_Conv2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_Conv2


% --- Executes during object creation, after setting all properties.
function Set_Conv2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_Conv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Set_Pool2.
function Set_Pool2_Callback(hObject, eventdata, handles)
% hObject    handle to Set_Pool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject, 'Value');
% Set current data to the selected data set.
handles.Pool2=str{val};
guidata(hObject, handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Set_Pool2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Set_Pool2


% --- Executes during object creation, after setting all properties.
function Set_Pool2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Set_Pool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
