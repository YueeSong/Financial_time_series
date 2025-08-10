4.6
(a)
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh4")
> df1<-read.table("w-gs1yr.txt", header=FALSE)
> df3<-read.table("w-gs3yr.txt", header=FALSE)
> rate1<-ts(df1$V2)
> rate3<-ts(df3$V2)
> Lnr1<-log(rate1+1)
> Lnr3<-log(rate3+1)
> Spread<-Lnr3-Lnr1
> Acf(Spread)
> Pacf(Spread) 
> ARMA<-arima(Spread, order=c(2,0,0))
> Residual<-residuals(ARMA)
> Box.test(Residual, lag=20, type=c("Ljung-Box")) 利差序列去除线性后得到的残差序列仍然不是白噪音，即有非线性因素
> bds.test(Residual) 残差序列也并非iid 意味着非线性存在
(b)
> DiffSpread<-diff(Spread)
> Acf(DiffSpread)
> Pacf(DiffSpread)
> ARMA1<-arima(DiffSpread, order=c(1,0,0))
> Residual1<-residuals(ARMA1)
> Box.test(Residual1, lag=20, type=c("Ljung-Box"))
> bds.test(Residual1)
(c)
> library(tsDyn)
> SETAR1 <- setar(Spread, m = 2, thDelay = 1) 对利差序列直接拟合SETAR模型 m为AR滞后阶数 thDelay=1意味门槛变量为滞后1项
> summary(SETAR1) 其中两个regime的截距都不显著 两个滞后项都显著 门槛值为0.01961
(d)
> SETAR2 <- setar(DiffSpread, m = 2, thDelay = 1)
> summary(SETAR2) 只有一个滞后项是显著的。并且模型的解释上，当利率倒挂，市场认为超跌会使得利差均值回复；当利查正常表现，市场会按照趋势温和扩张
