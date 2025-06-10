#Ford
#Discrete
change <- sample(c(0.30129,-0.19286),size = 16,replace = TRUE,prob = c(0.5254,0.4746))
price <- cumsum(c(12.46,change))
plot(price,xlab = "days",type = "l",ylim=c(9,20))
tail(price,n=1)
results<-0
for(i in 1:1000){
  change <- sample(c(0.30129,-0.19286),size = 16,replace = TRUE,prob = c(0.5254,0.4746))
  price <- cumsum(c(12.46,change))
  results[i]<-tail(price,n=1)
}
results
hist(results)
mean(results)
sd(results)

#continous
Fm <- 0.006442 #calculted by excel
Fv <- 0.000752
stockprices<-0
for(i in 1:1000){
  xi<- rnorm(16,sd = sqrt(BBYv))
  zi<- cumsum(c(log(12.46),BBYm+xi))
  si = exp(zi)  
  stockprices[i]<-tail(si,n=1)
}
hist(stockprices)
mean(stockprices)
sqrt(var(stockprices))
 #as of April 23, the price is 118.17
 #prediction is 13.04
plot(si,type = "l")

