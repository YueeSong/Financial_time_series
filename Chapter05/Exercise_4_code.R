(a)
df<-read.table("mmm9912-dtp.txt",header = FALSE)
df <- df %>%
     rename(day = 1, seconds = 2, price = 3) %>%
     mutate(bin = seconds %/% 300)
counts <- df %>%
     group_by(day, bin) %>%
     summarise(trade_count = n(), .groups = "drop")
all_days <- unique(counts$day)
all_bins <- seq(min(counts$bin), max(counts$bin))
counts_full <- tidyr::complete(counts,
                                day = all_days,
                                bin = all_bins,
                                fill = list(trade_count = 0))
avg_5min <- counts_full %>%
     group_by(bin) %>%
     summarise(avg_trade_count = mean(trade_count), .groups = "drop") %>%
     mutate(start_sec = bin * 300,
            time_label = sprintf("%02d:%02d", start_sec %/% 3600, (start_sec %% 3600) %/% 60)) %>%
     arrange(bin)
% 接着对五分钟平均交易量进行画图即可
% 以上命令研究一下


(b)
library(tseries)
library(forecast)
Price<-ts(df$price)
LnPrice<-log(Price)
Returns<-diff(LnPrice)
Acf(Returns)
Box.test(Returns,lag=1,type=c("Ljung-Box"))
% 非常显著的一阶滞后负相关


(c)
df<-read.table("mmm9912-dtp.txt",header = FALSE)
Price<-df$V3
DiffPrice<-diff(Price) %计算价格变动量
NumOfTicks<-DiffPrice/0.0625 %计算变动多少个ticks
NumOfTicks<-as.data.frame(NumOfTicks) %转换为DF格式
Freq<-NumOfTicks%>% group_by(NumOfTicks) %记录一个分组
Freq<-Freq%>%summarise(n=n()) %分组后计算个数
RealFreq<-Freq%>%filter(NumOfTicks%%1==0) % 去掉由于隔天而带来的价格tick非整数变动量的行
