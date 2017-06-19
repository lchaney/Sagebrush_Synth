#==============================================================================================#
# Script created by Bryce Richardson and Lindsay Chaney 2017
# Script created in version R 3.3.3 
# This script is used to run the joint PCA analsyis
#==============================================================================================#

###READ IN DATA
sage<- read.csv(file="Data/pca_synthesis.csv", sep=",",head=TRUE, na.strings = "na")

sage <- na.omit(sage)
qdata <- sage[, c("flower","seed","growth","survival")]
subspecies <- sage[,2]
region <- sage[,4]

cor(qdata)
cor.test(~seed + flower, data=qdata)
cor.test(~growth + survival, data=qdata)
cor.test(~seed + survival, data=qdata)
cor.test(~growth + flower, data=qdata)
cor.test(~growth + seed, data=qdata)
cor.test(~survival + flower, data=qdata)

ggpairs(qdata[,(1:4)])

#===============================================================================#
##VARIATION EXPLAINED
var_expl<- read.csv(file="Data/model_var_explained.csv", sep=",",head=TRUE, na.strings = "na")

g <- ggplot(var_expl, aes(Trait, proportion, fill=Factor,color = Factor), position = position_stack(reverse = FALSE))
g + geom_col(width = 0.4) + scale_fill_brewer(palette = "Set1") + coord_flip()+ scale_color_manual(values=c("Environment"="black","GxE"="black","ssp"="black"))  + theme_classic() 

#===============================================================================#
###PCA
pc <- prcomp(qdata, scale = TRUE, center = TRUE, retx = TRUE)
summary(pc)
loadings <- pc$rotation[,1:2]
print(pc)
pc1 <- pc$x[,1:2]


###PCA BIPLOT
g <- ggbiplot(pc, obs.scale = 1, var.scale = 1, 
              groups = subspecies, ellipse = FALSE, 
              circle = FALSE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
g
print(g)

###APPEND PC1 and 2 
pc1_2 <- cbind(sage,pc1)


#===============================================================================#
###CLIMATE ANALYSIS with PC1

data_a=with(pc1_2, data.frame(
  tdiff=mtwm-mtcm,
  adi = (dd5**0.5)/map,
  adimindd0= ((dd5**0.5)/map)*mmindd0,
  d100,
  dd0,
  dd5,
  fday,
  ffp,
  gsdd5,
  gsp,
  dd5mtcm = dd5*mtcm,
  pratio = gsp/map,
  gspdd5 =(gsp*dd5)/1000,
  gspmtcm =(gsp*mtcm)/1000,
  gsptd  =(gsp*(mtwm-mtcm))/100,
  map=map,
  mapdd5 =(map*dd5)/1000,
  mapmtcm =(map*mtcm)/1000,
  maptd  =(map*(mtwm-mtcm))/100,
  mat=mat,
  mmindd0=mmindd0,
  mmax=mmax,
  mmin=mmin,
  mtcm=mtcm,
  mtcmgsp =mtcm/gsp,
  mtcmmap =mtcm/map,
  mtwm=mtwm,
  sday=sday,
  sdi=(gsdd5**0.5)/gsp,
  sdimindd0=((gsdd5**0.5)/gsp)*mmindd0,
  tdgsp  =(mtwm-mtcm)/gsp,
  tdmap  =(mtwm-mtcm)/map,
  smrpb,
  smrsprpb,
  sprp,
  winp,
  smrp,
  sdimtcm=((gsdd5**0.5)/gsp)*mtcm,
  dd0map=dd0/map,
  dd0gsp=dd0/gsp,
  smrpmtcm=(smrp*mtcm)/1000,
  PC1,PC2))
wt_cor <- cor(data_a)
wt_cor <- round(wt_cor,digits = 4)

##PC1 - Climate
lmpc1.1 <- lm(data_a$PC1 ~ data_a$mtcm)
lmpc1.2 <- lm(data_a$PC1 ~ data_a$dd0)
summary(lmpc1.1)
summary(lmpc1.2)
lmpc1.1
###lmpc1.1 higher R2

z <- ggplot(data_a, aes(PC1,predict(lmpc1.1)))
z + geom_point(size = 2,shape=pc1_2$ssp) + theme_bw() + stat_smooth(method = lm,se=FALSE,linetype=4) + scale_shape(solid = FALSE)

##PC2 - Climate
lmpc2.1 <- lm(data_a$PC2 ~ data_a$mtwm)
lmpc2.2 <- lm(data_a$PC2 ~ data_a$mtwm + data_a$winp)
summary(lmpc2.1)
summary(lmpc2.2)
lmpc2.2
###lmpc2.2 higher R2

z <- ggplot(data_a, aes(PC2,predict(lmpc2.2)))
z + geom_point(size = 2,shape=pc1_2$ssp) + theme_bw() + stat_smooth(method = lm,se=FALSE,linetype=4) + scale_shape(solid = FALSE)

###Confidence interval for each PC
CIpc1 <- ((max(predict(lmpc1.1))) - (min(predict(lmpc1.1))))/2.7 
CIpc2 <- ((max(predict(lmpc2.2))) - (min(predict(lmpc2.2))))/2.7
