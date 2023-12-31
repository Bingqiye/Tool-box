# Contents  
- [广义线性模型变量筛选](#广义线性模型变量筛选)  
- [斯皮尔曼相关性筛选](#斯皮尔曼相关性筛选)  
- [Wilcoxon差异筛选](#wilcoxon差异筛选)
- [批量中介分析变量筛选](#批量中介分析变量筛选)


## 广义线性模型变量筛选

### Description
Select features linearly associate with continuous outcome.

### Usage
```R
linear_model_feature_selection(dataframe, outcome, exposure,cov)
```

### Arguments
- **dataframe**: Dataframe with sample IDs as rownames, with feature names as colnames.
- **outcome**: The name of outcome feature, such as "Outcome".
- **exposure**: The name of exposure feature, such as "gene1","gene2" or c("gene1","gene2").
- **cov**: The confounders need to be adjusted in the linear model, such as c("SBP","DBP","TC","TG") or "None".

### Examples
```R
source("广义线性模型变量筛选.R")

cov <- c("age","gender","BMI","smoking","drinking","diabetes","hypertension","MET","DD")

lnear_results_summary <- linear_model_feature_selection(target_dataframe,"TAMO",c("TC","TG","HDL"),cov)
```
### Output
![Image text](https://github.com/Bingqiye/Tool-box/blob/main/Screenshots/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20230710152507.png)

---

## 斯皮尔曼相关性筛选

### Description
To use Spearman rank correlation to test the association between two ranked variables.

### Usage
```R
spearman_feature_selection(dataframe, outcome, exposure)
```

### Arguments
- **dataframe**: Dataframe with sample IDs as rownames, with feature names as colnames.
- **outcome**: The name of outcome feature, such as "Outcome".
- **exposure**: The name of exposure feature, such as "Species1","Species2" or c("Species1","Species2").

### Examples
```R
source("斯皮尔曼相关性筛选.R")

Species_list <- c("Species1","Species2"......)

Species_was_pathway <- spearman_feature_selection(harmonized,"HBA1C",Species_list)
```
### Output
![Image text](https://github.com/Bingqiye/Tool-box/blob/main/Screenshots/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20230723112730.png)

---

## Wilcoxon差异筛选

### Description
Select features with different levels on two groups (Case/Control)

### Usage
```R
wilcoxon_feature_selection(dataframe,group,features)
```

### Arguments
- **dataframe**: Dataframe with sample IDs as rownames, with feature names as colnames.
- **group**: The name of group, such as "Diabetes".
- **features**: The name of features, such as "Species1","Species2" or c("Species1","Species2").

### Examples
```R
source("Wilcoxon差异筛选.R")

Species_list <- c("Species1","Species2"......)

Diabetes_was_metabolites <- wilcoxon_feature_selection(harmonized,"Diabetes",Species_list)
```
### Output
![Image text](https://github.com/Bingqiye/Tool-box/blob/main/Screenshots/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20230723154149.png)

---

## 批量中介分析变量筛选

### Description
Select features with mediation analysis.

### Usage
```R
mediation_feature_selection(dataframe,exposure,mediator,outcome,cov)
```

### Arguments
- **dataframe**: Dataframe with sample IDs as rownames, with feature names as colnames.
- **exposure**: The name of exposure features, such as "species1","species2" or c("species1","species2").
- **mediator**: The name of mediator features, such as "pathway1","pathway2" or c("pathway1","pathway2").
- **outcome**: The outcome, such as "BMI".
- **cov**: The confounders need to be adjusted in the linear model, such as c("SBP","DBP","TC","TG") or "None".

### Examples
```R
source("批量中介分析变量筛选.R")

exposure <- c("Species1","Species2"......)

mediator <- c("pathway1","pathway2"......)

cov <- c("Age","Gender"......)

mediation_summary <- mediation_feature_selection(harmonized,exposure = exposure,mediator = mediator,outcome = "BMI",cov = cov)
```
### Output
![Image text](https://github.com/Bingqiye/Tool-box/blob/main/Screenshots/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20230723185318.png)


