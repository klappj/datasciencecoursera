pollutantmean <- function(directory, pollutant, id = 1:332) {
  outputVector <- rep(NA,length(id))
  nitrate <- numeric()
  sulfate <- numeric()
  for (station in id) {
    #load dataset
    dataset <- read.csv(sprintf("%s/%003.0f.csv",directory,station))
    nitrate <- c(nitrate,dataset$nitrate)
    sulfate <- c(sulfate, dataset$sulfate)
  }
  if (pollutant=="nitrate") return(mean(nitrate,na.rm=TRUE))
  if (pollutant=="sulfate") return(mean(sulfate,na.rm=TRUE))
}