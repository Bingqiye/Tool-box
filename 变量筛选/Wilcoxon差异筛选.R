wilcoxon_feature_selection <- function(dataframe,group,features){
  temp <- dplyr::select(dataframe,c(group,features))
  results_summary <- NULL
  for (i in c(length(group):ncol(temp))) {
    a <- as.data.frame(table(temp[,group]))
    temp_results <- wilcox.test(temp[,i][which(temp[,group]==a$Var1[1])],temp[,i][which(temp[,group]==a$Var1[2])])
    temp_results <- data.frame(Features=colnames(temp[i]),Group=group,P_value=temp_results$p.value)
    if(median(temp[,i][which(temp[,group]==a$Var1[1])],na.rm = T)>=median(temp[,i][which(temp[,group]==a$Var1[2])],na.rm = T)){
      temp_results$Relation <- paste("High in ",a$Var1[1],sep = "")
    }else if(median(temp[,i][which(temp[,group]==a$Var1[1])],na.rm = T)<median(temp[,i][which(temp[,group]==a$Var1[2])],na.rm = T)){
      temp_results$Relation <- paste("High in group",a$Var1[2],sep = "")
    }
    results_summary <- rbind(results_summary,temp_results)
  }
  results_summary <- results_summary[order(results_summary$P_value,decreasing = F),]
  results_summary$FDR <- p.adjust(results_summary$P_value,method = "BH")
  return(results_summary)
}
