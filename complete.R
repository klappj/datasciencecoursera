complete <- function(directory, id = 1:332) {
  output <- NULL
  for (station in id) {
    #load dataset
    dataset <- read.csv(sprintf("%s/%003.0f.csv",directory,station))
    nobs <- sum(complete.cases(dataset$sulfate,dataset$nitrate))
    output <- rbind(output, data.frame(station, nobs))
  }
  colnames(output) <-  c("id","nobs")
  return(output)
}