% 2.14
> df<-read.table("sp5may.dat",header=FALSE)> future<-ts(df$V1)
> spot<-ts(df$V2)
> diff_f<-diff(future)
> diff_s<-diff(spot)
> MyData=rbind(diff_f,diff_s)
> MyData<-t(MyData)
> MyData<-as.data.frame(MyData)
> LinearModel<-lm(diff_f~diff_s, data=MyData)
> summary(LinearModel)
> MyRes<-residuals(LinearModel)
> Acf(MyRes,lag.max = 50)
> Pacf(MyRes,lag.max=50)
> airline<-Arima(MyRes, order=c(12,0,6)) %可以试试不加Ar项
