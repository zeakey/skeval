function skeval_demo(sk_dir, gt_dir)
% Demo of skeleton detection evaluation
% number of threshhold to generate precision-recall curve
% input:
% sk_dir: directory containing the detected skeleton maps
% gt_dir: directory of groundtruth
addpath(genpath('Util'));
addpath(genpath('nonmax'));
opts.nthresh = 100;
% specify where to save the results txt files
opts.score_path = 'scores_txt';
if ~exist(opts.score_path, 'dir'), mkdir(opts.score_path);end
if nargin == 0
  % ground-truth directory
  gt_dir = fullfile('data/tiny-SK-LARGE/');
  % detection result directory
  sk_dir = fullfile('data/sk-results/tiny-fsds');
elseif nargin == 1
  gt_dir = fullfile('data/SK-LARGE/groundTruth/test');
end
% method, the generated txt files named after method.
[~, opts.method] = fileparts(sk_dir);
if ~exist(fullfile(opts.score_path, [opts.method, '_pr.txt']), 'file') || ...
   ~exist(fullfile(opts.score_path, [opts.method, '_score.txt']), 'file') || ...
   ~exist(fullfile(opts.score_path, [opts.method, '_scores.txt']), 'file')
    items = dir(fullfile(gt_dir, '*.mat'));
    items = {items.name};
    gts = cell(1,length(items));
    dets = cell(1,length(items));
    assert(~isempty(items));
    for i=1:length(items)
       [~, fn, ~] = fileparts(items{i});
       gt = load(fullfile(gt_dir, [fn '.mat']));
       gt = logical(gt.symmetry);
       det = single(imread(fullfile(sk_dir, [fn '.png'])));
       if size(det, 3) ~= 1
           det = squeeze(sum(det(2:end, :, :), 1));
       end
       det = det / max(det(:));
       gts{i} = gt;
       dets{i} = det;
    end

    best_f = skeval(dets, gts, opts);
end
pr = dlmread(fullfile(opts.score_path, [opts.method, '_pr.txt']));
figure(1);
F = pr(:, end);
[maxF, maxF_id] = max(F);
disp(['--------ODS=', num2str(maxF), '--------']);
pr = pr(:, 2:3);
figure(1); 
grid on;
plot(pr(:,1), pr(:,2), 'r-', 'Linewidth', 3); hold on;
plot(pr(maxF_id, 1), pr(maxF_id, 2), 'g*', 'Linewidth', 6);
xlabel('Recall');
ylabel('Precision');
title(['Precision-Recall of ', opts.method]);
end % end of function