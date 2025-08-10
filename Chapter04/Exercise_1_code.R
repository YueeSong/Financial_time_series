4.1
(a)
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh4")
> df<-read.table("d-jnj9003.txt", header=FALSE)
> library(tseries)
> library(forecast)
> SimpleReturn<-ts(df$V2)
> LnReturn<-log(SimpleReturn+1)
> library(rugarch)
> Acf(LnReturn)
> Pacf(LnReturn)
> MySpec1<-ugarchspec(variance.model = list(model="fGARCH", garchOrder=c(1,1), submodel="TGARCH"),
+                     mean.model = list(armaOrder=c(3,0), include.mean=TRUE),
+                     distribution.model = "norm",
+                     fixed.pars = list(ar1=0))
> MyGJR<-ugarchfit(spec=MySpec1, data=LnReturn)
> MyGJR
(b) 这里R中包的限制 无法估计一个自动得到门槛值的模型 只能手动设定门槛 并且只作为外部变量而非交叉项进入方差方程
> threshold<- -0.01
> dummy<- ifelse(LnReturn<threshold, 1, 0)
> MySpec2<- ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1), external.regressors=as.matrix(dummy)),
+                      mean.model = list(armaOrder=c(3,0), include.mean=TRUE),
+                      distribution.model = "norm")
> GeneralTAGRCH<-ugarchfit(spec=MySpec2, data=LnReturn)
> GeneralTAGRCH
