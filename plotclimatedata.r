##plot all outputs 
library(tidyverse)
library(ggplot2)
setwd("/Users/ashley/Desktop/sub_sens")

mintempannual <- list.files(pattern="annualtasmin.csv") 
print(mintempannual)

df<-c()
df <-
  list.files(pattern = "annualtasmin.csv") %>%
  map_dfr((~read_csv(.)))
df

##this is brute force read in all data 
bccmin <- read.csv("bcc_mean_annualtasmin.csv") 
bccmin$name <- "bccmin"
bccminm <- read.csv("bcc_m_mean_annualtasmin.csv")
bccminm$name <- "bccminm"
bnuesm <- read.csv("bnuesm_mean_annualtasmin.csv")
bnuesm$name <- "bnuesm"
canesm <- read.csv("canesm_mean_annualtasmin.csv")
canesm$name <- "canesm"
ccsm <- read.csv("ccsm_mean_annualtasmin.csv")
ccsm$name <- "ccsm"
cnrm <- read.csv("cnrm_mean_annualtasmin.csv")
cnrm$name <- "cnrm"
csiro <- read.csv("csiro_mean_annualtasmin.csv")
csiro$name <- "csiro"
gdfl2g <- read.csv("gdfl2g_mean_annualtasmin.csv")
gdfl2g$name <- "gdfl2g"
gdfl2m <- read.csv("gdfl2m_mean_annualtasmin.csv")
gdfl2m$name <- "gdfl2m"
hadgemcc <- read.csv("hadgemcc_mean_annualtasmin.csv")
hadgemcc$name <- "hadgemcc"
inmcm <- read.csv("inmcm_mean_annualtasmin.csv")
inmcm$name <- "inmcm"
ipslcmlr <- read.csv("ipslcmlr_mean_annualtasmin.csv")
ipslcmlr$name <- "ipslcmlr"
ipslcmblr <- read.csv("ipslcmblr_mean_annualtasmin.csv")
ipslcmblr$name <- "ipslcmblr"
ipslcmmr <- read.csv("ipslcmmr_mean_annualtasmin.csv")
ipslcmmr$name <- "ipslcmmr"
miroc <- read.csv("miroc_mean_annualtasmin.csv")
miroc$name <- "miroc"
mirocesm <- read.csv("mirocesm_mean_annualtasmin.csv")
mirocesm$name <- "mirocesm"
mirocesm <- read.csv("mirocesm_mean_annualtasmin.csv")
mirocesm$name <- "mirocesm"
mirocesmchem <- read.csv("mirocesmchem_mean_annualtasmin.csv")
mirocesmchem$name <- "mirocesmchem"
mricgcm <- read.csv("mricgcm_mean_annualtasmin.csv")
mricgcm$name <- "mricgcm"
noresm <- read.csv("noresm_mean_annualtasmin.csv")
noresm$name <- "noresm"
list <- c(bccminm, bnuesm,canesm,ccsm,cnrm,csiro,gdfl2g,gdfl2m,hadgemcc,inmcm,ipslcmblr,ipslcmlr,ipslcmmr,miroc,
mirocesm,mirocesmchem,mricgcm,noresm)
mintempdf <- 
mintempdf <- rbind(mintem)

tail(mintempdf)
#make dataframe
mintempdf <- read.csv("meanannualmintempall.cvs")
write.csv(mintempdf, "meanannualmintempall.cvs")
##mintemp
plot1 = ggplot(mintempdf, aes(x=year, y=tasmin, color=(name))) +
    #geom_line()
    geom_smooth(method='lm',se = FALSE )
plot1

plot2 = ggplot(mintempdf, aes(x=year, y=tasmin, color=(name)))+
    geom_boxplot()
plot2


####max temp 
bccmax <- read.csv("bcc_mean_annualtasmax.csv") 
bccmax$name <- "bccmin"
bccmmax <- read.csv("bcc_m_mean_annualtasmax.csv")
bccmmax$name <- "bccminm"
bnuesmmax <- read.csv("bnuesm_mean_annualtasmax.csv")
bnuesmmax$name <- "bnuesm"
canesmmax <- read.csv("canesm_mean_annualtasmax.csv")
canesmmax$name <- "canesm"
ccsmmax <- read.csv("ccsm_mean_annualtasmax.csv")
ccsmmax$name <- "ccsm"
cnrmmax <- read.csv("cnrm_mean_annualtasmax.csv")
cnrmmax$name <- "cnrm"
csiromax <- read.csv("csiro_mean_annualtasmax.csv")
csiromax$name <- "csiro"
gdfl2gmax <- read.csv("gfdl2g_mean_annualtasmax.csv")
gdfl2gmax$name <- "gdfl2g"
gdfl2mmax <- read.csv("gfdl2m_mean_annualtasmax.csv")
gdfl2mmax$name <- "gdfl2m"
hadgemccmax <- read.csv("hadgemcc_mean_annualtasmax.csv")
hadgemccmax$name <- "hadgemcc"
inmcmmax <- read.csv("inmcm_mean_annualtasmax.csv")
inmcmmax$name <- "inmcm"
ipslcmlrmax <- read.csv("ipslcmlr_mean_annualtasmax.csv")
ipslcmlrmax$name <- "ipslcmlr"
ipslcmblrmax <- read.csv("ipslcmblr_mean_annualtasmax.csv")
ipslcmblrmax$name <- "ipslcmblr"
ipslcmmrmax <- read.csv("ipslcmmr_mean_annualtasmax.csv")
ipslcmmrmax$name <- "ipslcmmr"
mirocmax <- read.csv("miroc_mean_annualtasmax.csv")
mirocmax$name <- "miroc"
mirocesmmax <- read.csv("mirocesm_mean_annualtasmax.csv")
mirocesmmax$name <- "mirocesm"
mirocesmchemmax <- read.csv("mirocesmchem_mean_annualtasmax.csv")
mirocesmchemmax$name <- "mirocesmchem"
mricgcmmax <- read.csv("mricgcm_mean_annualtasmax.csv")
mricgcmmax$name <- "mricgcm"
noresmmax <- read.csv("noresm_mean_annualtasmax.csv")
noresmmax$name <- "noresm"

#list <- c(bccminm, bnuesm,canesm,ccsm,cnrm,csiro,gdfl2g,gdfl2m,hadgemcc,inmcm,ipslcmblr,ipslcmlr,ipslcmmr,miroc,
#mirocesm,mirocesmchem,mricgcm,noresm)

maxtempdf <- bccmax
maxtempdf <- rbind(maxtempdf,noresmmax)
maxtempdf <- read.csv("meanannualmaxtemppall.cvs")

plot1 = ggplot(maxtempdf, aes(x=year, y=tasmax, color=(name))) +
    #geom_line()+
    geom_smooth(method='lm',se = FALSE)
plot1

plot2 = ggplot(maxtempdf, aes(x=year, y=tasmax, color=(name)))+
    geom_boxplot()
plot2

write.csv(maxtempdf, "meanannualmaxtemppall.cvs")

##precip
bccpr <- read.csv("bcc_mean_annualpr.csv") 
bccpr$name <- "bccmin"
bccmpr <- read.csv("bccm_mean_annualpr.csv")
bccmpr$name <- "bccminm"
bnuesmpr <- read.csv("bnuesm_mean_annualpr.csv")
bnuesmpr$name <- "bnuesm"
canesmpr <- read.csv("canesm_mean_annualpr.csv")
canesmpr$name <- "canesm"
ccsmpr <- read.csv("ccsm_mean_annualpr.csv")
ccsmpr$name <- "ccsm"
cnrmpr <- read.csv("cnrm_mean_annualpr.csv")
cnrmpr$name <- "cnrm"
csiropr <- read.csv("csiro_mean_annualpr.csv")
csiropr$name <- "csiro"
gdfl2gpr <- read.csv("gfdl2g_mean_annualpr.csv")
gdfl2gpr$name <- "gdfl2g"
gdfl2mpr <- read.csv("gfdl2m_mean_annualpr.csv")
gdfl2mpr$name <- "gdfl2m"
hadgemccpr <- read.csv("hadgemcc_mean_annualpr.csv")
hadgemccpr$name <- "hadgemcc"
inmcmpr <- read.csv("inmcm_mean_annualpr.csv")
inmcmpr$name <- "inmcm"
ipslcmlrpr <- read.csv("ipslcmlr_mean_annualpr.csv")
ipslcmlrpr$name <- "ipslcmlr"
ipslcmblrpr <- read.csv("ipslcmblr_mean_annualpr.csv")
ipslcmblrpr$name <- "ipslcmblr"
ipslcmmrpr <- read.csv("ipslcmmr_mean_annualpr.csv")
ipslcmmrpr$name <- "ipslcmmr"
mirocpr <- read.csv("miroc_mean_annualpr.csv")
mirocpr$name <- "miroc"
mirocesmpr <- read.csv("mirocesm_mean_annualpr.csv")
mirocesmpr$name <- "mirocesm"
mirocesmchempr <- read.csv("mirocesmchem_mean_annualpr.csv")
mirocesmchempr$name <- "mirocesmchem"
mricgcmpr <- read.csv("mricgcm_mean_annualpr.csv")
mricgcmpr$name <- "mricgcm"
noresmpr <- read.csv("noresm_mean_annualpr.csv")
noresmpr$name <- "noresm"


#list <- c(bccminm, bnuesm,canesm,ccsm,cnrm,csiro,gdfl2g,gdfl2m,hadgemcc,inmcm,ipslcmblr,ipslcmlr,ipslcmmr,miroc,
#mirocesm,mirocesmchem,mricgcm,noresm)

prdf <- bccpr
prdf <- rbind(prdf,noresmpr)

prdf <- read.csv("meanannualprecipall.cvs")
write.csv(prdf, "meanannualprecipall.cvs")

plot1 = ggplot(prdf, aes(x=year, y=pr, color=(name))) +
    geom_line() +
    theme_bw() +
    #geom_smooth(method='lm',se = FALSE) +
    labs(x='Year',y="Precipitation mm/day", title = "Precipitation") +
    theme(plot.title = element_text(hjust = 0.5,size = 20)) 
    
plot1

plot2 = ggplot(prdf, aes(x=year, y=pr, color=(name)))+
    geom_boxplot()
plot2

bigggggdb <- merge(bigggggdb,mintempdf, by = c('year','name'))
head(bigggggdb)
choooossee <- subset(bigggggdb, bigggggdb$name == 'hadgemcc' | bigggggdb$name == 'inmcm')
head(choooossee)

plot10 = ggplot(choooossee, aes(x=year, y=tasmin, color=(name))) +
  geom_line() +
  theme_bw() +
  #geom_smooth(method='lm',se = FALSE) +
  labs(x='Year',y="Minimum Temperature K", title = "Minimum Temperature") +
  theme(plot.title = element_text(hjust = 0.5,size = 20)) 

plot10



library(nlme)
gls.fit.diff.var <- 
  gls(tasmax ~ factor(year) + name, 
      data = choooossee)
      #corr = corSymm(form = ~ 1 | object),
      #weights = varIdent(form = ~ 1 | factor(time)),
      #control = glsControl(tolerance = 0.01, msTol = 0.01, 
                           #maxIter = 1000000, msMaxIter = 1000000))
summary(gls.fit.diff.var)


