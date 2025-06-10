#Microsoft

#Discrete
change <- sample(c(0.898604,-0.75325),size = 13,replace = TRUE,prob = c(0.5181,0.4819))
price <- cumsum(c(41.83,change))
plot(price,xlab = "days",type = "l",ylim=c(200,260))
tail(price,n=1)
results<-0
for(i in 1:1000){
  change <- sample(c(0.898604,-0.75325),size = 13,replace = TRUE,prob = c(0.5181,0.4819))
  price <- cumsum(c(41.83,change))
  results[i]<-tail(price,n=1)
}
results
hist(results)
mean(results)
sd(results)


#Continuous
MSFTm <- 0.00304 #calculated in excel
MSFTv <- 0.0007651 #calculated in excel
xi<-rnorm(13,sd=sqrt(MGMv)) #16 trading days from 3/31 to 4/23
xi
zi = cumsum(c(log(41.83),MSFTv+xi))
si = exp(zi)
plot(si,type = "l")
stockprices<-0
for(i in 1:1000){
  
  xi<-rnorm(13,sd=sqrt(MGMv))
  xi
  zi = cumsum(c(log(41.83),MGMm+xi))
  si = exp(zi)
  
  stockprices[i]<-tail(si,n=1)
}
stockprices
hist(stockprices)
mean(stockprices)
sd(stockprices)

