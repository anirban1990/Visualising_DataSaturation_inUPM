#*******************************************************
# This program calculates WAIC values for a UPM model 
#*******************************************************

# N.obs inputs the no. of observations at each site
N.Obs=32
# b inputs the relevant lines for WAIC calculation in a CODA Index File#
b<-c(1:63) 

# Reading data from WinBUGS output
data<-read.csv("sampledata_N32.csv",header=TRUE,sep=",")
data1<-data[,2:33]
data2<-read.delim("mu_N32_CODA.txt",header=FALSE,sep="\t")
data3<-read.delim("sd_N32_CODA.txt",header=FALSE,sep="\t")
data4<-read.delim("mu_N32_CODA_index.txt",header=FALSE,sep="\t")
data5<-read.delim("sd_N32_CODA_index.txt",header=FALSE,sep="\t")

mata1<-as.matrix(data1)
mata2<-as.matrix(data2)
mata3<-as.matrix(data3)
mata4<-as.matrix(data4)
mata5<-as.matrix(data5)

Mu<- list()
for (i in b) Mu[[i]] <- mata2[mata4[i,2]:mata4[i,3],2]

Sd<- list()
for (i in b) Sd[[i]] <- mata3[mata5[i,2]:mata5[i,3],2]

# Calculation of LPPD 
L1<- list()
L2<-c()
L3<-c()
LPPD<-c()
LPPD=c(0)
for (i in b){
  for (j in 1:N.Obs){  
    if (is.na(data1[i,j])==TRUE){
      L3[j]<- 0
      } else { 
    L1[[j]]<-((2*pi*(Sd[[i]]^2)^(-0.5))*exp((-(1/(2*(Sd[[i]])^2)))*((data1[i,j]-Mu[[i]])^2)))
    L2[j]<-mean(L1[[j]])
    L3[j]<-log(L2[j])
    }
LPPD=LPPD+L3[j]
  }
}

# Calculation of P1 
M1<- list()
M2<-c()
M3<-c()
M4<- c()
P1<-c(0)
P1=c(0)
for (i in b){
  for (j in 1:N.Obs){  
    if (is.na(data1[i,j])==TRUE){
    M4[j]<- 0
    } else { 
    M1[[j]]<-((2*pi*(Sd[[i]]^2)^(-0.5))*exp((-(1/(2*(Sd[[i]])^2)))*((data1[i,j]-Mu[[i]])^2)))
    M2[j]<-log(mean(M1[[j]]))
    M3[j]<-mean(log(M1[[j]]))
    M4[j]=2*(M2[j]-M3[j])
    }
 P1=P1+M4[j]
  }
}

# Calculation of P2 
N1<- list()
N2<-c()
P2<-c()
P2=c(0)
for (i in b){
  for (j in 1:N.Obs){  
      if (is.na(data1[i,j])==TRUE){
        N2[j]<- 0
      } else { 
    N1[[j]]<-log((2*pi*(Sd[[i]]^2)^(-0.5))*exp((-(1/(2*(Sd[[i]])^2)))*((data1[i,j]-Mu[[i]])^2)))
    N2[j]<-var(N1[[j]])
      }
P2=P2+N2[j]
  }
  }

# Calculation of WAIC_1 and WAIC_2 
WAIC_1=-2*(LPPD-P1)
WAIC_2=-2*(LPPD-P2)

# Outputs: WAIC_1 and WAIC_2
WAIC_1
WAIC_2




