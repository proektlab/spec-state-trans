%% set dataset info

prepSR;

recdate = '2020-01-30';
time = '16-03-00';

savedir = fullfile(results_dir, recdate, time);

%% load and do analysis

data_s = load(fullfile(processed_lfp_dir, sprintf('meanSub_%s_%s.mat', recdate, time)));

options = struct;
options.savedir = savedir;
options.artifacts = [6074, 6077];

% smaller window
options.window = 6;
options.padbase = 60; % use padding as if it were 60 seconds
options.winstep = 0.1;

mt_res = multitaper_analysis(data_s, options);

%% plot

plot_options = struct('savedir', savedir);

plot_multitaper(mt_res, plot_options);

%% after PCA analysis: plot/save PCA change

pca_change('mt_res.mat');