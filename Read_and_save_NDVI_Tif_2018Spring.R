#计算平均NDVI
# NAN Yang
# 2020-04-30
#（1）proj4string应该是坐标投影的某种方式。
#（2）band1为NDVI，band2 EVI

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


#1. Read in the raster data---------------------
getwd()

setwd("F:/NDVI-1km/2018/")

dirname<-list.files('./',full.names=T,all.files=T,recursive=T,pattern='.tif')

dirname[4]
dirname[7]
dirname[8]


#3月
str_name<-'F:/NDVI-1km/2018/EOST_MODIS_CHN_A3_NVI_MLT_GLL_20180060_AOAM_1000M_MS.tif'
#band1为NDVI，band2为EVI
imported_raster=raster(dirname[4],band=1)
imported_raster

plot(imported_raster,axes=FALSE)

#imported_matrix<-as.matrix(imported_raster)

#把raster值除以1e4，达到NDVI的正常范围值。
max(values(imported_raster))
min(values(imported_raster))

values(imported_raster)<-values(imported_raster)/1e4

#4月
imported_raster_2=raster(dirname[7],band=1)
#band1为NDVI，band2为EVI
max(values(imported_raster_2))
min(values(imported_raster_2))
#把raster值除以1e4，达到NDVI的正常范围值。
values(imported_raster_2)<-values(imported_raster_2)/1e4

#5月
imported_raster_3=raster(dirname[8],band=1)
#band1为NDVI，band2为EVI
max(values(imported_raster_3))
min(values(imported_raster_3))
#把raster值除以1e4，达到NDVI的正常范围值。
values(imported_raster_3)<-values(imported_raster_3)/1e4

#求平均
values(imported_raster)<-(values(imported_raster)+values(imported_raster)+values(imported_raster))/3

#存raster

writeRaster(imported_raster, "E:/科学论文/2019Summer_dust-NDVI/0430 2018春季平均NDVI/2018_Spring_NDVI.tif", format = "GTiff")
