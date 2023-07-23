mediation_feature_selection <- function(dataframe,exposure,mediator,outcome,cov){
  if("None"%in%cov){
    E_M_O <- as.data.frame(array(dim = c(length(exposure)*length(mediator),13)))
    colnames(E_M_O) <- c("exposure","mediator","outcome","E_M_estimates","E_M_p","M_O_estimates","M_O_p","E_O_estimates","E_O_p","Mediation_estimates","Mediation_p","Reverse_Mediation_estimates","Reverse_Mediation_p")
    k <- 1
    for (i in c(1:length(exposure))) {
      for (j in c((length(exposure)+1):(length(exposure)+length(mediator)))) {
        temp <- dplyr::select(dataframe,c(exposure,mediator,outcome))
        temp <- temp[which(is.na(temp[,i])==F),]
        temp <- temp[which(is.na(temp[,j])==F),]
        temp <- temp[which(is.na(temp[,(length(exposure)+length(mediator)+1)])==F),]
        #正向
        fomula=paste(colnames(temp)[j],"~",colnames(temp)[i],sep = "")
        modelx <- lm(fomula,data = temp)
        fomula=paste(outcome,"~",colnames(temp)[i],"+",colnames(temp)[j],sep = "")
        modely <- lm(fomula,data = temp)
        set.seed(123456)
        media_res <- mediation::mediate(modelx,modely,sims = 100, treat = colnames(temp)[i],mediator =colnames(temp)[j],boot =F)
        E_M_O$Mediation_estimates[k] <- media_res$n.avg
        E_M_O$Mediation_p[k] <- media_res$n.avg.p
        #反向
        fomula=paste(colnames(temp)[j],"~",outcome,sep = "")
        modelx <- lm(fomula,data = temp)
        fomula=paste(colnames(temp)[i],"~",outcome,"+",colnames(temp)[j],sep = "")
        modely <- lm(fomula,data = temp)
        set.seed(123456)
        media_res <- mediation::mediate(modelx,modely,sims = 100, treat = outcome,mediator =colnames(temp)[j],boot =F)
        E_M_O$Reverse_Mediation_estimates[k] <- media_res$n.avg
        E_M_O$Reverse_Mediation_p[k] <- media_res$n.avg.p
        #E-M
        fomula=paste(colnames(temp)[j],"~",colnames(temp)[i],sep = "")
        model <- lm(fomula,data = temp)
        E_M_O$E_M_estimates[k] <- coef(summary(model))[2,1]
        E_M_O$E_M_p[k] <- coef(summary(model))[2,4]
        #M-O
        fomula=paste(outcome,"~",colnames(temp)[j],sep = "")
        model <- lm(fomula,data = temp)
        E_M_O$M_O_estimates[k] <- coef(summary(model))[2,1]
        E_M_O$M_O_p[k] <- coef(summary(model))[2,4]
        #E-O
        fomula=paste(outcome,"~",colnames(temp)[i],sep = "")
        model <- lm(fomula,data = temp)
        E_M_O$E_O_estimates[k] <- coef(summary(model))[2,1]
        E_M_O$E_O_p[k] <- coef(summary(model))[2,4]
        #变量名
        E_M_O$exposure[k] <- colnames(temp)[i]
        E_M_O$mediator[k] <- colnames(temp)[j]
        E_M_O$outcome[k] <- outcome
        k <- k+1
      }
    }
  }else if(!("None"%in%cov)) {
    E_M_O <- as.data.frame(array(dim = c(length(exposure)*length(mediator),13)))
    colnames(E_M_O) <- c("exposure","mediator","outcome","E_M_estimates","E_M_p","M_O_estimates","M_O_p","E_O_estimates","E_O_p","Mediation_estimates","Mediation_p","Reverse_Mediation_estimates","Reverse_Mediation_p")
    k <- 1
    for (i in c(1:length(exposure))) {
      for (j in c((length(exposure)+1):(length(exposure)+length(mediator)))) {
        temp <- dplyr::select(dataframe,c(exposure,mediator,outcome,cov))
        temp <- temp[which(is.na(temp[,i])==F),]
        temp <- temp[which(is.na(temp[,j])==F),]
        temp <- temp[which(is.na(temp[,(length(exposure)+length(mediator)+1)])==F),]
        cov_sum <- paste(cov, collapse = "+")
        #正向
        fomula=paste(colnames(temp)[j],"~",colnames(temp)[i],"+",cov_sum,sep = "")
        modelx <- lm(fomula,data = temp)
        fomula=paste(outcome,"~",colnames(temp)[i],"+",colnames(temp)[j],"+",cov_sum,sep = "")
        modely <- lm(fomula,data = temp)
        set.seed(123456)
        media_res <- mediation::mediate(modelx,modely,sims = 100, treat = colnames(temp)[i],mediator =colnames(temp)[j],boot =F)
        E_M_O$Mediation_estimates[k] <- media_res$n.avg
        E_M_O$Mediation_p[k] <- media_res$n.avg.p
        #反向
        fomula=paste(colnames(temp)[j],"~",outcome,"+",cov_sum,sep = "")
        modelx <- lm(fomula,data = temp)
        fomula=paste(colnames(temp)[i],"~",outcome,"+",colnames(temp)[j],"+",cov_sum,sep = "")
        modely <- lm(fomula,data = temp)
        set.seed(123456)
        media_res <- mediation::mediate(modelx,modely,sims = 100, treat = outcome,mediator =colnames(temp)[j],boot =F)
        E_M_O$Reverse_Mediation_estimates[k] <- media_res$n.avg
        E_M_O$Reverse_Mediation_p[k] <- media_res$n.avg.p
        #E-M
        fomula=paste(colnames(temp)[j],"~",colnames(temp)[i],"+",cov_sum,sep = "")
        model <- lm(fomula,data = temp)
        E_M_O$E_M_estimates[k] <- coef(summary(model))[2,1]
        E_M_O$E_M_p[k] <- coef(summary(model))[2,4]
        #M-O
        fomula=paste(outcome,"~",colnames(temp)[j],"+",cov_sum,sep = "")
        model <- lm(fomula,data = temp)
        E_M_O$M_O_estimates[k] <- coef(summary(model))[2,1]
        E_M_O$M_O_p[k] <- coef(summary(model))[2,4]
        #E-O
        fomula=paste(outcome,"~",colnames(temp)[i],"+",cov_sum,sep = "")
        model <- lm(fomula,data = temp)
        E_M_O$E_O_estimates[k] <- coef(summary(model))[2,1]
        E_M_O$E_O_p[k] <- coef(summary(model))[2,4]
        #变量名
        E_M_O$exposure[k] <- colnames(temp)[i]
        E_M_O$mediator[k] <- colnames(temp)[j]
        E_M_O$outcome[k] <- outcome
        k <- k+1
      }
    }
  }
  E_M_O <- E_M_O[order(E_M_O$Mediation_p,decreasing = T),]
  E_M_O$Mediation_p_adjust <- p.adjust(E_M_O$Mediation_p,method = "BH")
  E_M_O <- E_M_O[order(E_M_O$Reverse_Mediation_p,decreasing = T),]
  E_M_O$Reverse_Mediation_p_adjust <- p.adjust(E_M_O$Reverse_Mediation_p,method = "BH")
  E_M_O <- E_M_O[order(E_M_O$Mediation_p_adjust,decreasing = T),]
  return(E_M_O)
}
