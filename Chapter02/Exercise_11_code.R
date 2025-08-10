% 2.11
> Acf(SeriesAAA)
> Acf(diff_AAA)
> Pacf(diff_AAA)
> airline_AAA<-Arima(diff_AAA,order=c(2,0,3), seasonal=list(order=c(1,1,1), period=4))
> resi<-residuals(airline_AAA)
> Acf(resi)
> Box.test(resi,lag=20,type=c("Ljung-Box"))
