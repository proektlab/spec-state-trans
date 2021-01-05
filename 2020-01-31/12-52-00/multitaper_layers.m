%% set dataset info

sr_dirs = prepSR;

recdate = '2020-01-31';
time = '12-52-00';

savedir = fullfile(sr_dirs.results, recdate, time);

data_s = load(fullfile(sr_dirs.processed_lfp, sprintf('meanSub_%s_%s.mat', recdate, time)));

%% do low-resolution analysis first

options = struct;

% can't use channels 1 or 33 b/c they're all NaN
% chans 2-4 have an artifact from 5395-5397
options.artifacts = [5395, 5397];
options.chans = [2, 9, 24, 34, 41, 56];
% fix for new organize_lfp behavior
options.chans = struct('Probe2', options.chans(1:3), 'Probe1', options.chans(4:6) - 32);
options.chan_names = {'V1_L2/3', 'V1_L4', 'V1_L5', 'M1_L2/3', 'M1_L4', 'M1_L5'};

options.save = false;

mt_res_lores = multitaper_analysis(data_s, options);

% plot to check
plot_options = struct;
plot_options.pxx_name = 'pxx';
plot_options.take_log = true;

plot_multitaper(mt_res_lores, plot_options);

%% do high-res analysis

% smaller window
options.window = 6;
options.padbase = 60; % use padding as if it were 60 seconds
options.winstep = 0.1;

options.save = true;
options.savedir = savedir;
options.filename = 'mt_res_layers.mat';

mt_res = multitaper_analysis(data_s, options);

%% plot

plot_multitaper(mt_res, plot_options);
