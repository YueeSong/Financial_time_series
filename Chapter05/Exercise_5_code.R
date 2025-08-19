(a)
df<-read.table("mmm9912-dtp.txt",header=FALSE)
df <- df %>%
     rename(day = 1, seconds = 2, price = 3) %>%
     mutate(bin = seconds %/% 300) %生成每日的5分钟桶
df <- df %>%
     group_by(day,bin) %>%
     summarise(avg_price = mean(price), .groups = "drop")  %计算每日每5分钟的均价
df<-df%>%
      group_by(day,bin)%>%
      mutate(ln_avg_price=log(avg_price))  %均价转换为对数价格
df<-df%>%
       group_by(day)%>%
       mutate(ln_returns=c(0,diff(ln_avg_price))) %对数价格差分得到对数收益率
df<-df%>%
      group_by(bin)%>%
      mutate(avg_ln_returns=mean(ln_returns)) %跨日计算每隔五分钟的平均对数收益率
avg_5min_returns<-df$avg_ln_returns[2:78]
Box.test(avg_5min_returns,lag=10, type=c("Ljung-Box"))%查看是否序列相关


(b)
df<-df%>%
     group_by(day)%>%
     mutate(vol=sum(ln_returns*ln_returns)) %计算每日由5分钟对数收益率计算的波动率
df<-df%>% 
     arrange(bin) 
daily_vol<-df$vol[1:22]
