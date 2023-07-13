spearman_feature_selection <- function(dataframe,outcome,exposure){
  temp <- dplyr::select(dataframe,c(outcome,exposure))
  results_summary <- NULL
  for (i in c(length(outcome):ncol(temp))) {
    temp_results <- cor.test(temp[,outcome],temp[,i],method = "spearman")
    Estimate <- temp_results$estimate
    p_value <- temp_results$p.value
    temp_summary <- data.frame(Exposure=colnames(temp)[i],Outcome=outcome,Estimate=Estimate,P_value=p_value)
    results_summary <- rbind(results_summary,temp_summary)
  }
  results_summary <- results_summary[order(results_summary$P_value,decreasing = F),]
  results_summary$FDR <- p.adjust(results_summary$P_value,method = "BH")
  return(results_summary)
}
