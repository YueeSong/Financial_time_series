4.5
(a)
> library(dplyr)
> df<-read.table("m-ge2603.txt", header=FALSE)
> SimpleReturn<-ts(df$V2)
> LnReturn<-log(SimpleReturn+1)
> ReturnEst<-LnReturn[1:900]
> MydfEst<-data.frame(ReturnEst) 
> MydfEst[[2]]<- c(NA, head(MydfEst[[1]], -1)) 滞后1期
> MydfEst[[3]]<- c(NA, NA, head(MydfEst[[1]], -2)) 滞后2期
> MydfEst[[4]]<- c(NA, NA, NA, head(MydfEst[[1]], -3)) 滞后3期
> model <- nnet(ReturnEst ~ V2+V3+V4, data = MydfEst, size = 2, linout = TRUE, maxit = 500) 神经网络模型 size为隐藏层神经元个数 linout为回归问题
> ReturnVal<- LnReturn[901:936]
> ReturnVal<-ts(ReturnVal)
> MydfVal<-data.frame(ReturnVal)
> MydfVal[[2]]<- c(NA, head(MydfVal[[1]], -1))
> MydfVal[[3]]<- c(NA, NA, head(MydfVal[[1]], -1))
> MydfVal[[4]]<- c(NA, NA, NA, head(MydfVal[[1]], -1))
> MydfVal_clean<- na.omit(MydfVal)
> pred<-predict(model, newdata = MydfVal_clean)
> MSE<-mean((MydfVal_clean$ReturnVal-pred)^2)
(b)
> library(dplyr)
> df<-read.table("m-ge2603.txt", header=FALSE)
> SimpleReturn<-ts(df$V2)
> LnReturn<-log(SimpleReturn+1)
> TrainData<-LnReturn[1:900]
> TrainSet<-data.frame(TrainData)
> TrainSet$Lag_1<- c(NA, head(TrainSet[[1]], -1))
> TrainSet$Lag_2<- c(NA, NA, head(TrainSet[[1]], -2))
> TrainSet$Lag_3<- c(NA, NA,NA, head(TrainSet[[1]], -3))
> names(TrainSet)[1]<- "LnReturn"
> TrainSet$Dir_lag1<- ifelse(TrainSet$Lag_1>0,1,0)
> TrainSet$Dir_lag2<- ifelse(TrainSet$Lag_2>0,1,0)
> TrainSet$Dir_lag3<- ifelse(TrainSet$Lag_3>0,1,0)
> model <- nnet(LnReturn ~ Lag_1+Lag_2+Lag_3+Dir_lag1+Dir_lag2+Dir_lag3, data = TrainSet, size = 5, linout = TRUE, maxit = 1500)
> TestData<-LnReturn[901:936]
> TestSet<-data.frame(TestData)
> TestSet$Lag_1<- c(NA, head(TestSet$TestData,-1))
> TestSet$Lag_2<- c(NA,NA, head(TestSet$TestData,-2))
> TestSet$Lag_3<- c(NA,NA,NA, head(TestSet$TestData,-3))
> TestSet$Dir_lag1<- ifelse(TestSet$Lag_1>0,1,0)
> TestSet$Dir_lag2<- ifelse(TestSet$Lag_2>0,1,0)
> TestSet$Dir_lag3<- ifelse(TestSet$Lag_3>0,1,0)
> TestSet_clean<-na.omit(TestSet)
> pred<-predict(model, newdata = TestSet_clean)
> MSE<-mean((TestSet_clean$TestData-pred)^2)
