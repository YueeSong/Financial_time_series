df<-read.table("taq-t-ge-dec5.txt",header=FALSE)
df<- df %>% 
     mutate(secs = period_to_seconds(hms(V2)))
df<-df%>%
     rename(day=1,period=2,price=3,volume=4)%>% 
     mutate(bin=secs%/%600)
df<-filter(df, bin>56&bin<96)
df<-df%>%
     group_by(day,bin)%>%
     mutate(avg_price=mean(price))
day<-df$day
bin<-df$bin
avg_price<-df$avg_price
df_new<-data.frame(day,bin,avg_price)
df_new<-distinct(df_new)
df_new<-df_new%>%
     mutate(ln_price=log(avg_price))%>%
     mutate(returns=c(0,diff(ln_price)))
Returns<-df_new$returns
Acf(Returns)
Box.test(Returns, lag=10, type=c("Ljung-Box"))
