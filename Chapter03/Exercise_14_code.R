3.14
(a)
> df<-read.table("d-gmsp9303.txt",header=FALSE)
> SimpleGM<-ts(df$V2)
> SimpleSP<-ts(df$V3)
> LnGM<-log(SimpleGM+1)
> LnSP<-log(SimpleSP+1)
> MySpec<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
+                    mean.model = list(armaOrder=c(5,0), include.mean=TRUE),
+                    distribution.model = "ged",
+                    fixed.pars = list(ar1=0,ar2=0,ar4=0))  固定均值方程中AR某阶系数为0
> MyFit<-ugarchfit(spec=MySpec, data=LnSP)
> MyFit
> sigma_series<-sigma(MyFit) 取出拟合所得的波动率序列
(b)
> sigma_series<-as.matrix(sigma_series)
> sigma2_series<-sigma_series*sigma_series
> MySpec1<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1), external.regressors=sigma2_series),
+                     mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                     distribution.model = "ged")
> MyFit<-ugarchfit(spec=MySpec1, data=LnGM)
> MyFit 结果显示个股的波动率方程中指数的波动率系数并不显著
