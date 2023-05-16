

setwd('~/Documents/Modeling/spanishcreek/128subbasin/out/gcm')
source('/Users/ashley/Documents/Modeling/RScripts/plot_differences_20192.R')

hadgem <- importRHESSYS_other('hadgem/hadgem_basin.daily') ##read rhessys outputs 
head(hadgem)

hadgempatch <- read.table('hadgem/hadgemyr_patch.yearly',header=T) 
head(hadgempatch)

inmcm <- read.table('inmcm/inmcmyr_patch.yearly', header=T)
hist <- read.table('hist/histyr_patch.yearly', header=T)
hadgem1 <- as.data.frame(aggregate(hadgempatch$et,list(hadgempatch$year),FUN=mean)) #readin 
print(hadgem1)
inmcm1 <- as.data.frame(aggregate(inmcm$et,list(inmcm$year),FUN=mean)) #readin
head(inmcm1)
hist1 <- as.data.frame(aggregate(hist$et, list(hist$year),FUN=mean)) #readin
hist2 <- subset(hist1, hist1$Group.1 > 1979 & hist1$Group.1 < 2004) ##clip not full years 
hadgem2 <- subset(hadgem1, hadgem1$Group.1 > 2006 & hadgem1$Group.1 < 2031) ##clip not full years 
inmcm2 <- subset(inmcm1, inmcm1$Group.1 > 2006 & inmcm1$Group.1 < 2031) ##clip not full years 
hist2$model <- 'hist' # name model
inmcm2$simyear <- 1:24 #index
hadgem2$model <- "hadgem"  # name model
inmcm2$model <- 'inmcm'  # name model
etdb <- rbind(etdb, hadgem2) ##make final df


##plot
k <- ggplot(etdb, aes(x=simyear, y=x,color=model)) +
  geom_line() +
  theme_bw() +
  labs(x= "Simulation Year", y="Evapotranspiration mm", title='Evapotranspiration over Simulation Period') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))
k

####plot pet
inmcm3 <- as.data.frame(aggregate(inmcm$pet,list(inmcm$year),FUN=mean,na.rm=T))
print(inmcm3)
hist3 <- as.data.frame(aggregate(hist$pet, list(hist$year),FUN=mean,na.rm=T))
print(hist3)
hadgem3 <- as.data.frame(aggregate(hadgempatch$pet,list(hadgempatch$year),FUN=mean,na.rm=T))
hist4 <- subset(hist3, hist3$Group.1 > 1979 & hist3$Group.1 < 2004)
hadgem4 <- subset(hadgem3, hadgem3$Group.1 > 2006 & hadgem3$Group.1 < 2031)
inmcm4 <- subset(inmcm3, inmcm3$Group.1 > 2006 & inmcm3$Group.1 < 2031)
inmcm4$simyear <- 1:24
hadgem4$model <- "hadgem"
inmcm4$model <- 'inmcm'
hist4$model <- 'hist'

petdb <- rbind(petdb,inmcm4)
print(petdb)
t <- ggplot(petdb, aes(x=simyear, y=x,color=model)) +
  geom_line() +
  theme_bw() +
  labs(x= "Simulation Year", y="Potential Evapotranspiration mm", title='Potential Evapotranspiration over Simulation Period') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))
t


hist(inmcm$pet)
graphics.off()

deficitdb <- cbind(petdb,etdb$x)
deficitdb$deficit <- (1-deficitdb$`etdb$x`/deficitdb$x)

g <- ggplot(deficitdb, aes(x=simyear, y=deficit,color=model)) +
  geom_line() +
  theme_bw() +
  labs(x= "Simulation Year", y="Deficit", title='Deficit over Simulation Period') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))
g

#repeat for all variables
 hadgemgrow <- read.table("hadgem/hadgem_grow_basin.daily", header=T)
hadgemgrow1 <- as.data.frame(aggregate(hadgemgrow, list(hadgemgrow$year),FUN=mean))
histgrow <- read.table("hist/hist_grow_basin.daily", header=T)
histgrow1 <- as.data.frame(aggregate(histgrow, list(histgrow$year),FUN=mean))
inmcmgrow <- read.table("inmcm/inmcm_grow_basin.daily", header=T)
inmcmgrow1 <- as.data.frame(aggregate(inmcmgrow, list(inmcmgrow$year),FUN=mean))
histgrow2 <- subset(histgrow1, histgrow1$Group.1 > 1979 & histgrow1$Group.1 < 2004)
hadgemgrow2 <- subset(hadgemgrow1, hadgemgrow1$Group.1 > 2006 & hadgemgrow1$Group.1 < 2031)
inmcmgrow2 <- subset(inmcmgrow1, inmcmgrow1$Group.1 > 2006 & inmcmgrow1$Group.1 < 2031)
histgrow2$simyear <- 1:24
hadgemgrow2$model <- "hadgem"
inmcmgrow2$model <- 'inmcm'
histgrow2$model <- 'hist'

basingrowdf <- rbind(basingrowdf, inmcmgrow2)
head(basingrowdf)

c <- ggplot(basingrowdf, aes(x=simyear, y=litrc, color=model)) +
  geom_line()+ 
  theme_bw() +
  labs(x= "Simulation Year", y="Litter Carbon kgC/m2", title='Litter Carbon over Simulation Period') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))
c


gls.fit.diff.var2 <- 
  gls(litrc ~ factor(simyear) + model, 
      data = basingrowdf)
#corr = corSymm(form = ~ 1 | object),
#weights = varIdent(form = ~ 1 | factor(time)),
#control = glsControl(tolerance = 0.01, msTol = 0.01, 
#maxIter = 1000000, msMaxIter = 1000000))
summary(gls.fit.diff.var2)

