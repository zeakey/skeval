score_path = 'score-sklarge';
linewidth = 3;

fname = fullfile(score_path, 'Levinshtein_sk1491_pr.txt');
Levinshtein = dlmread(fname);

fname = fullfile(score_path, 'lee_sk1491_pr.txt');
Lee = dlmread(fname); % thresh, r, p, f

fname = fullfile(score_path, 'Lindeberg_sk1491_pr.txt');
Lindeberg = dlmread(fname);

fname = fullfile(score_path, 'mil_sk1491_pr.txt');
MIL = dlmread(fname); % thresh, r, p, f

fname = fullfile(score_path, 'hed_sk1491_pr.txt');
HED = dlmread(fname); % thresh, r, p, f

fname = fullfile(score_path, 'FSDS_sk1491_pr.txt');
FSDS = dlmread(fname); % thresh, r, p, f

fname = fullfile(score_path, 'LMSDS_sk1491_pr.txt');
LMSDS = dlmread(fname); % thresh, r, p, f

figure(1); clf; hold on; box on, grid on;
title('SK-LARGE')
set(gca, 'Fontsize', 12);
set(gca, 'XTick', [0.25 0.5 0.75 1]);
set(gca, 'YTick', [0.25 0.5 0.75 1]);
set(gca, 'Xgrid', 'on');
set(gca, 'Ygrid', 'on');
xlabel('Recall'); ylabel('Precision');
axis square;

LMSDS = plot(LMSDS(:,2), LMSDS(:,3), 'm', 'LineWidth',linewidth);
hold on;

FSDS = plot(FSDS(:,2), FSDS(:,3), 'y', 'LineWidth', linewidth);
hold on;

HED = plot(HED(:,2), HED(:,3), 'c', 'LineWidth',linewidth);
hold on;

MIL = plot(MIL(:,2), MIL(:,3), 'k', 'LineWidth',linewidth);
hold on;

Lindeberg = plot(Lindeberg(:,2), Lindeberg(:,3), 'b', 'LineWidth',linewidth);
hold on;

Lee = plot(Lee(:,2), Lee(:,3), 'r', 'LineWidth',linewidth);
hold on;

Levinshtein = plot(Levinshtein(:,2), Levinshtein(:,3), 'g*', 'LineWidth',10);
hold on;

[r_gt,p_gt] = meshgrid(0:0.01:1,0:0.01:1);
f_gt = fmeasure(r_gt,p_gt);
[C,cl] = contour(0:0.01:1,0:0.01:1,f_gt,[0.3,0.4,0.5,0.6,0.73,0.8]);
clabel(C,cl)

legend([LMSDS, FSDS, HED, MIL, Lindeberg, Lee, Levinshtein], ... 
'Location', 'NorthEast', ...
'LMSDS  F=0.649', ...
'FSDS  F=0.633', ...
'HED  F=0.497', ...
'MIL  F=0.353', ...
'Lindeberg  F=0.270', ...
'Lee  F=0.255', ...
'Levinshtein  F=0.243');
