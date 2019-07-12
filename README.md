# Visualising_DataSaturation_inUPM

In geosciences, spatial data are frequently used in modelling the physical processes that vary in space. The past few decades have seen an exponential increase in the availability of geospatial data. However, there is a computational cost associated with data mining from big volume of data.  Also, not all data comes free as some high-quality datasets are expensive owing to the cost intensive data collection techniques. In both situations, knowing how much data is enough, could save time and money.  Unfortunately, it is not usually clear if the amount of available data is enough to extract the desired information. In this study, we address the critical question of “how much data is enough” from the view point of visualizing a spatial process. Using information theory, we define a parameter which measures the incremental information gain as maps are updated with new data over time.  Data saturation happens the proposed parameter approaches zero, which means that no more spatial information is getting added to the maps and we can stop updating the maps. 

# Citation

The publication is in submission. In the meantime, please make a citation to 

Chakraborty, A., & Goto, H. (2018). A Bayesian model reflecting uncertainties on map resolutions with application to the study of site response variation. Geophysical Journal International, 214(3), 2264-2276.

# Requirements

1) R 

Download R from here: https://www.r-project.org/

(2) WinBUGS

Download WinBUGS from here: https://www.mrc-bsu.cam.ac.uk/software/bugs/the-bugs-project-winbugs/

Please visit this link to understand how to model in WinBUGS and obtain posterior samples of unknown parameters: https://www.mrc-bsu.cam.ac.uk/wp-content/uploads/manual14.pdf

# Sample dataset

sampledata_N32.csv is a sample dataset. It lists 32 lognormal random observations (N) across 101(N.sites) equally spaced sites in one-dimension. Some ghost sites (missing data) are introduced so that each site is almost spaced from its neighbor.

# Visualization

UPM (Chakraborty and Goto, 2018) is used as the visualization or mapping tool. The main program is UPM.odc which is run on WinBUGS. 

# How to use the codes and data files to generate UPM? 

In UPM, neighborhood is modelled using a conditional autoregressive(CAR)(De Oliveira, 2012) model. In WinBUGS, CAR model can be specified using the car.normal function. Three attributes are necessary; Num[],  Adj[] and Weights[]. Num[] is a vector of length N.sites giving the number of neighbors for each site. Adj[] is a vector listing the ID numbers of the adjacent sites for each site. Weights [] is a vector the same length as Adj[] giving unnormalized weights associated with each pair of sites. neighborhood.R generates the three attributes for the car.normal function in UPM.odc. 

UPM is based on a hierarchical Bayesian model. WinBUGS is used for the Bayesian analysis. In UPM.odc, the goal is to obtain the node statistics for the mean (mu) and standard deviation (sd) for the best c-model. The input is the data from sampledata.csv and the attributes for the car.normal function that comes from neighborhood.R . Changing the c value will change the output node characteristics of mu and sd. 

To find the best c model, we use the WAIC.R which is based on Gelman et al. (2014). 
In WAIC.R, MCMC output from UPM.odc are used as the input data. 

Example files necessary to run WAIC.R are 

mu_N32_CODA.txt: CODA index file for mu
sd_N32_CODA.txt: CODA index file for sd
mu_N32_CODA_index.txt: CODA index file for mu
sd_N32_CODA_index.txt: CODA index file for sd

We select UPM as the node statistics of mu for the c-model with lowest WAIC_1 and WAIC _2. 

# How to measure the incremental information gain? 

Once we get the UPM (node statistics of mu) for N=32, we can find the UPM for any other set of observations. 

We provide the node statistics of mu for a different dataset with 64 observations at each site. 

iDKL.R will now provide a measure of incremental information gain. 

Example files necessary to run iDKL.R. are: 

mu_N32_node_statistics.txt
sd_N32_node_statistics.txt
mu_N64_node_statistics.txt
sd_N64_node_statistics.txt

All these files are output from UPM.odc

# References 

Chakraborty, A., & Goto, H. (2018). A Bayesian model reflecting uncertainties on map resolutions with application to the study of site response variation. Geophysical Journal International, 214(3), 2264-2276.

De Oliveira, V.,2012. Bayesian analysis of conditional autoregressive models, Annals of the Institute of Statistical Mathematics ,64(1),107-133.

Gelman, A., Hwang, J., & Vehtari, A. (2014). Understanding predictive information criteria for Bayesian models. Statistics and computing, 24(6), 997-1016.



