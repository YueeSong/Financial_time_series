library(dplyr)
library(lubridate)
library(tseries)
library(forecast)
df1<-read.table("taq-t-ge-dec5.txt",header=FALSE)
df2<- df1 %>% 
          mutate(secs = period_to_seconds(hms(V2))) %分时秒数据转换为秒
df3<-df2%>%
     rename(day=1,period=2,price=3,volume=4)%>%
     mutate(bin=secs%/%300) %生成5分钟桶
df4<-filter(df3, bin>113&bin<192) %只看9.30am至4.00pm的交易
counts <- df4 %>%
     group_by(day, bin) %>%
     summarise(trade_count = n(), .groups = "drop") %计算交易笔数（而非交易量volume）
My_counts<-counts$trade_count
Acf(My_counts)
Box.test(My_counts,lag=25,type=c("Ljung-Box")) %存在日内自相关

交叉验证：
NumOfTrades<-read.table("taq-ge-dec5-nt.txt",header=FALSE) 
Acf(NumOfTrades)
Box.test(NumOfTrades,lag=25,type=c("Ljung-Box")) %这一列数据来自作者 清洗结果略微有差异 ACF和LBQ结果几乎一致
