% 3.6
（a）
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("m-mrk4603.txt",header=FALSE)
> SimpleReturn<-ts(df$V2)
> LnReturn<-log(SimpleReturn+1)
> Acf(LnReturn)
> Box.test(LnReturn,lag=20,type=c("Ljung-Box")) 存在序列相关
> Pacf(LnReturn) 决定均值方程为AR(1)
> MeanEquation<-arima(LnReturn,order=c(1,0,0))
> summary(MeanEquation)
> ResidualsForME<-residuals(MeanEquation)
> Acf(ResidualsForME)
> Box.test(ResidualsForME,lag=20,type=c("Ljung-Box")) 残差无序列相关
（b）
> Residuals2ForME<-ResidualsForME*ResidualsForME
> Box.test(Residuals2ForME,lag=6,type=c("Ljung-Box"))
> Box.test(Residuals2ForME,lag=12,type=c("Ljung-Box"))
（c）
> Pacf(Residuals2ForME,lag.max = 50) 确定波动率方程的阶数
> spec <- ugarchspec(
+     variance.model = list(model = "sGARCH", garchOrder = c(3, 0)),
+     mean.model = list(armaOrder = c(1, 0)),
+     distribution.model = "norm"
+ )
> fit <- ugarchfit(spec = spec, data = ResidualsForME)
> fit
拟合的波动率方程有点奇怪 只有截距和滞后三期项系数显著 可以试试改变滞后阶数和改用GARCH模型（比如spec中的garchOrder改为c(1,1)）
