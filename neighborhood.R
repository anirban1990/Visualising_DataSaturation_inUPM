#****************************************************************************************************
# This program generates the Adj[], Num[] and Weights[] attributes for car.normal function in UPM.odc  
#****************************************************************************************************

data<-read.csv("sampledata_N32.csv",header=TRUE,sep=",")
# x1 inputs the x coordinates of the sites 
x1<-data[,1]
# N inputs the total number of sites 
N=length(X) 
# y1 inputs the y coordinates of the sites 
y1<-rep(0,101)     
Dist1<-as.matrix(dist(cbind(x1,y1)))
C1<-matrix(nrow=N,ncol=N)
C1[,]<-0
# Threshold inputs proposed radius of the neighorhood circle 
Threshold<-0.3   
for(i in 1:N){
  Neighb.i<-Dist1[i,]<Threshold
  C1[i,Neighb.i]<-1
  C1[i,i]<-0
}
C2<-matrix(nrow=N,ncol=N)
C2[,]<-0
RS<-rowSums(C1)
for(i in 1:N){if (RS[i]>0){C2[i,]<-C1[i,]/RS[i]}}
NumNeighbours<-colSums(C1)
ID<-1:N
Info<-list(num=NA,adj=NA,C=NA)
Info$M<-1/NumNeighbours
Info$num<-rowSums(C2>0)
for(i in 1:N){
  cur.neighb<-ID[C2[i,]>0]
  Info$adj<-c(Info$adj,cur.neighb)
  Info$C<-c(Info$C,C2[i,cur.neighb])
}
Info$adj<-Info$adj[-1]
Info$C<-Info$C[-1]
Weights<-rep(1,length(Info$adj))

# Outputs: Adj[], Num[] and Weights[]
Info$num
Info$adj
Weights
