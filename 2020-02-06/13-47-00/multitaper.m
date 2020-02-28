%% load data

prepSR;
data_s = load(fullfile(processed_lfp_dir, 'meanSub_2020-02-06_13-47-00.mat'));

%% do analysis

len_secs = size(data_s.meanSubFullTrace, 2) / data_s.finalSampR;

options = struct;
options.artifacts = [
    1387, 1391
    5050, len_secs % (to end of recording)
    ];

% use different channels to match other recording on same day
options.chans = [18, 47];

% try smaller window
options.window = 6;
options.padbase = 60; % use padding as if it were 60 seconds
options.winstep = 0.1;

mt_res = multitaper_analysis(data_s, options);


%% plot

plot_multitaper(mt_res);