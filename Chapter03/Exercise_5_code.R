% 3.5
library(forecast)
library(tseries)
library(ggplot2)
library(dplyr)
> setwd("C:/Users/shuimiantiancai/Desktop/IR/DataInCh3")
> df<-read.table("m-intc7303.txt",header=FALSE)
> Series<-ts(df$V2)
> LnSeries<-log(Series+1)
> Acf(LnSeries)
> SquaredLnSeries<-LnSeries*LnSeries
> Acf(SquaredLnSeries)
> Pacf(LnSeries)  %确定均值模型的形式
> MyMean<-mean(LnSeries) %没有AR项也没有MA项后，均值模型仅为均值加上a_t
> MyArgument<-LnSeries-MyMean  %因此用于建模GARCH的序列为收益率减去均值后得到的a_t序列
> MyGarch<-garch(MyArgument,order=c(1,1))
> summary(MyGarch)  %显示拟合后的参数，以及对标准化残差进行的JB检验和对标准化残差平方序列进行的LBQ检验 前者验证ε是否服从正态 后者检验模型是否充分（即拟合波动率模型后ARCH效应应当消失）


> library(rugarch)  更高级的Garch模型包
> spec <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
  mean.model = list(armaOrder = c(0, 0)),
  distribution.model = "norm"
)
> fit <- ugarchfit(spec = spec, data = MyArgument)
> fit  查看拟合结果（包括各参数及其标准误、对标准化残差及其平方序列的LBQ检验等）
> fcst <- ugarchforecast(fit, n.ahead = 5)
> fcst  查看预测结果
