df<-read.table("taq-t-ge-dec5.txt",header=FALSE)
df<- df %>% 
     mutate(secs = period_to_seconds(hms(V2))) 
df<-filter(df, secs>=34200&secs<=57600) %筛选正常交易时间内的交易
df<-df%>%
     rename(day=1,period=2,price=3,volume=4)
df<-df%>%
          mutate(price_change=c(0,diff(price))) %计算价格变化
library(dplyr)
df1<-df%>%
     group_by(price_change)%>%
     summarise(count=n())  %生成新dataframe 排序依据为price_change 新增总结列：名为count 内容为计数 
df1<-df1%>%
     mutate(proportion=count/sum(count)) %生成新的一列 内容为各个price_change的占比 在其中寻找0的占比即可 略超过50%
