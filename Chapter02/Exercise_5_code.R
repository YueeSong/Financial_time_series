% 2.5
df<-read.table("d-ibmvwewsp6202.txt",header=FALSE)
Myseries<-ts(df$V2)
Myseries<-as.numeric(Myseries)
Acf(Myseries,lag.max=120)
Acf(Myseries,lag.max=1200)
