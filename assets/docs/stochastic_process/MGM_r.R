#MGM resorts

#Discrete
change <- sample(c(0.880606,-0.790385),size = 16,replace = TRUE,prob = c(0.5593,0.4407))
price <- cumsum(c(38.21,change))
plot(price,xlab = "days",type = "l",ylim=c(30,45))
tail(price,n=1)
results<-0
for(i in 1:1000){
  change <- sample(c(0.880606,-0.790385),size = 16,replace = TRUE,prob = c(0.5593,0.4407))
  price <- cumsum(c(38.21,change))
  results[i]<-tail(price,n=1)
  }
results
hist(results)
mean(results)
sd(results)


#Continuous
MGMm <- 0.00427 #calculated in excel
MGMv <- 0.0008  #calculated in excel
xi<-rnorm(16,sd=sqrt(MGMv)) #16 trading days from 3/31 to 4/23
xi
zi = cumsum(c(log(38.21),MGMm+xi))
si = exp(zi)
plot(si,type = "l")
stockprices<-0
for(i in 1:1000){
  
  xi<-rnorm(16,sd=sqrt(MGMv))
  xi
  zi = cumsum(c(log(38.21),MGMm+xi))
  si = exp(zi)
  
  stockprices[i]<-tail(si,n=1)
}
stockprices
hist(stockprices)
mean(stockprices)
sd(stockprice)

