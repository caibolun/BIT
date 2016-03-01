%  CVPR 2013 Tracking Beanchmark (OPE)

clc;
clear;
close all;
gui=1;
base_path = '/home/lab-cai.bolun/Dataset/TrackingBenchmark';
mode = 'all';
tracker_name ='BIT';
addpath(['./' tracker_name]);

%% default settings
if gui==1
    show_visualization = ~strcmp(mode, 'all');
    show_plots = ~strcmp(mode, 'all');
else
    show_visualization = 0;
    show_plots = 0;
end


switch mode
case 'choose',
    %ask the user for the video, then call self with that video name.
    video = choose_video(base_path);
    if ~isempty(video),
        %get image file names, initial state, and ground truth for evaluation
        [img_files, pos, target_sz, ground_truth, video_path] = load_video_info(base_path, video);

        %call tracker function with all the relevant parameters
        [positions, time] = tracker(video_path, img_files, pos, target_sz, show_visualization);

        %calculate and show precision plot, as well as frames-per-second
        precisions = precision_plot(positions, ground_truth, video, show_plots);
        fps = numel(img_files) / time;

        fprintf('%12s - OPE:% 1.3f, FPS:% 4.2f\n', video, precisions(20), fps);
    end


case 'all',
    %all videos, call self with each video name.

    %only keep valid directory names
    dirs = dir(base_path);
    videos = {dirs.name};
    videos(strcmp('.', videos) | strcmp('..', videos) | ...
        strcmp('anno', videos) | ~[dirs.isdir]) = [];

    %the 'Jogging' sequence has 2 targets, create one entry for each.
    %we could make this more general if multiple targets per video
    %becomes a common occurence.
    videos(strcmpi('Jogging', videos)) = [];
    videos(end+1:end+2) = {'Jogging.1', 'Jogging.2'};

    all_precisions = [];  %to compute averages
    all_success = [];
    all_fps = zeros(numel(videos),1);

    %evaluate trackers for all videos in parallel
    if matlabpool('size') == 0, %#ok<DPOOL>
        matlabpool open; %#ok<DPOOL>
    end

    parfor k = 1:numel(videos),
        [img_files, pos, target_sz, ground_truth, video_path] = load_video_info(base_path, videos{k});

        %call tracker function with all the relevant parameters
        [positions, time] = tracker(video_path, img_files, pos, target_sz, show_visualization);

        %calculate and show precision plot, as well as frames-per-second
        precisions = precision_plot(positions, ground_truth, videos{k}, show_plots);

        fps = numel(img_files) / time;
        fprintf('%12s - OPE:% 1.3f, FPS:% 4.2f\n', videos{k}, precisions(20), fps);
        all_precisions=[all_precisions, precisions];
    end
    
    mean_precision = mean(all_precisions,2);
    fprintf('\nOPE:% 1.3f\n\n', mean_precision(20));
    
    if show_plots==1
        mean_precision=[0;mean_precision];
        figure('Number','off', 'Name','Precisions - ALL')
        plot(0:50,mean_precision, 'k-', 'LineWidth',3)
        xlabel('Threshold'), ylabel('Precision')
    end
end
