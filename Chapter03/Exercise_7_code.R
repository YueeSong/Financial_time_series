3.7
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("m-3m4603.txt",header = FALSE)
> SimpleReturn<-ts(df$V2)
> LnReturn<-log(SimpleReturn+1)
(a)
> MyMean<-mean(LnReturn)
> Series_a<-LnReturn-MyMean
> Box.test(Series_a,lag=6,type=c("Ljung-Box"))
> Series_a2<-Series_a*Series_a
> Acf(Series_a2)
> Box.test(Series_a2,lag=6,type=c("Ljung-Box"))
> Box.test(Series_a2,lag=12,type=c("Ljung-Box"))
(b)
> LnReturn2<-LnReturn*LnReturn
> Pacf(LnReturn2)  决定波动率的ARCH模型为滞后2阶
> spec <- ugarchspec(
+          variance.model = list(model = "sGARCH", garchOrder = c(2, 0)),
+          mean.model = list(armaOrder = c(0, 0)),
+          distribution.model = "norm"
+      )
> 
> fit <- ugarchfit(spec = spec, data = LnReturn)
> fit
（c）
> NewLnReturn<-LnReturn[1:690]
> spec1 <- ugarchspec(
+               variance.model = list(model = "sGARCH", garchOrder = c(2, 0)),
+             mean.model = list(armaOrder = c(0, 0)),
+             distribution.model = "norm"
+           )
> fit1 <- ugarchfit(spec = spec, data = NewLnReturn)
> fit1
> MyForecast<-ugarchforecast(fit1, n.ahead = 5)
> MyForecast 690开始的未来5期的波动率

(d)
mean.model = list(armaOrder = c(0,0), include.mean = TRUE, archm = TRUE, archpow = 2)
> spec2 <- ugarchspec(
+               variance.model = list(model = "sGARCH", garchOrder = c(2, 0)),
+             mean.model = list(armaOrder = c(0, 0), include.mean = TRUE, archm = TRUE, archpow = 2),
+             distribution.model = "norm"
+           )
> fit2 <- ugarchfit(spec = spec2, data = LnReturn)
> fit2
(e)
> spec3 <- ugarchspec(
+               variance.model = list(model = "eGARCH", garchOrder = c(1, 1)),
+             mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
+             distribution.model = "norm"
+           )
> fit3 <- ugarchfit(spec = spec3, data = LnReturn)
> fit3
> fcst<-ugarchforecast(fit3, n.ahead = 5)
> fcst
