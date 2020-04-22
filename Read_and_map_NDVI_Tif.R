# NAN Yang
# 2020-04-22
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
str_name<-'F:/NDVI-1km/2018/EOST_MODIS_CHN_A3_NVI_MLT_GLL_20180060_AOAM_1000M_MS.tif'
#band1ΪNDVI��band2ΪEVI
imported_raster=raster(str_name,band=1)
imported_raster

plot(imported_raster,axes=FALSE)

#imported_matrix<-as.matrix(imported_raster)


#��rasterֵ����1e4���ﵽNDVI��������Χֵ��
max(values(imported_raster))
min(values(imported_raster))

values(imported_raster)<-values(imported_raster)/1e4



#2. Read in and map the region data-----------------
regionpath<-'E:/��ѧ����/2019Summer_dust-NDVI/Province_9/Province_9.shp'

region<-readOGR(regionpath)

imported_raster
region

print(region@data$name,encoding = "UTF-8")

#������������ϵ��һ��
#region <- spTransform(region, CRS("+proj=longlat +ellps=GRS80 +no_defs"))


#ggplot()+geom_polygon(data=region,  aes(x=long, y=lat, group=group), 
#                      fill="cadetblue", color="grey")+
#  coord_equal()

#ggplot(imported_raster) + geom_tile(aes(fill=factor(imported_raster),alpha=0.8)) + 
#  geom_polygon(data=region, aes(x=long, y=lat, group=group), 
#               fill=NA,color="grey50", size=1)+
#  coord_equal()

#��������һ����������raster����ת��data.frameȻ����ggplot��ͼ
test=imported_raster

test_spdf <- as(test, "SpatialPixelsDataFrame")
test_df <- as.data.frame(test_spdf)
colnames(test_df) <- c("value", "x", "y")


ggplot() +  
  geom_tile(data=test_df, aes(x=x, y=y, fill=value), alpha=0.8)+
  geom_polygon(data=region, aes(x=long, y=lat, group=group), 
               fill=NA, color="grey50", size=0.25) +
  scale_fill_viridis() +
  coord_equal() +
  theme_map() +
  theme(legend.position="bottom") +
  theme(legend.key.width=unit(2, "cm"))