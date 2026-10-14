# Regression Model Fitting

A lightweight MATLAB / Octave implementation for multiple linear regression fitting, statistical analysis, and response prediction.

## Features

- Fit multiple linear regression models with an automatically included intercept.
- Calculate confidence intervals for regression coefficients.
- Compute the coefficient of determination (\(R^2\)) and adjusted \(R^2\).
- Predict responses at new input points.
- Validate input data and detect rank-deficient regression models.

## Repository Contents

| File | Description |
|---|---|
| `regfit.m` | Fits the regression model and returns estimated coefficients, confidence intervals, and goodness-of-fit metrics. |
| `regval.m` | Evaluates the fitted model at new predictor values. |
| `main.m` | Demonstrates model fitting, statistical results, and response prediction. |

## Getting Started

1. Download or clone this repository.
2. Add the repository folder to the MATLAB path.
3. Run `main.m` to execute the example.

## Basic Usage

Fit a regression model:

```matlab
[beta, confidenceIntervals, R2, R2_adjusted] = regfit(X, y);
```

Evaluate new observations:

```matlab
yPredicted = regval(beta, X0);
```

The matrix `X` contains the predictor variables, with one observation per row. The vector `y` contains the corresponding measured responses. The intercept is added automatically.

The matrix `X0` contains the predictor values for the observations to be evaluated. Each row corresponds to one prediction.

The optional `alpha` argument specifies the significance level for coefficient confidence intervals. Its default value is `0.05`, corresponding to 95% confidence intervals.

## Requirements

The functions use MATLAB numerical operations. The current implementation uses `tinv` to calculate confidence intervals, which requires the Statistics and Machine Learning Toolbox.

## License

This project is distributed under the MIT License. See the `LICENSE` file for details.
