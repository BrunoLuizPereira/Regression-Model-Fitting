function [beta, confidenceIntervals, R2, R2_adjusted] = regfit(X, y, alpha)
% REGFIT Fits a multiple linear regression model.
% X: Predictor matrix, excluding the intercept.
% y: Response vector.
% alpha: Significance level (default: 0.05).

if nargin < 3
    alpha = 0.05;
end

if ~isnumeric(X) || ~isreal(X) || isempty(X) || ~ismatrix(X) || ...
        any(~isfinite(X(:)))
    error('X must be a nonempty, finite, real numeric matrix.');
end

if ~isnumeric(y) || ~isreal(y) || ~isvector(y) || isempty(y) || ...
        any(~isfinite(y(:)))
    error('y must be a nonempty, finite, real numeric vector.');
end

if numel(y) ~= size(X, 1)
    error('The number of elements in y must match the number of rows in X.');
end

if ~isnumeric(alpha) || ~isreal(alpha) || ~isscalar(alpha) || ...
        ~isfinite(alpha) || alpha <= 0 || alpha >= 1
    error('alpha must be a finite scalar between 0 and 1.');
end

y = y(:);
[n, ~] = size(X);

X = [ones(n, 1), X];
p = size(X, 2);

if n <= p
    error('The number of observations must exceed the number of coefficients.');
end

if rank(X) < p
    error('The design matrix is rank deficient.');
end

XtXinv = (X' * X)^(-1);
beta = XtXinv * X' * y;

yFit = X * beta;
residuals = y - yFit;

SSE = sum(residuals.^2);
SST = sum((y - mean(y)).^2);

df = n - p;
sigma2 = SSE / df;

covBeta = sigma2 * XtXinv;
standardErrors = sqrt(diag(covBeta));
tCritical = tinv(1 - alpha / 2, df);

confidenceIntervals = ...
    [beta - tCritical * standardErrors, ...
    beta + tCritical * standardErrors];

if SST > 0
    R2 = 1 - SSE / SST;
    R2_adjusted = 1 - (1 - R2) * (n - 1) / df;
else
    R2 = NaN;
    R2_adjusted = NaN;
end

end