function y = regval(beta, X0)
% REGVAL Evaluates a fitted regression model at new points.
% beta: Regression coefficient vector returned by REGFIT.
% X0: New predictor matrix, excluding the intercept.

if ~isnumeric(beta) || ~isreal(beta) || ~isvector(beta) || ...
        isempty(beta) || any(~isfinite(beta(:)))
    error('beta must be a nonempty, finite, real numeric vector.');
end

if ~isnumeric(X0) || ~isreal(X0) || ~ismatrix(X0) || ...
        any(~isfinite(X0(:)))
    error('X0 must be a finite, real numeric matrix.');
end

beta = beta(:);

if size(X0, 2) ~= numel(beta) - 1
    error('The number of columns in X0 must match the number of predictors used in REGFIT.');
end

X0 = [ones(size(X0, 1), 1), X0];

y = X0 * beta;

end