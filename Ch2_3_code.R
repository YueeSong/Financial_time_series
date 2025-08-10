% 2.3

library(forecast)
library(tseries)
library(ggplot2)
library(dplyr)
% 导入四个库

setwd("C:/Users/shuimiantiancai/Desktop/IR") % 打开文件夹
unem_df <- read.table("m-unrate.txt", header=TRUE) % 读取数据
unem_ts <- ts(unem_df$Rate) %拿出Rate列
Acf(unem_ts) % 查看失业率的ACF（发现拖尾）
diff_unem <- diff(unem_ts) % 查看失业率一阶差分后的ACF（发现季节性12）
Acf(diff_unem) % 一阶差分序列的ACF，用于确定MA的常规q阶
Pacf(diff_unem) % 一阶差分序列的PACF，用于确定AR的常规p阶

airline_model <- Arima(unem_ts, order=c(2,1,1), seasonal = list(order=c(1,1,1), period=12))
% 拟合航空模型 第一个(2,1,1)表明对序列进行的常规ARMA拟合，2项AR，1次非季节差分，1次MA；第二个(1,1,1)表明对序列进行季节差分，1项AR，1次季节性差分，1项MA；period为季节周期
residuals_airline <- residuals(airline_model) %取出模型拟合后的残差
Acf(residuals_airline) % 查看残差序列的ACF 理想状态是都不显著
Box.test(residuals_airline, lag=20, type="Ljung-Box") % 对残差序列进行LBQ检验，原假设是不存在自相关，理想结果为无法拒绝原假设，有大的p-value
summary(airline_model) % 查看航空模型的参数