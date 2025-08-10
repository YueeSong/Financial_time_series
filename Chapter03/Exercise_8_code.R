3.8
（a）
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("m-gmsp5003.txt",header=FALSE)
> StockSimpleReturn<-ts(df$V2)
> IndexSimpleReturn<-ts(df$V3)
> LnReturnGM<-log(StockSimpleReturn+1)
> MySpec1<-ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
+                     mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
+                     distribution.model = "norm")
> MyFit1<-ugarchfit(spec=MySpec1, data=LnReturnGM)
> MyFit1
（b）
> MySpec2<-ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
+                     mean.model = list(armaOrder = c(0, 0), include.mean = TRUE, archm=TRUE, archpow=2),
+                     distribution.model = "norm")
> MyFit2<-ugarchfit(spec=MySpec2,data=LnReturnGM)
> MyFit2
(c)
> MySpec3withoutV<-ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
+                     mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
+                     distribution.model = "std"
+                     )
> MyFit3withoutV<-ugarchfit(spec=MySpec3withoutV, data=LnReturnGM)
> MyFit3withoutV 这个模型是让估计过程自动确定t分布的自由度 而不手动设定 得到自由度约为8.72 其标准误约为2.5 那么6落在两个标准误区间内 无法拒绝自由度为6的H0
（d）
> MySpec4<-ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1, 1)),
+                     mean.model = list(armaOrder = c(0, 0), include.mean = TRUE),
+                     distribution.model = "norm")
> MyFit4<-ugarchfit(spec=MySpec4, data=LnReturnGM)
> MyFit4
（e)
4个模型的预测对比
> fcst1<-ugarchforecast(MyFit1, n.ahead = 6)
> fcst2<-ugarchforecast(MyFit2, n.ahead = 6)
> fcst3<-ugarchforecast(MyFit3withoutV, n.ahead = 6)
> fcst4<-ugarchforecast(MyFit4, n.ahead = 6)
> fcst1
> fcst2
> fcst3
> fcst4
