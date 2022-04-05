# SYDE572 Pattern Recognition
##### Winter 2022 -- Group 26

- See `lab2_manual.pdf` for instructions
- Data for Lab 2 can be found in `lab_2_data/`

### Purpose (from lab manual)
This lab examines the areas of statistical model estimation and classifier aggregation. Model estimation will be performed by implementing parametric and non-parametric estimators. Aggregation is introduced by combining several simple linear discriminants into one more powerful classifier.

### Model Estimation 1-D case
- See `lab_2_code/model_estimation_1d.m`
- Adjust the `TESTS_TO_RUN` variable to set which scenarios to execute:

1. Parametric estimation -- Gaussian
2. Parametric estimation -- Exponential
3. Parametric estimation -- Uniform
4. Non-parametric estimation

### Model Estimation 2-D case
- See `lab_2_code/model_estimation_2d.m`
- Adjust the `TESTS_TO_RUN` variable to set which scenarious to execute:

1. Parametric estimation
2. Non-parametric estimation

### Sequential Discriminants
- See `lab_2_code/sequential_discriminants.m`
    - Note that task 2 may fail occassionally. As far as we could tell through debugging, this is a transient error, possibly caused by memory issues when learning 20 classifiers. Re-running the program should resolve the issue.
- Adjust the `TESTS_TO_RUN` variable to set which scenarious to execute:

1. Learn & plot 3 linear discriminants
2. Learn a variable number of linear discriminants & display statistics
