# Contents  
- [广义线性模型变量筛选](#广义线性模型变量筛选)  
- [斯皮尔曼相关性筛选](#斯皮尔曼相关性筛选)  
- [Contributors](#contributors)  
- [Release History](#release-history)


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
- **exposure**: The name of exposure feature, such as "Species1","Species2" or c("gene1","gene2").

### Examples
```R
source("斯皮尔曼相关性筛选.R")

Species_list <- c("Species1","Species2"......)

Species_was_pathway <- spearman_feature_selection(harmonized,"HBA1C",Species_list)
```
### Output
![Image text](https://github.com/Bingqiye/Tool-box/blob/main/Screenshots/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20230710152507.png)

