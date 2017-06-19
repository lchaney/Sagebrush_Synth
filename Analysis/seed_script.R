#==============================================================================================#
# Script created by Bryce Richardson and Lindsay Chaney 2017
# Script created in version R 3.3.3 
# This script is used to run the seed yeild analsyis
#==============================================================================================#

###READ IN DATA

wytri <- read.csv(file="Data/seed_dat.csv", sep=",",head=TRUE, na.string="na")

#==============================================================================================#

###TRANFORMATION

seed_log = log1p(wytri$weight)
wytri <- cbind(wytri,seed_log)
#===================================================================================================#

###VARIABLE ELIMINATION

popgrw <- summaryBy(seed_log+mat+map+gsp+mtcm+mmin+mtwm+mmax+sday+fday+ffp+dd5+gsdd5+d100+dd0+mmindd0+smrpb+smrsprpb+sprp+smrp+winp ~ pop+garden+year+ssp+type, FUN = c(mean), data=wytri)
setnames(popgrw, old = c('seed_log.mean','mat.mean','map.mean','gsp.mean','mtcm.mean','mmin.mean','mtwm.mean','mmax.mean','sday.mean','fday.mean','ffp.mean','dd5.mean','gsdd5.mean','d100.mean','dd0.mean','mmindd0.mean','smrpb.mean','smrsprpb.mean','sprp.mean','smrp.mean','winp.mean'),
         new = c('seed_log','mat','map','gsp','mtcm','mmin','mtwm','mmax','sday','fday','ffp','dd5','gsdd5','d100','dd0','mmindd0','smrpb','smrsprpb','sprp','smrp','winp'))

data_pop=with(popgrw, data.frame(
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
  seed_log))

cor <- cor(data_pop)

#==============================================================================================#

###STEPDOWN W/ COR COEF -/+0.25

full1 <- lmer (seed_log ~ data_pop$pratio + data_pop$dd0map
               + data_pop$dd5mtcm + data_pop$mapmtcm + data_pop$winp + data_pop$mtcmmap + data_pop$mtcm 
               + data_pop$gspmtcm + (1|garden) + (1|year:garden) + (1|type:(year:garden))
               ,REML=TRUE , data=popgrw)
s_full <- step(full1) 
s_full

#===================================================================================================#

###CLIMATE DATA FOR EACH SAMPLE

data_a=with(wytri, data.frame(
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
  seed_log))
wt_cor <- cor(data_a)

#===================================================================================================#

##### LMER MODEL EVAL

aseed1 <- lmer (seed_log ~ data_a$pratio + (1|year:garden) + (1|type:(year:garden)) + (1|pop:(type:(year:garden))), REML=TRUE , data=wytri)

summary(aseed1)
rand(aseed1)

#==============================================================================================#

####RANDOM EFFECTS

re_garden <- ranef(aseed1, condVar=TRUE, whichel = "garden")
re_year <- ranef(aseed1, condVar=TRUE, whichel = "year:garden")
re_type <- ranef(aseed1, condVar=TRUE, whichel = "type:(year:garden)")
re_pop <- ranef(aseed1, condVar=TRUE, whichel = "pop:(type:(year:garden))")

dotplot(re_garden)
dotplot(re_year)
dotplot(re_type)
dotplot(re_pop)

### % VARIANCE EXPLAINED
#TOTAL
0.4282+0.3106+1.3874+0.6035
#2.7297

#GxE (pop interaction)
gxe <- 0.4281/2.7297

#Subspecies
ssp <- 0.3124/2.7297

#Environment
env <- 1.3874/2.7297

ranef.varexpl <- cbind(env,gxe,ssp)

#==============================================================================================#

###EXAMINE RESIDUALS

residuals <- resid(aseed1) 
summary(residuals)
hist(residuals)
plot(residuals)

####R2
r.squaredGLMM(aseed1)

#==============================================================================================#

###EXTRACT FIXED EFFECTS

y.hat4 <- model.matrix(aseed1 , type = "fixed") %*% fixef(aseed1)
#transform back
y.hat4 <- expm1(y.hat4)

#==============================================================================================#

####CONFIDENCE INTERVALS

#pp <- profile(aseed1)
#ci_0.4 <- confint(pp,level=0.4)
#clim_est <- fixef(aseed1, condVar = TRUE)
#ctable <- cbind(clim_est,ci_0.4)

#==============================================================================================#

#USING PREDICTIONINTERVAL from MERTOOLS

PI <- predictInterval(merMod = aseed1, newdata = wytri, level = 0.4, n.sims = 1000, stat = "median", type="linear.prediction", include.resid.var = TRUE)
#transform back
#PI.t <- with(PI, data.frame(fit.t= expm1(fit), lwr.t = expm1(lwr), upr.t = expm1(upr)))

#PI.t <- round(PI.t, digits = 3)
PIwpops <- cbind(wytri$pop,PI)
colnames(PIwpops)[1] <- "pop"

#PIavg <- summaryBy(fit.t+ upr.t + lwr.t ~ pop, data = PIwpops, FUN = c(mean))
PIavg <- summaryBy(fit+ upr + lwr ~ pop, data = PIwpops, FUN = c(mean))


###CALCULATION of AVERAGE 2X CI
#CI2X <- PIavg$upr.t.mean-PIavg$lwr.t.mean
CI2X <- PIavg$upr.mean-PIavg$lwr.mean
mean(CI2X)

#==============================================================================================#

###PLOT OF CIs FOR 39 POPULATIONS
gg <-ggplot(aes(x=pop, y=fit.mean, ymin=lwr.mean, ymax=upr.mean), data=PIavg)
gg + geom_point() + geom_linerange() + labs(x="Populations", y="Prediction w/ 40% PI",check_overlap=TRUE) + theme_bw()

#==============================================================================================#

###SUMMARY

fit <- with(wytri, data.frame(pop=pop, garden=garden, ssp=ssp, type=type, family=family, observed=weight,fitted=fitted(aseed1)))
fit <- cbind(fit,y.hat4) 

fit_pop_g <- summaryBy(observed + fitted + y.hat4 ~ pop + type + garden, data= fit, FUN = c(mean))
fit_pop <- summaryBy(observed + fitted + y.hat4 ~ pop + type, data= fit, FUN = c(mean))
write.xlsx(x = fit_pop, file = "Output/seedsummary.xlsx")

#==============================================================================================#

###FIXED EFF GRAPH FOR MANUSCRIPT

q<-ggplot(fit_pop_g, aes(y=observed.mean,x=fitted.mean))+theme_bw() 
q+stat_smooth(method=lm,se=FALSE,linetype=4,color="gray",size=1) + geom_point(aes(shape=garden),size=3) + xlab("Predicted") + ylab("Observed") + labs(shape = "Gardens") +scale_shape(solid=FALSE) 

p<-ggplot(fit_pop_g, aes(y=observed.mean,x=y.hat4.mean,shape=garden,fill=garden))+theme_bw() 
p+stat_smooth(method=lm,se=FALSE,linetype=4,size=1,color="gray") + geom_point(size=3) + xlab("Predicted") + ylab("Observed") + labs(color = "Gardens") + scale_shape_manual(values=c(21,22,24))