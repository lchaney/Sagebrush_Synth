require(lme4)
require(lmerTest)
require(ggplot2)
require(doBy)
require(MuMIn)
require(xlsx)
require(lattice)
require(data.table)
require(merTools)
#=================================================================================================#
###READ IN DATA
grw1 <- read.csv(file="master6-15_grw.csv", sep=",",head=TRUE, na.string="na")
grw <- na.omit(grw1)

grw_log = log1p(grw$grwvol_m)
grw <- cbind(grw,grw_log)

wytri<- subset(grw, grw$type=="t2x"| grw$type=="w4x"|grw$type=="t4x")
#=================================================================================================#
###VARIABLE ELIMINATION w/ POPMEANS
popgrw <- summaryBy(grw_log+mat+map+gsp+mtcm+mmin+mtwm+mmax+sday+fday+ffp+dd5+gsdd5+d100+dd0+mmindd0+smrpb+smrsprpb+sprp+smrp+winp ~ pop+garden+year+ssp+type, FUN = c(mean), data=wytri)
setnames(popgrw, old = c('grw_log.mean','mat.mean','map.mean','gsp.mean','mtcm.mean','mmin.mean','mtwm.mean','mmax.mean','sday.mean','fday.mean','ffp.mean','dd5.mean','gsdd5.mean','d100.mean','dd0.mean','mmindd0.mean','smrpb.mean','smrsprpb.mean','sprp.mean','smrp.mean','winp.mean'),
         new = c('grw_log','mat','map','gsp','mtcm','mmin','mtwm','mmax','sday','fday','ffp','dd5','gsdd5','d100','dd0','mmindd0','smrpb','smrsprpb','sprp','smrp','winp'))

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
  grw_log))

cor <- cor(data_pop)
###+/-0.25 CORRELATION: mapmtcm,mtcmgsp,d100,dd0,mtcm

full1 <- lmer (grw_log ~ data_pop$mapmtcm + data_pop$dd0 + data_pop$d100 + data_pop$mapmtcm
               + data_pop$mtcm + (1|garden) + (1|year:garden) + (1|type:(year:garden))
               ,REML=TRUE , data=popgrw)

s_full <- step(full1)
s_full

cor.test(data_pop$d100,data_pop$mtcm)

###TWO VARIABLES KEPT: D100, MTCM; D100 kept because of high collinearity (0.85)

#=================================================================================================#
###LMM MODEL
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
  gspmtcm =(gsp*mtcm)/100,
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
  grw_log))

write.xlsx(x = cor, file = "correl.xlsx")

###LMER MODEL
grwmd2 <- lmer(grw_log ~ data_a$d100 + (1|year:garden) + (1|type:(year:garden)) + (1|pop:(type:(year:garden))),REML=TRUE , data=wytri)

###grwmd2 selected by BIC
summary(grwmd2)
rand(grwmd2)

### % VARIATION EXPLAINED
0.01621+0.04328+0.09562+0.05507

#GxE (pop interaction)
gxe <- 0.01621/0.21018

#Type
ssp <- 0.04329/0.21018

#Environment
env <- 0.09562/0.21018

randeff.varexpl <- cbind(env,gxe,ssp)

###EXAMINE RESIDUALS
residuals <- resid(grwmd2) 
summary(residuals)
hist(residuals)
plot(residuals)

####R2
r.squaredGLMM(grwmd2)

###EXTRACT FIXED EFFECTS
y.hat4 <- model.matrix(grwmd2 , type = "fixed") %*% fixef(grwmd2)
#transform back
y.hat4 <- expm1(y.hat4)

####CONFIDENCE INTERVALS
#pp <- profile(grwmd2)
#ci_0.4 <- confint(pp,level=0.4)

###CIs USING PREDICTIONINTERVAL from MERTOOLS
PI <- predictInterval(merMod = grwmd2, newdata = wytri, level = 0.4, n.sims = 1000, stat = "median", type="linear.prediction", include.resid.var = TRUE)

#transform back
#PI <- with(PI, data.frame(fit=fit), lwr.t = expm1(lwr), upr.t = expm1(upr))) 

PIwpops <- cbind(wytri$pop,PI)
#PIwpops <- cbind(wytri$pop,PI.t)
colnames(PIwpops)[1] <- "pop"

PIavg <- summaryBy(fit+ upr + lwr ~ pop, data = PIwpops, FUN = c(mean))
#PIavg <- summaryBy(fit.t+ upr.t + lwr.t ~ pop, data = PIwpops, FUN = c(mean))

###CALCULATION of AVERAGE 2X CI
CI2X <- PIavg$upr.mean-PIavg$lwr.mean
#CI2X <- PIavg$upr.t.mean-PIavg$lwr.t.mean
mean(CI2X)


###PLOT OF CIs FOR 39 POPULATIONS
gg <-ggplot(aes(x=pop, y=fit.mean, ymin=lwr.mean, ymax=upr.mean), data=PIavg)
gg + geom_point() + geom_linerange() + labs(x="Populations", y="Prediction w/ 40% PI") + theme_bw()


####RANDOM EFFECTS
re_garden <- ranef(grwmd2, condVar=TRUE, whichel = "year:garden")
re_type <- ranef(grwmd2, condVar=TRUE, whichel = "type:(year:garden)")
re_pop <- ranef(grwmd2, condVar=TRUE, whichel = "pop:(type:(year:garden))")

dotplot(re_garden)
dotplot(re_type)
dotplot(re_pop)
#=================================================================================================#
###SUMMARY
fitted <- expm1(fitted(grwmd2))

fit <- with(wytri, data.frame(pop=pop, garden=garden, ssp=ssp, type=type, family=family, observed=grwvol_m,fitted=fitted))

fit_pop_g <- summaryBy(observed + y.hat4 + fitted ~ pop + type + garden, data= fit, FUN = c(mean))
fit_pop <- summaryBy(observed + y.hat4 + fitted ~ pop + type, data= fit, FUN = c(mean))
write.xlsx(x = fit_pop, file = "grwsummary.xlsx")

###FIXED EFF GRAPH FOR MANUSCRIPT
q<-ggplot(fit_pop_g, aes(y=observed.mean,x=fitted.mean))+theme_bw() 
q+stat_smooth(method=lm,se=FALSE,linetype=4,color="gray",size=1) + geom_point(aes(shape=garden),size=3) + xlab("Predicted") + ylab("Observed") + labs(shape = "Gardens") +scale_shape(solid=FALSE) 

p<-ggplot(fit_pop_g, aes(y=observed.mean,x=y.hat4.mean,shape=garden,fill=garden))+theme_bw() 
p+stat_smooth(method=lm,se=FALSE,linetype=4,size=1,color="gray") + geom_point(size=3) + xlab("Predicted") + ylab("Observed") + labs(color = "Gardens") + scale_shape_manual(values=c(21,22,24))






