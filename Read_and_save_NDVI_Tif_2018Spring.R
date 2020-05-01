#����ƽ��NDVI
# NAN Yang
# 2020-04-30
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


#1. Read in the raster data---------------------
getwd()

setwd("F:/NDVI-1km/2018/")

dirname<-list.files('./',full.names=T,all.files=T,recursive=T,pattern='.tif')

dirname[4]
dirname[7]
dirname[8]


#3��
str_name<-'F:/NDVI-1km/2018/EOST_MODIS_CHN_A3_NVI_MLT_GLL_20180060_AOAM_1000M_MS.tif'
#band1ΪNDVI��band2ΪEVI
imported_raster=raster(dirname[4],band=1)
imported_raster

plot(imported_raster,axes=FALSE)

#imported_matrix<-as.matrix(imported_raster)

#��rasterֵ����1e4���ﵽNDVI��������Χֵ��
max(values(imported_raster))
min(values(imported_raster))

values(imported_raster)<-values(imported_raster)/1e4

#4��
imported_raster_2=raster(dirname[7],band=1)
#band1ΪNDVI��band2ΪEVI
max(values(imported_raster_2))
min(values(imported_raster_2))
#��rasterֵ����1e4���ﵽNDVI��������Χֵ��
values(imported_raster_2)<-values(imported_raster_2)/1e4

#5��
imported_raster_3=raster(dirname[8],band=1)
#band1ΪNDVI��band2ΪEVI
max(values(imported_raster_3))
min(values(imported_raster_3))
#��rasterֵ����1e4���ﵽNDVI��������Χֵ��
values(imported_raster_3)<-values(imported_raster_3)/1e4

#��ƽ��
values(imported_raster)<-(values(imported_raster)+values(imported_raster)+values(imported_raster))/3

#��raster

writeRaster(imported_raster, "E:/��ѧ����/2019Summer_dust-NDVI/0430 2018����ƽ��NDVI/2018_Spring_NDVI.tif", format = "GTiff")