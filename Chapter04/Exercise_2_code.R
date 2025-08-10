4.2
> df<-read.table("m-ge2603.txt", header=FALSE)
> SimpleReturn<-ts(df$V2)
> LnReturn<-log(SimpleReturn+1)
> MySpec<-ugarchspec(variance.model = list(model="fGARCH", garchOrder=c(1,1), submodel="TGARCH"),
+                    mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                    distribution.model = "ged")
> GJR<-ugarchfit(spec=MySpec, data=LnReturn)
> GJR
