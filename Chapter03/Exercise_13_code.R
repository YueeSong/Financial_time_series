3.13
(a)
> SimpleReturnGM<-ts(df$V2)
> MySpec<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
+                    mean.model = list(armaOrder=c(0,0), include.mean=TRUE, archm=TRUE, archpow=2),
+                    distribution.model = "norm")
> MyFit<-ugarchfit(spec=MySpec, data=SimpleReturnGM)
> MyFit 直接用简单收益率 均值方程里的波动率系数不显著
> LnReturnGM<-log(SimpleReturnGM+1)
> MyFit1<-ugarchfit(spec=MySpec, data=LnReturnGM)
> MyFit1 假如使用对数收益率 那么还是可以10%显著的
（b)
> MySpec1<-ugarchspec(variance.model = list(model="eGARCH", garchOrder=c(1,1)),
+                     mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                     distribution.model = "norm")
> MyFit2<-ugarchfit(spec=MySpec1, data=SimpleReturnGM)
> MyFit2 γ系数显著，冲击的不对称效应确实存在
