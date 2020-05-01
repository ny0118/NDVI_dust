#��ȡ�¾�NDVI���raster
# NAN Yang
# 2020-05-01
#��1��proj4stringӦ��������ͶӰ��ĳ�ַ�ʽ��
#��2��band1ΪNDVI��band2 EVI

library(lattice)
library(latticeExtra)
library(viridisLite)

library(ggplot2)
library(raster)
library(rasterVis)
library(rgdal)
library(grid)
library(scales)
library(viridis)  # better colors for everyone
library(ggthemes) # theme_map()


dirname="F:/NDVI-1km/2015/"

#1. Read in the raster data---------------------
getwd()

#setwd("F:/NDVI-1km/2000/")



filename<-list.files(dirname,full.names=T,all.files=T,recursive=T,pattern='.img')

length(filename)

print(filename)

#f=1

for (f in 1:length(filename)) {
  

  print(paste("processing",filename[f],f))
  
#band1ΪNDVI��band2ΪEVI
imported_raster=raster(filename[f],band=1)
imported_raster

#plot(imported_raster,axes=FALSE)
#imported_matrix<-as.matrix(imported_raster)

#��rasterֵ����1e4���ﵽNDVI��������Χֵ��
max(values(imported_raster))
min(values(imported_raster))

values(imported_raster)<-values(imported_raster)/1e4

print(max(values(imported_raster)))
print(min(values(imported_raster)))

#��raster
getwd()

setwd("E:/��ѧ����/2019Summer_dust-NDVI/R_project/monthly NDVI/")

filename[f]

save_name<-substring(filename[f],18,74)


writeRaster(imported_raster, save_name, format = "HFA")

}