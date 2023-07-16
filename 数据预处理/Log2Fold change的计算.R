foldChange<-function(inData,classLabel,case,control){
  sampleIdsCase<-which(classLabel==case)
  sampleIdsControl<-which(classLabel==control)
  probeFC<-rep(0,nrow(inData))
  for(i in 1:nrow(inData)){
    probeFC[i]<-mean(as.numeric(inData[i,sampleIdsCase]),na.rm = T)/mean(as.numeric(inData[i,sampleIdsControl]),na.rm = T)
  }
  probeFC<-log(probeFC,base=2)
  result<-probeFC
  result <- data.frame(Features=rownames(inData),log2FC=result)
  return(result)
}
