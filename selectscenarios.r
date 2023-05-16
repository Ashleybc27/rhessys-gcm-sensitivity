##script to select scenarios 
## want hot+dry and wet+cool 

prlast <- as.data.frame(subset(prdf, prdf$year == 2046))  ##last sim year
head(prlast)

idx <- prlast[order(-prlast$pr),] #order outputs
head(idx)
tail(idx)
###top 5 ccsm,gdfl2m,hadgemcc,cnrm,csiro <-- wettest 
###bottom 5 inmcm,mirocesm,ipslcmlr,gdfl2g,bccmin <-- driest

##repeat for temp variables
maxtmplast <- as.data.frame(subset(maxtempdf,maxtempdf$year == 2046)) 
head(maxtmplast)
tail(maxtmplast)
idx2<- maxtmplast[order(-maxtmplast$tasmax),]

head(idx2)
tail(idx2)

###top 5 canesm,mirocesm,miroc,gdfl2g,ipslmlr <-- hottest max temp
###bottom 5 mricgcm,mirocesmchem,inmcm,ipslcmblr,noresm <-- coolest max temp 

mintmplast <- as.data.frame(subset(mintempdf, mintempdf$year == 2046))
idx3 <- mintmplast[order(-mintmplast$tasmin),]
head(idx3)
tail(idx3)

### top 5 ipslcmmr, cnrm, csiro, canesm, mirocesm <-- hottest min temp
### bottom 5 inmcm, mricgcm,gdfl2m,ipslcmblr,bnuesm <-- coolest min temp


###weird, look at mean 
mnpr <- aggregate(prdf$pr,list(prdf$name), FUN=mean) 
mnpr
idx4 <- mnpr[order(-mnpr$x),]
head(idx4)
tail(idx4)
###top 5 cnrm,bccminm,canesm,ipslcmmr,ccsm <-- wettest
###bottom 5 ipslcmlr,mirocesm,bccmin,csiro,mirocesmchem <-- driest 

mnmaxtmp <- aggregate(maxtempdf$tasmax,list(maxtempdf$name),FUN=mean)
mnmaxtmp
idx5 <- mnmaxtmp[order(-mnmaxtmp$x),]
head(idx5)
tail(idx5)
###top 5 canesm, ccsm, bnuesm, hadgemcc, bccmin <-- hottest maxtemp
###bottom 5 mricgcm, inmcm, mirocesm,ipslcmblr,bccminm <-- coolest maxtemp

mnmintmp <- aggregate(mintempdf$tasmin,list(mintempdf$name),FUN=mean)
mnmintmp
idx6 <- mnmintmp[order(-mnmintmp$x),]
head(idx6)
tail(idx6)
###top 5 canesm,cnrm,ipslcmmr,hadgemcc,bnuesm <--hottest maxtemp
###bottom 5 inmcm,mricgcm,gdfl2m,ipslcmblr,miroc <-- coolest maxtemp 

###change in temp over time 2005-2046
prdffirst <- subset(prdf, prdf$year == 2006)
prchange <- as.data.frame(prdffirst$pr - prlast$pr)
prchange$name <- prlast$name
idx7 <- prchange[order(-prchange[[1]]),]
head(idx7) 
tail(idx7)
###top 5 inmcm, noresm,bnuesm,ipslcmmr,bccmin <-- wetter
###bottom 5 hadgemmcc,cnrm,canesm,gdfl2m,gdfl2g <-- drier


mxtmpfirst <- subset(maxtempdf, maxtempdf$year == 2006)
mxtmpchange <- as.data.frame(mxtmpfirst$tasmax - maxtmplast$tasmax)
mxtmpchange$name <- maxtmplast$name
head(mxtmpchange)
idx8 <- mxtmpchange[order(-mxtmpchange[[1]]),]
head(idx8)
tail(idx8)
### top 5 hadgemcc,mricgcm,ipslcmlr,ipslcmmr,ipslcmblr <-- hotter 
###bottom 5 canesm, miroc,bnuesm,inmcm,bccminm <-- cooler

mntmpfirst <- subset(mintempdf, mintempdf$year == 2006)
mntmpchange <- as.data.frame(mntmpfirst$tasmin - mintmplast$tasmin)
mntmpchange$name <- mintmplast$name
idx9 <- mntmpchange[order(-mntmpchange[[1]]),]
head(idx9)
tail(idx9)
###top 5 inmcm, gdfl2m,mricgcm,ipslcmblr,gdfl2g <-- hotter
###bottom 5 canesm, cnrm,csiro,mirocesmchem, ipslcmmr <-- cooler

######################################################
##Based on total change hadgemcc is the hotter/drier scenario 
##Based on total change inmcm is the cooler/wetter scenario 

library(ggplot2)
library(ggrepel)

test <- merge(prchange, mntmpchange, by='name')
head(test)
colnames(test) = c('name','pr','temp')
mean(test$pr)
mean(test$temp)
#png(file="saving_plot2.png",width=600, height=350)
pp <- ggplot(test, aes(y=temp,x=pr,color=name)) +
    coord_fixed(2)+
    geom_point(size=5) +
    geom_vline(xintercept = -0.5009998) +
    geom_hline(yintercept = -1.278214) +
    geom_label_repel(aes(label = name),box.padding = .5) +
    labs(x='Delta Precipitation mm/day',y='Delta Temperature K',title = "Change in Precipitation vs Temperature")+
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5,size = 20)) +
    theme(legend.position = "none")
pp
graphics.off()
#dev.off
ggsave(filename= 'testplot.png',device = 'png',)

