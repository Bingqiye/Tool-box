# 广义线性模型变量筛选

## Description
Select features linearly associate with continuous outcome.

## Usage
```R
linear_model_feature_selection(dataframe, outcome, exposure,cov)
```

## Arguments
- **dataframe**: Dataframe with sample IDs as rownames, with feature names as colnames.
- **outcome**: The name of outcome feature, such as "Outcome".
- **exposure**: The name of exposure feature, such as "gene1","gene2" or c("gene1","gene2").
- **cov**: The confounders need to be adjusted in the linear model, such as c("SBP","DBP","TC","TG").

## Examples
```R
source("C:/Users/Dell/Desktop/每日记录/20230704/广义线性模型变量筛选.R")

cov <- c("age","gender","BMI","smoking","drinking","diabetes","hypertension","MET","DD")

lnear_results_summary <- linear_model_feature_selection(target_dataframe,"TAMO",c("TC","TG","HDL"),cov)
```
## Output
