function varargout = Analysis_GUI(varargin)
% ANALYSIS_GUI MATLAB code for Analysis_GUI.fig
%      ANALYSIS_GUI, by itself, creates a new ANALYSIS_GUI or raises the existing
%      singleton*.
%
%      H = ANALYSIS_GUI returns the handle to a new ANALYSIS_GUI or the handle to
%      the existing singleton*.
%
%      ANALYSIS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSIS_GUI.M with the given input arguments.
%
%      ANALYSIS_GUI('Property','Value',...) creates a new ANALYSIS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Analysis_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Analysis_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Analysis_GUI

% Last Modified by GUIDE v2.5 18-Apr-2018 17:33:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Analysis_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Analysis_GUI_OutputFcn, ...
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


% --- Executes just before Analysis_GUI is made visible.
function Analysis_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Analysis_GUI (see VARARGIN)

% Choose default command line output for Analysis_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Analysis_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Analysis_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in load_images.
function load_images_Callback(hObject, eventdata, handles)
% hObject    handle to load_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Image, image_nr, Image_name, Path] = read_image();

handles.Image_name.I = Image_name;

image_BW = struct('I', 0);
handles.image_BW = image_BW;
image_BW_thicken = struct('I', 0);
handles.image_BW_thicken = image_BW_thicken;
image_BW_thicken_remove = struct('I', 0);
handles.image_BW_thicken_remove = image_BW_thicken_remove;
handles.Path = Path;

parameters = struct('thresholdValue', 0, 'removeValue', 0, 'thickenValue', 0);
handles.parameters = parameters;

handles.Image = Image;
% Update handles structure
guidata(hObject, handles);

axes(handles.axes1);
imshow(handles.Image(1).I);

set(handles.current_image, 'String', 1); 
set(handles.image_nr, 'String', image_nr);


% --- Executes on button press in load_images_p.
function load_images_p_Callback(hObject, eventdata, handles)
% hObject    handle to load_images_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Image_p = read_image_p();

handles.image_p = Image_p;
% Update handles structure
guidata(hObject, handles);

axes(handles.axes2);
imshow(handles.image_p(1).I);

% --- Executes on button press in Down.
function Down_Callback(hObject, eventdata, handles)
% hObject    handle to Down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_image_nr = str2double(get(handles.current_image, 'String'));
current_image_nr = current_image_nr - 1;
set(handles.current_image, 'String' , current_image_nr);


    if current_image_nr == 1
    set(handles.Down, 'Enable', 'inactive');
    get(handles.Down, 'Enable');
    elseif strcmp(get(handles.Up, 'Enable'), 'inactive')
        set(handles.Up, 'Enable', 'on');
    end


axes(handles.axes1);
imshow(handles.Image(current_image_nr).I);
axes(handles.axes2);
imshow(handles.image_p(current_image_nr).I);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in Up.
function Up_Callback(hObject, eventdata, handles)
% hObject    handle to Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_image_nr = str2double(get(handles.current_image, 'String'));
current_image_nr = current_image_nr + 1;
set(handles.current_image, 'String' , current_image_nr);

get(handles.Up, 'Enable');
    
    if current_image_nr == str2double(get(handles.image_nr, 'String'))
        set(handles.Up, 'Enable', 'inactive');        
    elseif strcmp(get(handles.Down, 'Enable'), 'inactive')
        set(handles.Down, 'Enable', 'on');
    end


axes(handles.axes1);
imshow(handles.Image(current_image_nr).I);
axes(handles.axes2);
imshow(handles.image_p(current_image_nr).I);

% Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement.
function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

thresholdValue = get(hObject, 'Value');
current_image_nr = str2double(get(handles.current_image, 'String'));
image_BW = threshold(handles.Image(current_image_nr).I, thresholdValue); %thresholding the image

handles.parameters(current_image_nr).thresholdValue = thresholdValue;

handles.image_BW(current_image_nr).I = image_BW;
% Update handles structure
guidata(hObject, handles);

axes(handles.axes1);
imshow(handles.image_BW(current_image_nr).I);

% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of remove as text
%        str2double(get(hObject,'String')) returns contents of remove as a double

removeValue = str2double(get(handles.remove, 'String'));
current_image_nr = str2double(get(handles.current_image, 'String'));
image_BW_remove = remove(handles.image_BW(current_image_nr).I, removeValue); %thicken the image
handles.parameters(current_image_nr).removeValue = removeValue;
handles.image_BW(current_image_nr).I = image_BW_remove;
% Update handles structure
guidata(hObject, handles);

axes(handles.axes1);
imshow(image_BW_remove);

% --- Executes during object creation, after setting all properties.
function remove_CreateFcn(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thicken_Callback(hObject, eventdata, handles)
% hObject    handle to thicken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thicken as text
%        str2double(get(hObject,'String')) returns contents of thicken as a double

thickenValue = str2double(get(handles.thicken, 'String'));
current_image_nr = str2double(get(handles.current_image, 'String'));

image_BW_remove_thicken = thicken(handles.image_BW(current_image_nr).I, thickenValue); %thicken the image

handles.parameters(current_image_nr).thickenValue = thickenValue;

handles.image_BW(current_image_nr).I = image_BW_remove_thicken;
% Update handles structure
guidata(hObject, handles);

axes(handles.axes1);
imshow(image_BW_remove_thicken);

% --- Executes during object creation, after setting all properties.
function thicken_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thicken (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nr = str2double(get(handles.image_nr, 'String'));
h = waitbar(0,'Please wait...');


for q = 1:nr

    steps = q;
    waitbar(steps/nr)
    

    
[D, image_bw, s, imax_Nall, adhesion, Dr, Dm] = ...
             run(handles.image_BW(q).I, handles.image_p(q).I);  

handles.image_bw(q).I = image_bw;

Mask = bwconncomp(handles.image_bw(q).I);
handles.image_labled(q).I = labelmatrix(Mask);
handles.image_labled(q).I = label2rgb(handles.image_labled(q).I);

handles.D(q).I= D;
handles.D(q).nrFA = s;
handles.D(q).pSites = imax_Nall;
handles.D(q).adhesion = adhesion;
handles.D(q).Dr = Dr; 
handles.D(q).Dm = Dm;

end

close(h);
waitbar(1, 'Done');

Path = handles.Path;

for s = 1:nr;
name = handles.Image_name.I(s).I;
name = strrep(name, Path, '');
str{s}= name;
set(handles.listbox, 'String', str);
end;


% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on selection change in listbox.

nr = str2double(get(handles.image_nr, 'String'));

for q = 1:nr

[nrows, ncols] = size(handles.D(q).I);
ImageName = handles.Image_name.I(q).I;
filename = strrep(ImageName, '.jpg','.txt');
fid = fopen(filename, 'w');

for row = 1:nrows
    fprintf(fid, '%f \n', handles.D(q).I(row,:)');
end

fclose(fid);
end;

for q = 1:nr

[nrows, ncols] = size(handles.D(q).adhesion);
ImageName = handles.Image_name.I(q).I;
filename = strrep(ImageName, '.jpg', '_FA_size.txt');
fid = fopen(filename, 'w');

for row = 1:size(handles.D(q).adhesion.size, 2)
    fprintf(fid, '%f \t', handles.D(q).adhesion.size(row));
    fprintf(fid, '%f \t \n', handles.D(q).adhesion.peak_count(row));
end

fclose(fid);
end;

% for q = 1:nr
% 
% newimageName = strrep(handles.Image_name.I(q).I,'.jpg','_colorMapped.jpg');
% imwrite(handles.image_labled(q).I,newimageName);
% 
% end
% for q = 1:nr
%     
% ImageName = handles.Image_name.I(q).I;
% filename = strrep(ImageName, '.jpg', '_size_small.txt');
% fid = fopen(filename, 'w');
% 
% for row = 1:nrows
%     fprintf(fid, '%f \n', handles.D(q).Dr.small(row,:)');
% end
% 
% fclose(fid);
% end;
% 
% for q = 1:nr
%     
% ImageName = handles.Image_name.I(q).I;
% filename = strrep(ImageName, '.jpg', '_size_large.txt');
% fid = fopen(filename, 'w');
% 
% for row = 1:nrows
%     fprintf(fid, '%f \n', handles.D(q).Dr.large(row,:)');
% end
% 
% fclose(fid);
% end;
% 
% for q = 1:nr
%     
% ImageName = handles.Image_name.I(q).I;
% filename = strrep(ImageName, '.jpg', '_prom.txt');
% fid = fopen(filename, 'w');
% 
% for row = 1:nrows
%     fprintf(fid, '%f \n', handles.D(q).Dr.prom(row,:)');
% end
% 
% fclose(fid);
% end;
% for q = 1:nr
%     
% ImageName = handles.Image_name.I(q).I;
% filename = strrep(ImageName, '.jpg', '_int.txt');
% fid = fopen(filename, 'w');
% 
% for row = 1:nrows
%     fprintf(fid, '%f \n', handles.D(q).Dr.int(row,:)');
% end
% 
% fclose(fid);
% end;

for q = 1:nr
    
ImageName = handles.Image_name.I(q).I;
filename = strrep(ImageName, '.jpg', '_width.txt');
fid = fopen(filename, 'w');

for row = 1:nrows
    fprintf(fid, '%f \n', handles.D(q).Dr.width(row,:)');
end

fclose(fid);
end;

function listbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox


% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in show.
function show_Callback(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = get(handles.listbox, 'Value');

axes(handles.axes1);
imshow(handles.image_bw(a).I);
axes(handles.axes2);
imshow(handles.image_p(a).I);

axes(handles.axes3);
xvalues = 100:100:1000;
[bincounts, ind] = histc(handles.D(a).I, xvalues);
x = numel(bincounts)/10;
if x > 1;
bincounts = bincounts(:,:,1)+bincounts(:,:,2);
end;
bar(xvalues,bincounts);
xlim([0 xvalues(end)]);
xlabel('Period range, nm');

dist_Mx = max(handles.D(a).dist);
axes(handles.axes4);
xvalues = 1000:2000:dist_Mx+1000;
[bincounts, ind] = histc(handles.D(a).dist, xvalues);
bar(xvalues,bincounts);
xlim([0 xvalues(end)]);
xlabel('Size range, nm');

nrFA = handles.D(a).nrFA;
pSites = round(mean(handles.D(a).pSites));
set(handles.nrFA, 'String', nrFA);
set(handles.mean_pSites, 'String', pSites);

function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double

handles.values.max = 1000*str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min as text
%        str2double(get(hObject,'String')) returns contents of min as a double

handles.values.min = 1000*str2double(get(hObject,'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in run_range.
function run_range_Callback(hObject, eventdata, handles)
% hObject    handle to run_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save_minima.
function save_minima_Callback(hObject, eventdata, handles)
% hObject    handle to save_minima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nr = str2double(get(handles.image_nr, 'String'));

for q = 1:nr

[nrows, ncols] = size(handles.D(q).Dm);
ImageName = handles.Image_name.I(q).I;
ImageName = strrep(ImageName, '_c1.jpg', '_minima');
ImageName = strrep(ImageName, '_c2.jpg', '_minima');
ImageName = strrep(ImageName, '_c3.jpg', '_minima');
filename = strcat(ImageName, '.txt');
fid = fopen(filename, 'w');

for row = 1:nrows
    fprintf(fid, '%f \n', handles.D(q).Dm(row,:)');
end

fclose(fid);
end;
