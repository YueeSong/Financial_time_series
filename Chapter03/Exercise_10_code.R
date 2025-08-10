3.10
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("m-gmsp5003.txt",header=FALSE)
> StockSimpleReturn<-ts(df$V2)
> IndexSimpleReturn<-ts(df$V3)
> LnReturnGM<-log(StockSimpleReturn+1)
> LnReturnSP<-log(IndexSimpleReturn+1)
(a)
> MySpec<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1)),
+                    mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                    distribution.model = "norm")
> MyFit<-ugarchfit(spec=MySpec, data=LnReturnSP)
> MyFit
(b)
> colnames(df)[1] <- "date"
> df$date <- as.character(df$date)
> df$month <- substr(df$date, 5, 6)
> df$summer <- ifelse(df$month %in% c("06", "07", "08"), 1, 0)
> MySummer<-df$summer
> MySummer <- as.matrix(df$summer)
> MySpec1<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1), external.regressors=MySummer),
                                          mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
                                          distribution.model = "norm")
> MyFit1<-ugarchfit(spec=MySpec1, data=LnReturnSP)
> MyFit1
(c)
> library(dplyr)
> NewLnReturnSP<-as.vector(LnReturnSP)
> LnReturnGMlag1<-lag(NewLnReturnSP,1)
> LnReturnGMlag1<-as.matrix(LnReturnGMlag1)
> LnReturnGMlag1<-na.omit(LnReturnGMlag1)
> MySpec2<-ugarchspec(variance.model = list(model="sGARCH", garchOrder=c(1,1), external.regressors=LnReturnGMlag1),
+                                           mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
+                                           distribution.model = "norm")
> LnReturnSP_cut<-LnReturnSP[2:648]
> MyFit2<-ugarchfit(spec=MySpec2,data=LnReturnSP_cut)
> MyFit2
