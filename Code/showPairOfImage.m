function varargout = showPairOfImage(varargin)
% SHOWPAIROFIMAGE MATLAB code for showPairOfImage.fig
%      SHOWPAIROFIMAGE, by itself, creates a new SHOWPAIROFIMAGE or raises the existing
%      singleton*.
%
%      H = SHOWPAIROFIMAGE returns the handle to a new SHOWPAIROFIMAGE or the handle to
%      the existing singleton*.
%
%      SHOWPAIROFIMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOWPAIROFIMAGE.M with the given input arguments.
%
%      SHOWPAIROFIMAGE('Property','Value',...) creates a new SHOWPAIROFIMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before showPairOfImage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to showPairOfImage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help showPairOfImage

% Last Modified by GUIDE v2.5 02-May-2017 22:00:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @showPairOfImage_OpeningFcn, ...
                   'gui_OutputFcn',  @showPairOfImage_OutputFcn, ...
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


% --- Executes just before showPairOfImage is made visible.
function showPairOfImage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to showPairOfImage (see VARARGIN)

 global sqo ; %sequence number of pair
% global strPathData;

sqo=1; %default

% Choose default command line output for showPairOfImage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes showPairOfImage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = showPairOfImage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbPrevious.
function pbPrevious_Callback(hObject, eventdata, handles)
% hObject    handle to pbPrevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sqo;
global strPathData;
global cellArrList;
sqo=sqo-1;
strPathA=cellArrList{1,1}{sqo};
strPathA=strcat(strPathData,strPathA);
[imgA,mapA] = imread(strPathA);
axes(handles.axesA)
imshow(imgA);

strPathB=cellArrList{1,2}{sqo};
strPathB=strcat(strPathData,strPathB);
[imgB,mapB] = imread(strPathB);
axes(handles.axesB)
imshow(imgB);

strAnnotation=cellArrList{1,3}{sqo};
if strAnnotation=='1' 
    set(handles.chkAnnMatch,'Value',1);
else
    set(handles.chkAnnMatch,'Value',-1);
end

% --- Executes on button press in pbNext.
function pbNext_Callback(hObject, eventdata, handles)
% hObject    handle to pbNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sqo;
global strPathData;
global cellArrList;
sqo=sqo+1;
strPathA=cellArrList{1,1}{sqo};
strPathA=strcat(strPathData,strPathA);
[imgA,mapA] = imread(strPathA);
axes(handles.axesA)
imshow(imgA);

strPathB=cellArrList{1,2}{sqo};
strPathB=strcat(strPathData,strPathB);
[imgB,mapB] = imread(strPathB);
axes(handles.axesB)
imshow(imgB);

strAnnotation=cellArrList{1,3}{sqo};
if strAnnotation=='1' 
    set(handles.chkAnnMatch,'Value',1);
else
    set(handles.chkAnnMatch,'Value',-1);
end

% --- Executes on button press in chkAnnMatch.
function chkAnnMatch_Callback(hObject, eventdata, handles)
% hObject    handle to chkAnnMatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkAnnMatch



function editFullPath_Callback(hObject, eventdata, handles)
% hObject    handle to editFullPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editFullPath as text
%        str2double(get(hObject,'String')) returns contents of editFullPath as a double


% --- Executes during object creation, after setting all properties.
function editFullPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editFullPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbLoad.
function pbLoad_Callback(hObject, eventdata, handles)
% hObject    handle to pbLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sqo;
global strPathData;
global cellArrList;
f=fopen(get(handles.editFullPath,'String'),'r');
cellArrList = textscan(f,'%s %s %s');
strPathA=cellArrList{1,1}{sqo};
strPathA=strcat(strPathData,strPathA);
[imgA,mapA] = imread(strPathA);
axes(handles.axesA)
imshow(imgA);

strPathB=cellArrList{1,2}{sqo};
strPathB=strcat(strPathData,strPathB);
[imgB,mapB] = imread(strPathB);
axes(handles.axesB)
imshow(imgB);

strAnnotation=cellArrList{1,3}{sqo};
if strAnnotation=='1' 
    set(handles.chkAnnMatch,'Value',1);
else
    set(handles.chkAnnMatch,'Value',-1);
end
% loadImage(sqo);


% --- Executes on button press in chkColorMatch.
function chkColorMatch_Callback(hObject, eventdata, handles)
% hObject    handle to chkColorMatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkColorMatch


% --- Executes on button press in chkHOGMatch.
function chkHOGMatch_Callback(hObject, eventdata, handles)
% hObject    handle to chkHOGMatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkHOGMatch
