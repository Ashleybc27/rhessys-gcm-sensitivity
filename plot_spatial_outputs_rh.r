##code used to plot outputs spatially across basin##
##author: Ash Cale##
##10/2021## 
source('~/Documents/Modeling/RScripts/useful_ning_functions.R')
require('gridExtra')

wkdir= "~/Documents/Modeling/spanishcreek/128subbasin/"
setwd(wkdir)

##load stratum output and patch map 
hadgem.patch <- as.data.frame(read.table('out/gcm/hadgem/hadgemyr_grow_patch.yearly', header=T))
inmcm.patch <- as.data.frame(read.table('out/gcm/inmcm/inmcmyr_grow_patch.yearly', header=T))
hist.patch <- as.data.frame(read.table('out/gcm/hist/histyr_grow_patch.yearly', header=T))
patches = raster('auxdata/sc.subpatch.asc')
head(inmcm.patch)
##want only overstory?
overstor <- (subset(stratum.daily, stratum.daily$stratumID == 11))

##which variable?
var='litter_c'

rhessys_spatial= plotPatchSpatialGeneral(hadgem.patch, var, patches) ##make sure you've loaded gridExtra
plot(patches)

subdf <- as.data.frame(rasterToPoints(patches))
head(subdf)
colnames(subdf) <- c('x','y','patchID')
hadgem2007 <- subset(hadgem.patch, hadgem.patch$year == 2007)
hadgem2029 <- subset(hadgem.patch, hadgem.patch$year == 2029)

head(hadgem.patch)
hadgemfirsttest <- merge(subdf,hadgem2007,by='patchID')
hadgemlast <- merge(subdf, hadgem2029, by='patchID')
head(hadgemfirsttest)
ordhad2007 <- as.data.frame(cbind(hadgemfirsttest$x, hadgemfirsttest$y, hadgemfirsttest$litter_c))
ordhad2029 <- as.data.frame(cbind(hadgemlast$x, hadgemlast$y, hadgemlast$litter_c))
hadgem2007rast <- rasterFromXYZ(ordhad2007)
hadgem2029rast <- rasterFromXYZ(ordhad2029)
plot(hadgem2007rast)
plot(hadgem2029rast)
hist(hadgem2029rast)

hadgemdiffrast <- hadgem2029rast - hadgem2007rast
plot(hadgemdiffrast)
diffhad <- as.data.frame(rasterToPoints(hadgemdiffrast))
head(diffhad)

haddif <- ggplot(diffhad)+
  geom_raster(aes(x=x, y=y, fill=layer)) +
  theme_bw() +
  scale_fill_gradient2(low="red",mid='white', high="blue",name = "Litter C") +
  labs(title = "HadGEM Difference Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))

haddif

had2007 <- ggplot(ordhad2007)+
          geom_raster(aes(x=V1, y=V2, fill=V3)) +
          theme_bw() +
          scale_fill_gradient(low="purple", high="yellow",name = "Litter C") +
          labs(title = "Initial Litter Carbon", x='', y='') +
          theme(plot.title = element_text(hjust = 0.5,size = 20))

had2007

had2029 <- ggplot(ordhad2029)+
  geom_raster(aes(x=V1, y=V2, fill=V3)) +
  theme_bw() +
  scale_fill_gradient(low="purple", high="yellow",name = "Litter C") +
  labs(title = "HadGEM Final Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))

had2029

inmcm2007 <- subset(inmcm.patch, inmcm.patch$year == 2007)
inmcm2029 <- subset(inmcm.patch, inmcm.patch$year == 2029)
inmcmfirst <- merge(subdf,inmcm2007,by='patchID')
inmcmlast <- merge(subdf, inmcm2029, by='patchID')
head(hadgemfirsttest)
ordin2007 <- as.data.frame(cbind(inmcmfirst$x, inmcmfirst$y, inmcmfirst$litter_c))
ordin2029 <- as.data.frame(cbind(inmcmlast$x, inmcmlast$y, inmcmlast$litter_c))
inmcm2007rast <- rasterFromXYZ(ordin2007)
inmcm2029rast <- rasterFromXYZ(ordin2029)
plot(inmcm2007rast)
plot(inmcm2029rast)

in2029 <- ggplot(ordin2029)+
  geom_raster(aes(x=V1, y=V2, fill=V3)) +
  theme_bw() +
  scale_fill_gradient(low="purple", high="yellow",name = "Litter C") +
  labs(title = "inmcm Final Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))

in2029

inmcmdiffrast <- inmcm2029rast - inmcm2007rast
plot(inmcmdiffrast)
diffinmcm <- as.data.frame(rasterToPoints(inmcmdiffrast))

indif <- ggplot(diffinmcm)+
  geom_raster(aes(x=x, y=y, fill=layer)) +
  theme_bw() +
  scale_fill_gradient2(low="red",mid='white', high="blue",name = "Litter C") +
  labs(title = "inmcm Difference Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))

indif

in2029 <- ggplot(ordin2029)+
  geom_raster(aes(x=V1, y=V2, fill=V3)) +
  theme_bw() +
  scale_fill_gradient(low="purple", high="yellow",name = "Litter C") +
  labs(title = "inmcm Final Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))


hist1980 <- subset(hist.patch, hist.patch$year == 1980)
hist2004 <- subset(hist.patch, hist.patch$year == 2004)
histfirst <- merge(subdf,hist1980,by='patchID')
histlast <- merge(subdf, hist2004, by='patchID')
head(hadgemfirsttest)
ordin1980 <- as.data.frame(cbind(histfirst$x, histfirst$y, histfirst$litter_c))
ordhist2004 <- as.data.frame(cbind(histlast$x, histlast$y, histlast$litter_c))
hist1980rast <- rasterFromXYZ(ordin1980)
hist2004rast <- rasterFromXYZ(ordin2004)

plot(hist1980rast)
plot(hist2004rast)

his2004 <- ggplot(ordhist2004)+
  geom_raster(aes(x=V1, y=V2, fill=V3)) +
  theme_bw() +
  scale_fill_gradient(low="purple", high="yellow",name = "Litter C") +
  labs(title = "Historic Final Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))

his2004

histdiffrast <- hist2004rast - hist1980rast
plot(histdiffrast)
diffhist <- as.data.frame(rasterToPoints(histdiffrast))

hdif <- ggplot(diffhist)+
  geom_raster(aes(x=x, y=y, fill=layer)) +
  theme_bw() +
  scale_fill_gradient2(low="red",mid='white', high="blue",name = "Litter C") +
  labs(title = "Historic Difference Litter Carbon", x='', y='') +
  theme(plot.title = element_text(hjust = 0.5,size = 20))

hdif
aa##remove optliers? 
z_maz = 80
rhessys_clip[rhessys_spatial>z_max] = z_max

rhessys_plot_spatial <- rasterVis::gplot(rhessys_spatial) +
  geom_tile(aes(fill=value)) +
  scale_fill_gradientn(colours=rev(terrain.colors(10)),limits=c(0,z_max))+
  ggtitle("Spatial Output") +  plot.theme.map + theme(legend.title=element_text(size = 22,face="bold"), 
                                                       plot.title = element_text(size =26, face="bold"))+
  labs(fill="Output")

rhessys_plot_spatial