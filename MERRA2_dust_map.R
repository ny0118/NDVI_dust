#MERRA2 dust map 2000-2019 
#2020-04-29
#Author�� Dr. NAN Yang

#(1)read MERRA2 dust mean data--------------------
getwd()
dirname='E:/��ѧ����/2019Summer_dust-NDVI/0430 MERRA2ȷ��ɳ��Դ/'
setwd(dirname)
filename<-list.files(dirname,full.names=T,all.files=T,recursive=T)

filename[1]
filename[2]

library(ncdf4)

nc <- nc_open(filename[2])

print(nc)

#unit: kg/m3
dust_mass<-ncvar_get( nc = nc, varid = 'M2TMNXAER_5_12_4_DUSMASS')

#convert to ug/m3 [0,508]
dust_mass=dust_mass*1e9

max(dust_mass);min(dust_mass)

lon<-ncvar_get( nc = nc, varid = 'lon')
lat<-ncvar_get( nc = nc, varid = 'lat')

max(lon);min(lon)
max(lat);min(lat)

nc_close( nc )



#���ݾ�γ����Ϣ����matrix��ɶ�Ӧ��γ�ȵ�data.frame

#lon lat val
library(reshape2)

colnames(dust_mass)<-lat
rownames(dust_mass)<-lon

dust_mass_df <- melt(dust_mass)

colnames(dust_mass_df)<-c('lon','lat','val')


#(2)��map---------------
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
library(mapproj)
library(sf)

library(RColorBrewer)

#https://www.jianshu.com/p/7409a2189111
regionpath<-'E:/��ѧ����/2019Summer_dust-NDVI/R_project/china-province-border-data-bou2_4p-shp/bou2_4p.shp'
region<-readOGR(regionpath)

regionpath_dust<-'E:/��ѧ����/2019Summer_dust-NDVI/R_project/desert.shp'
region_dust<-readOGR(regionpath_dust)

#�鿴ɳĮ����
plot(region_dust[region_dust$CLASS==999])
length(region_dust)
names(region_dust)

table(iconv(region_dust$CLASS, from = "GBK"))

getwd()
dirname='E:/��ѧ����/2019Summer_dust-NDVI/0430 MERRA2ȷ��ɳ��Դ/'
setwd(dirname)
jpeg(file = "ͼ1-desert.jpeg",width=1200,height=800)


#��ͼ��
ggplot() + 
  
  geom_tile(data=dust_mass_df, aes(x=lon, y=lat, fill=val), alpha=0.8)+#����
  geom_polygon(data=region, aes(x=long, y=lat, group=group), 
               fill="white",colour="black", size=0.5,alpha=0.1) +
  geom_polygon(data=region_dust, aes(x=long, y=lat, group=group), 
               colour="black", size=0.5,alpha=0.1) +
  #geom_point(data=dust_mass_df, aes(x=lon, y=lat,colour = val),alpha=.9)+#վ��
  labs(title=expression("MERRA2 2000-2019 monthly mean surface dust mass"))+

  #����color
  #palette�ο�ѡ��http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/figure/unnamed-chunk-14-1.png
  #scale_fill_viridis( name = "����ͼ������") +
  scale_fill_distiller(name=expression('Units: '*mu*"g / "*m^{3}*' ') ,palette="Spectral",limits=c(0,510),breaks=seq(0,500,100))+
  #scale_fill_gradient(name=expression('Units: "*mu*"g /"*m^{3}*' '),low = "blue", high = "red",limits=c(0,600),breaks=seq(0,600,100))+
  
  #����rectangle
  #��1���ο�An 2018�Ķ���
  geom_rect(aes(xmin=76,xmax=90,ymin=37,ymax=42),linetype=2, alpha=0,size=1,color="black")+#R1
  geom_rect(aes(xmin=87,xmax=95,ymin=44,ymax=50),linetype=2, alpha=0,size=1,color="black")+#R2
  geom_rect(aes(xmin=97,xmax=110,ymin=38,ymax=45),linetype=2, alpha=0,size=1,color="black")+#R3
  geom_rect(aes(xmin=114,xmax=118,ymin=42,ymax=45),linetype=2, alpha=0,size=1,color="black")+#R3
 

  #theme_map() +
  theme(legend.position="bottom") + #"none", "left", "right", "bottom", "top", or two-element numeric vector
  theme(legend.key.width=unit(2, "cm"))+
  xlab("Longitude(��)")+
  ylab("Latitude(��)")+
  xlim(70,140)+ylim(15,55)+ #���徭γ�ȷ�Χ
  
  #����ͶӰ��ʽ
  coord_map("mercator")
  #coord_map("polyconic")
  #coord_map("lambert", lat0=0, lat=60)#Lambert��lat0,lat���ǲ�̫���ɶ��˼
  #coord_map()
  #coord_equal() #+  #��γ����ͬ�Ļ�ͼ����
  #coord_fixed(ratio = 1)#+


dev.off()
