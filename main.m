clc
clear
close all

% Synthetic experimental data
X = [100 2;
     200 2;
     100 6;
     200 6;
     150 4;
     125 3];

y = [64.1; 73.9; 71.9; 82.1; 73.0; 68.5];

% Significance level
alpha = 0.05;

% Fit the regression model
[beta, confidenceIntervals, R2, R2_adjusted] = regfit(X, y, alpha);

% Display regression results
fprintf('\n========================================\n');
fprintf('         REGRESSION RESULTS\n');
fprintf('========================================\n');

% Display estimated coefficients
fprintf('\nEstimated coefficients:\n');
fprintf('Intercept:       %12.6f\n', beta(1));

for i = 2:length(beta)
    fprintf('Beta(%d):         %12.6f\n', i-1, beta(i));
end

% Display regression equation
fprintf('\nEstimated regression equation:\n');
fprintf('Y = %.6f', beta(1));

for i = 2:length(beta)
    fprintf(' %+.6f*X%d', beta(i), i-1);
end

fprintf('\n');

% Display confidence intervals
fprintf('\nConfidence intervals (%.1f%%):\n', 100*(1-alpha));
fprintf('%-15s %12s %12s\n', 'Coefficient', 'Lower', 'Upper');

for i = 1:length(beta)
    if i == 1
        name = 'Intercept';
    else
        name = sprintf('Beta(%d)', i-1);
    end

    fprintf('%-15s %12.6f %12.6f\n', ...
        name, confidenceIntervals(i,1), confidenceIntervals(i,2));
end

% Display goodness-of-fit metrics
fprintf('\nGoodness of fit:\n');
fprintf('R-squared:           %.6f\n', R2);
fprintf('Adjusted R-squared:  %.6f\n', R2_adjusted);

% Evaluate new points
X0 = [175 5;
      150 3];

y0 = regval(beta, X0);

% Display predictions
fprintf('\n========================================\n');
fprintf('             PREDICTIONS\n');
fprintf('========================================\n');

fprintf('%10s %10s %15s\n', 'X1', 'X2', 'Predicted Y');

for i = 1:size(X0,1)
    fprintf('%10.2f %10.2f %15.6f\n', ...
        X0(i,1), X0(i,2), y0(i));
end

fprintf('========================================\n');
