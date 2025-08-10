3.11
(a)
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("d-gmsp9303.txt",header=FALSE)
> SimpleReturnGM<-ts(df$V2)
> LnReturnGM<-log(SimpleReturnGM+1)
> MeanOfGM<-mean(LnReturnGM)
> GM_a<-LnReturnGM-MeanOfGM
> Acf(GM_a)
> GM_a2<-GM_a*GM_a
> Acf(GM_a2)
> Box.test(GM_a,lag=10,type=c("Ljung-Box"))
> Box.test(GM_a2,lag=10,type=c("Ljung-Box"))
(b)
> Pacf(GM_a2,lag.max=15)  大概到滞后5阶
(c)
> MySpec1<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
                                          mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
                                          distribution.model = "norm")
> MyFit1<-ugarchfit(spec=MySpec1, data=LnReturnGM)
> MyFit1
(d)
> MySpec2<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
                     mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
                     distribution.model = "ged")
> MyFit2<-ugarchfit(spec=MySpec2, data=LnReturnGM)
> MyFit2
