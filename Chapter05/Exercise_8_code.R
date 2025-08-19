df<-read.table("taq-t-ge-dec5.txt",header=FALSE)
df<- df %>% 
     mutate(secs = period_to_seconds(hms(V2))) %分时秒转换为秒
df<-df%>%
     rename(day=1,period=2,price=3,volume=4)%>% 
     mutate(bin=secs%/%300)  %生成5分钟桶
df<-filter(df, bin>113&bin<192)%筛选处于正常交易时间的交易
df<-df%>%
     group_by(day,bin)%>%
     mutate(avg_price=mean(price)) %计算每五分钟均价
day<-df$day
bin<-df$bin
avg_price<-df$avg_price
df_new<-data.frame(day,bin,avg_price)
df_new<-distinct(df_new)
df_new<-df_new%>%
     mutate(ln_price=log(avg_price))%>%
     mutate(returns=c(0,diff(ln_price))) % 计算每五分钟对数收益率
Returns<-df_new$returns
library(forecast)
Acf(Returns)
Box.test(Returns, lag=10, type=c("Ljung-Box"))
