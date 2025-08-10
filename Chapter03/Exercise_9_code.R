3.9
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("m-gmsp5003.txt",header=FALSE)
> StockSimpleReturn<-ts(df$V2)
> LnReturnGM<-log(StockSimpleReturn+1)
> help(ugarchfit)
> help(ugarchspec)
> MySpec<-ugarchspec(variance.model = list(model="fGARCH", garchOrder=c(1,1), submodel="TGARCH"),
+                    mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                    distribution.model = "norm"
+                    )
> MyFit<-ugarchfit(spec=MySpec, data=LnReturnGM)
> MyFit 不过冲击的不对称效应并不显著
> MyFcst<-ugarchforecast(MyFit, n.ahead = 6)
> MyFcst
