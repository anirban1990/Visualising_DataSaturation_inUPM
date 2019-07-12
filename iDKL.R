#********************************************************************
# This program calculates the incremental KL Divergence (iDKL)
# between maps with two different number of observations (N)
#********************************************************************

# b inputs the sites to be considered for the calculation 
b<-c(2:62)

# Reading data from WinBUGS output
data1<-read.delim("mu_N32_node_statistics.txt",header=TRUE,sep="\t")
y1<-data1$mean

data2<-read.delim("sd_N32_node_statistics.txt",header=TRUE,sep="\t")
y2<-data2$mean

data3<-read.delim("mu_N64_node_statistics.txt",header=TRUE,sep="\t")
x1<-data3$mean

data4<-read.delim("sd_N64_node_statistics.txt",header=TRUE,sep="\t")
x2<-data4$mean

# Calculation of iDKL
KL<- list()
iDKL=c(0)
for (i in b){
      KL[[i]]=log(x2[i]/y2[i])+(((y2[i]^2)+((y1[i]-x1[i])^2))/(2*(x2[i]^2)))-0.5
      iDKL=DiKL+KL[[i]]
}

# Output: DiKL
iDKL





