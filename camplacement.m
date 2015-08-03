function varargout = camplacement(varargin)
% CAMPLACEMENT MATLAB code for camplacementProgram.fig
%      CAMPLACEMENT, by itself, creates a new CAMPLACEMENT or raises the existing
%      singleton*.
%
%      H = CAMPLACEMENT returns the handle to a new CAMPLACEMENT or the handle to
%      the existing singleton*.
%
%      CAMPLACEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMPLACEMENT.M with the given input arguments.
%
%      CAMPLACEMENT('Property','Value',...) creates a new CAMPLACEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before camplacement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to camplacement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help camplacement

% Last Modified by GUIDE v2.5 02-Aug-2015 19:46:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @camplacement_OpeningFcn, ...
                   'gui_OutputFcn',  @camplacement_OutputFcn, ...
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

global nRows;
global nCols;

% --- Executes just before camplacement is made visible.
function camplacement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to camplacement (see VARARGIN)

% Choose default command line output for camplacement
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes camplacement wait for user response (see UIRESUME)
% uiwait(handles.mainWindow);


% --- Outputs from this function are returned to the command line.
function varargout = camplacement_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function setAirportDimensions(airport, numOfRows, numOfCols)

global nRows;
nRows = numOfRows;
global nCols;
nCols = numOfCols;

position = get(airport, 'Position');
set(airport, 'Data', cell(1));

d = get(airport, 'Data');
d{1,numOfCols} = [];
d{numOfRows, 1} = [];

set(airport, 'Data', d);

if numOfRows < 4
    set(airport, 'Data', cell(numOfRows));
    numOfCols = numOfRows;
end

set(airport, 'ColumnWidth', {(position(3) * 2.499) / (numOfCols / 2)});
if numOfRows < 8
    const = 1.9;
elseif numOfRows >= 11
    const = 1.745;
else
    const = 1.8;
end

if numOfRows == 2
    set(airport, 'FontSize', 79);
else
    set(airport, 'FontSize', 79 / (numOfRows  / const));
end

set(airport, 'ColumnEditable', true(1, numOfCols));
set(airport, 'Data', ones(numOfRows, numOfCols));


% --- Executes during object creation, after setting all properties.
function airport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to airport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
setAirportDimensions(hObject, 2, 2);


% --- Executes on selection change in camListBox.
function camListBox_Callback(hObject, eventdata, handles)
% hObject    handle to camListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns camListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from camListBox

currentItems = get(hObject, 'String');
rowToDelete = get(hObject, 'Value');

if ~isempty(currentItems)
    set(hObject, 'Value', []);
    newItems = currentItems;
    newItems(rowToDelete) = [];

    set(hObject, 'String', newItems);
end

set(hObject, 'Value', 1);

% --- Executes during object creation, after setting all properties.
function camListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to camListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rowsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to rowsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rowsEdit as text
%        str2double(get(hObject,'String')) returns contents of rowsEdit as a double
val = get(hObject,'String');
num = str2num(val);
if ~isempty(strfind(val, ',')) || isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', '');
end


% --- Executes during object creation, after setting all properties.
function rowsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rowsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function colsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to colsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colsEdit as text
%        str2double(get(hObject,'String')) returns contents of colsEdit as a double
val = get(hObject,'String');
num = str2num(val);
if ~isempty(strfind(val, ',')) || isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', '');
end


% --- Executes during object creation, after setting all properties.
function colsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setDimButton.
function setDimButton_Callback(hObject, eventdata, handles)
% hObject    handle to setDimButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

numOfRows = str2num(get(handles.rowsEdit, 'String'));
numOfColumns = str2num(get(handles.colsEdit, 'String'));

if not(isempty(numOfRows)) && not(isempty(numOfColumns))
    setAirportDimensions(handles.airport, numOfRows, numOfColumns);
end


% --- Executes when selected cell(s) is changed in airport.
function airport_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to airport (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


function rowEdit_Callback(hObject, eventdata, handles)
% hObject    handle to rowEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rowEdit as text
%        str2double(get(hObject,'String')) returns contents of rowEdit as a double
val = get(hObject, 'String');
num = str2num(val);

global nRows;
if ~isempty(strfind(val, ',')) || isempty(num) || num < 1 || num > nRows || floor(num) ~= num
    set(hObject, 'String', '');
end

% --- Executes during object creation, after setting all properties.
function rowEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rowEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function colEdit_Callback(hObject, eventdata, handles)
% hObject    handle to colEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colEdit as text
%        str2double(get(hObject,'String')) returns contents of colEdit as a double
val = get(hObject, 'String');
num = str2num(val);

global nCols;
if  ~isempty(strfind(val, ',')) || isempty(num) || num < 1 || num > nCols || floor(num) ~= num
    set(hObject, 'String', '');
end

% --- Executes during object creation, after setting all properties.
function colEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function angleEdit_Callback(hObject, eventdata, handles)
% hObject    handle to angleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of angleEdit as text
%        str2double(get(hObject,'String')) returns contents of angleEdit as a double
val = get(hObject, 'String');
num = str2num(val);
if ~isempty(strfind(val, ',')) || isempty(num) || num < 0 || num > 360
    set(hObject, 'String', '');
end

% --- Executes during object creation, after setting all properties.
function angleEdit_CreateFcn(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to angleEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addCamButton.
function addCamButton_Callback(hObject, eventdata, handles)
% hObject    handle to addCamButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
items = get(handles.camListBox, 'String');
%length is needed in order to append the desired message at the end
listLen = length(items);

row = get(handles.rowEdit, 'String');
col = get(handles.colEdit, 'String');
angle = get(handles.angleEdit, 'String');

if not(isempty(row)) && not(isempty(col)) && not(isempty(angle))
	data = get(handles.airport, 'Data');
    if data(str2num(row), str2num(col)) == 1
        items{listLen + 1} = strcat('(', row, ',', col, ',', angle, ')');
        set(handles.camListBox, 'String', items);
    else
        msgbox('A camera cannot be added where there is wall.', 'Error', 'error');
    end
end


% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

items = get(handles.camListBox, 'String');
listLen = length(items);
if listLen > 0
    set(handles.scoreValText, 'String', '');
    set(handles.cpuValText, 'String', '');
    set(handles.runButton, 'Enable', 'off');
    set(handles.addCamButton, 'Enable', 'off');
    set(handles.setDimButton, 'Enable', 'off');
    
    camList = zeros(listLen, 3);
    for index = 1:listLen
        item = strrep(items{index}, ')', '');
        item = strrep(item, '(', '');
        params = strsplit(item, ',');
        camList(index, 1) = str2double(params(1));
        camList(index, 2) = str2double(params(2));
        camList(index, 3) = str2double(params(3));
    end
    
    data = get(handles.airport', 'Data');
    score = -1;
    t = cputime;
    switch get(get(handles.algoPanel,'SelectedObject'), 'String')
        case 'TS'
            tabuLen = str2num(get(handles.tsTabu, 'String'));
            iters = str2num(get(handles.tsIter, 'String'));
            
            if isempty(tabuLen) || isempty(iters)
                msgbox('One or more of the algorithm paramters are invalid.', 'Error', 'error');
            else
                [cams, score] = TSCamPlacement(data, camList, tabuLen, iters);
                disp(cams);
            end
        case 'SA'
            initTemp = str2num(get(handles.saInitTemp, 'String'));
            alpha = str2num(get(handles.saAlpha, 'String'));
            finalTemp = str2num(get(handles.saFinalTemp, 'String'));
            itersPerTemp = str2num(get(handles.saIterPerTemp, 'String'));
            
            if isempty(initTemp) || isempty(alpha) || isempty(finalTemp) || isempty(itersPerTemp)
                msgbox('One or more of the algorithm paramters are invalid.', 'Error', 'error');
            else
                [score, cams] = SA(initTemp, alpha, finalTemp, itersPerTemp, data, camList);
                disp(cams);
            end

        case 'GA'
            pop = str2num(get(handles.gaPopulation, 'String'));
            muts = str2num(get(handles.gaMutation, 'String'));
            crossover = str2num(get(handles.gaCrossOver, 'String'));
            gens = str2num(get(handles.gaGenerations, 'String'));
            
            if isempty(pop) || isempty(muts) || isempty(crossover) || isempty(gens)
                msgbox('One or more of the algorithm parameters are invalid.', 'Error', 'error');
            else
                [cams, score] = GeneticAlgorithm(data, listLen, crossover, muts, pop, gens);
                disp(cams);
            end
            
        case 'ACO'
            ants = str2num(get(handles.acoNumOfAnts, 'String'));
            iters = str2num(get(handles.acoIters, 'String'));
            
            if isempty(ants) || isempty(iters)
                msgbox('One or more of the algorithm parameters are invalid.', 'Error', 'error');
            else
                [cams, score, ~] = AntColonyOptimization(data, ants, listLen, iters);
                disp(cams);
            end
            
        case 'PSO'
            inertWeight = str2num(get(handles.psoInertialWeight, 'String'));
            pWeight = str2num(get(handles.psoPersonalWeight, 'String'));
            bWeight = str2num(get(handles.psoBestWeight, 'String'));
            iters = str2num(get(handles.psoIterations, 'String'));
            error = str2num(get(handles.psoError, 'String'));
            
            if isempty(inertWeight) || isempty(pWeight) || ...
                    isempty(bWeight) || isempty(iters) || isempty(error)
                msgbox('One or more of the algorithm paramters are invalid.', 'Error', 'error');
            else
                [cams, score, iters] = CameraPSO(data, listLen, inertWeight, pWeight, bWeight, iters, error);
                disp(cams);
                disp(iters);
            end
    end
    
    e = cputime - t;
    if score ~= -1
        set(handles.scoreValText, 'String', num2str(score));
        set(handles.cpuValText, 'String', strcat(num2str(e),' s'));
    end
    
    set(handles.runButton, 'Enable', 'on');
    set(handles.addCamButton, 'Enable', 'on');
    set(handles.setDimButton, 'Enable', 'on');
else
    msgbox('Please add one or more cameras.', 'Error', 'error');
end


% --- Executes when entered data in editable cell(s) in airport.
function airport_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to airport (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
val = eventdata.EditData;
num = str2num(val);

if isempty(num) || (num ~= 0 && num ~= 1)
    data = get(hObject, 'Data');
    indices = eventdata.Indices;
    data(indices(1), indices(2)) = eventdata.PreviousData;
    set(handles.airport, 'Data', data);
end



function tsTabu_Callback(hObject, eventdata, handles)
% hObject    handle to tsTabu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tsTabu as text
%        str2double(get(hObject,'String')) returns contents of tsTabu as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Tabu Length');
end


% --- Executes during object creation, after setting all properties.
function tsTabu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tsTabu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tsIter_Callback(hObject, eventdata, handles)
% hObject    handle to tsIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tsIter as text
%        str2double(get(hObject,'String')) returns contents of tsIter as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Iterations');
end

% --- Executes during object creation, after setting all properties.
function tsIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tsIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saInitTemp_Callback(hObject, eventdata, handles)
% hObject    handle to saInitTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saInitTemp as text
%        str2double(get(hObject,'String')) returns contents of saInitTemp as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Init Temp');
end

% --- Executes during object creation, after setting all properties.
function saInitTemp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saInitTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saAlpha_Callback(hObject, eventdata, handles)
% hObject    handle to saAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saAlpha as text
%        str2double(get(hObject,'String')) returns contents of saAlpha as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Alpha');
end

% --- Executes during object creation, after setting all properties.
function saAlpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saAlpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saFinalTemp_Callback(hObject, eventdata, handles)
% hObject    handle to saFinalTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saFinalTemp as text
%        str2double(get(hObject,'String')) returns contents of saFinalTemp as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Final Temp');
end

% --- Executes during object creation, after setting all properties.
function saFinalTemp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saFinalTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function saIterPerTemp_Callback(hObject, eventdata, handles)
% hObject    handle to saIterPerTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of saIterPerTemp as text
%        str2double(get(hObject,'String')) returns contents of saIterPerTemp as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Iters / Temp');
end

% --- Executes during object creation, after setting all properties.
function saIterPerTemp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saIterPerTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaCrossOver_Callback(hObject, eventdata, handles)
% hObject    handle to gaCrossOver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaCrossOver as text
%        str2double(get(hObject,'String')) returns contents of gaCrossOver as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Crossover');
end


% --- Executes during object creation, after setting all properties.
function gaCrossOver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaCrossOver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaMutation_Callback(hObject, eventdata, handles)
% hObject    handle to gaMutation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaMutation as text
%        str2double(get(hObject,'String')) returns contents of gaMutation as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Mutation');
end

% --- Executes during object creation, after setting all properties.
function gaMutation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaMutation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaPopulation_Callback(hObject, eventdata, handles)
% hObject    handle to gaPopulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaPopulation as text
%        str2double(get(hObject,'String')) returns contents of gaPopulation as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Population');
end

% --- Executes during object creation, after setting all properties.
function gaPopulation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaPopulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaGenerations_Callback(hObject, eventdata, handles)
% hObject    handle to gaGenerations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaGenerations as text
%        str2double(get(hObject,'String')) returns contents of gaGenerations as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Generations');
end

% --- Executes during object creation, after setting all properties.
function gaGenerations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaGenerations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function psoInertialWeight_Callback(hObject, eventdata, handles)
% hObject    handle to psoInertialWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psoInertialWeight as text
%        str2double(get(hObject,'String')) returns contents of psoInertialWeight as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Inertial Weight');
end

% --- Executes during object creation, after setting all properties.
function psoInertialWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psoInertialWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function psoPersonalWeight_Callback(hObject, eventdata, handles)
% hObject    handle to psoPersonalWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psoPersonalWeight as text
%        str2double(get(hObject,'String')) returns contents of psoPersonalWeight as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Weight (P)');
end

% --- Executes during object creation, after setting all properties.
function psoPersonalWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psoPersonalWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function psoBestWeight_Callback(hObject, eventdata, handles)
% hObject    handle to psoBestWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psoBestWeight as text
%        str2double(get(hObject,'String')) returns contents of psoBestWeight as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Weight (G)');
end


% --- Executes during object creation, after setting all properties.
function psoBestWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psoBestWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function psoIterations_Callback(hObject, eventdata, handles)
% hObject    handle to psoIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psoIterations as text
%        str2double(get(hObject,'String')) returns contents of psoIterations as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Iterations');
end


% --- Executes during object creation, after setting all properties.
function psoIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psoIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function psoError_Callback(hObject, eventdata, handles)
% hObject    handle to psoError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psoError as text
%        str2double(get(hObject,'String')) returns contents of psoError as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 0
    set(hObject, 'String', 'Error');
end

% --- Executes during object creation, after setting all properties.
function psoError_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psoError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in algoPanel.
function algoPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in algoPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

disableAllParams(handles);
switch get(eventdata.NewValue, 'tag') 
    case 'tsRadioButton'     
        set(handles.tsTabu, 'Enable', 'on');
        set(handles.tsIter, 'Enable', 'on');
    case 'saRadioButton'     
        set(handles.saInitTemp, 'Enable', 'on');
        set(handles.saAlpha, 'Enable', 'on'); 
        set(handles.saFinalTemp, 'Enable', 'on');
        set(handles.saIterPerTemp, 'Enable', 'on');
    case 'gaRadioButton' 
        set(handles.gaCrossOver, 'Enable', 'on');
        set(handles.gaMutation, 'Enable', 'on'); 
        set(handles.gaPopulation, 'Enable', 'on');
        set(handles.gaGenerations, 'Enable', 'on');
    case 'acoRadioButton'
        set(handles.acoNumOfAnts, 'Enable', 'on');
        set(handles.acoIters, 'Enable', 'on');
    case 'psoRadioButton'
        set(handles.psoInertialWeight, 'Enable', 'on'); 
        set(handles.psoPersonalWeight, 'Enable', 'on');
        set(handles.psoBestWeight, 'Enable', 'on');
        set(handles.psoIterations, 'Enable', 'on');
        set(handles.psoError, 'Enable', 'on');
end

function disableAllParams(handles)
    set(handles.tsTabu, 'Enable', 'off');
    set(handles.tsIter, 'Enable', 'off');
    
    set(handles.saInitTemp, 'Enable', 'off');
    set(handles.saAlpha, 'Enable', 'off'); 
    set(handles.saFinalTemp, 'Enable', 'off');
    set(handles.saIterPerTemp, 'Enable', 'off');
    
    set(handles.gaCrossOver, 'Enable', 'off');
    set(handles.gaMutation, 'Enable', 'off'); 
    set(handles.gaPopulation, 'Enable', 'off');
    set(handles.gaGenerations, 'Enable', 'off');
    
    set(handles.acoNumOfAnts, 'Enable', 'off');
    set(handles.acoIters, 'Enable', 'off');
    
    set(handles.psoInertialWeight, 'Enable', 'off'); 
    set(handles.psoPersonalWeight, 'Enable', 'off');
    set(handles.psoBestWeight, 'Enable', 'off');
    set(handles.psoIterations, 'Enable', 'off');
    set(handles.psoError, 'Enable', 'off');
    



function acoNumOfAnts_Callback(hObject, eventdata, handles)
% hObject    handle to acoNumOfAnts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acoNumOfAnts as text
%        str2double(get(hObject,'String')) returns contents of acoNumOfAnts as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', '# of Ants');
end

% --- Executes during object creation, after setting all properties.
function acoNumOfAnts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acoNumOfAnts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function acoIters_Callback(hObject, eventdata, handles)
% hObject    handle to acoIters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acoIters as text
%        str2double(get(hObject,'String')) returns contents of acoIters as a double
num = str2num(get(hObject, 'String'));
if isempty(num) || num < 1 || floor(num) ~= num
    set(hObject, 'String', 'Iterations');
end


% --- Executes during object creation, after setting all properties.
function acoIters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acoIters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
