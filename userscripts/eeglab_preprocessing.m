% close all; clc;

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab;

%% Load dataset 
EEG = pop_loadset('filename','S008_L_vs_R_hand.set', ...
                  'filepath','D:\BTU-Cottbus\4. Semester\BCI\BCI4NAT Seminar Final Report + Datasets\drive-download-20250811T133553Z-1-001');
[ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, 0);

%% Filter data (1?30 Hz bandpass)
EEG = pop_eegfiltnew(EEG, 'locutoff', 1, 'hicutoff', 30);
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', 'filtered', 'gui', 'off');

%% Re-reference to average
EEG = pop_reref(EEG, []);
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 2, 'setname', 'avg_ref', 'gui', 'off');

%% ICA 
EEG = pop_runica(EEG, 'icatype','runica','extended',1,'interrupt','off');
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 3, 'setname', 'avg_ref_ica', 'gui', 'off');

%% (Optional) View ICA component topographies
pop_viewprops(EEG, 0, 1:64); % Opens ICA component plots for manual inspection

%% Remove selected ICA components 
EEG = pop_subcomp(EEG, [1 2 3 16 44], 0);
[ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);

%% Create epochs for Left (T1) and Right (T2)
baseEEG = EEG;  % filtered + reref + ICA continuous data

% Left-hand (T1)
EEG = pop_epoch(baseEEG, {'T1'}, [-1 4], 'newname', 'epochs_L', 'epochinfo', 'yes');
EEG = pop_rmbase(EEG, [-1000 0]);
[ALLEEG, EEG, indL] = pop_newset(ALLEEG, EEG, CURRENTSET + 1, 'setname', 'epochs_L_bc', 'gui', 'off');

% Right-hand (T2)
EEG = pop_epoch(baseEEG, {'T2'}, [-1 4], 'newname', 'epochs_R', 'epochinfo', 'yes');
EEG = pop_rmbase(EEG, [-1000 0]);
[ALLEEG, EEG, indR] = pop_newset(ALLEEG, EEG, CURRENTSET + 1, 'setname', 'epochs_R_bc', 'gui', 'off');

%% Plot ERP overlay for Left vs Right (all channels)
% Tip: In the ERP plot window, click on channels Cz, C3, and C4 
%      to inspect the motor imagery-related differences.
pop_comperp(ALLEEG, 1, indL, indR, ...
    'addavg','on', 'diffavg','on', 'subavg','on', ...
    'addstd','off', 'diffstd','off', ...
    'tplotopt', {'ydir', -1});

eeglab redraw;

% %% Save workspace (optional)
% save('EEG_MI_workspace_withICA.mat');


