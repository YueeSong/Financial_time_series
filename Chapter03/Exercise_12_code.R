3.12
(a)
> df<-read.table("d-gmsp9303.txt",header=FALSE)
> SimpleReturnSP<-ts(df$V3)
> Acf(SimpleReturnSP)
> Box.test(SimpleReturnSP,lag=10, type=c("Ljung-Box"))
> SimpleReturnSP2<-SimpleReturnSP*SimpleReturnSP
> Box.test(SimpleReturnSP2,lag=10,type=c("Ljung-Box"))
(b)
 MySpec<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
                    mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
                    distribution.model = "norm")
> MyFit<-ugarchfit(spec=MySpec, data=SimpleReturnSP)
> MyFit
(c)
> MyFcst<-ugarchforecast(MyFit, n.ahead=4)
> MyFcst
