corr <- function(directory, threshold = 0) {
  id <- 1:332
  output <- rep(0,332)
  for (station in id) {
    #load dataset
    dataset <- read.csv(sprintf("%s/%003.0f.csv",directory,station))
    goodObs <- (complete.cases(dataset$sulfate,dataset$nitrate))
    nobs <- sum(goodObs)
    if (nobs > threshold) {
      output[station] <- cor(dataset$nitrate[goodObs],dataset$sulfate[goodObs])
    } else {
      output[station] <- NA
    }
  }
  output <- output[!is.na(output)]
  return(output) 
}