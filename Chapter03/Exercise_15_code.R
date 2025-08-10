3.15
> df<-read.table("d-gmsp9303.txt",header=FALSE)
> SimpleGM<-ts(df$V2)
> SimpleSP<-ts(df$V3)
> LnGM<-log(SimpleGM+1)
> LnSP<-log(SimpleSP+1)
(a)
> MySpec<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
+                    mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                    distribution.model = "ged")
> MyFit<-ugarchfit(spec=MySpec,data=LnGM)
> MyFit
> sigma_series<-sigma(MyFit)
> sigma_series2<-sigma_series*sigma_series
> sigma_series2<-as.matrix(sigma_series2)
> MySpec1<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1), external.regressors=sigma_series2),
+                     mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                     distribution.model = "ged")
> MyFit2<-ugarchfit(spec=MySpec1,data=LnSP)
> MyFit2 但指数的波动率方程中 个股的波动率作为外生变量 系数仍不显著
