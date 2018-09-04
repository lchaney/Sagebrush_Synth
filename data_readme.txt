### Data from: Climate-based seed transfer of a widespread shrub: population shifts, restoration strategies and the trailing edge###
## Richardson BA, Chaney L ##

#########################################################################################

file: Richardson_dryad.xlsx

sheet: Survival Data
description: Survival data from two common garden sites, 37 populations, 
	across 5 years

	pop = population ID (seed source location)
	type = subspecies:cytotype group
	garden = common garden location (Ephraim, Majors)
	death = number in population died
	total = total number of population
	surv = number in population survived
	propdead = propotion in population that died

provenical (seed source) climate data:
	MAT = mean annual temperature
	MWMT = mean temperature in the warmest month
	MCMT = mean temperature in the coldest month	
	TD = 
map = mean annual precipitation
		gsp = growing season precipitation, April to September
		
		mmin = minimum temperature in the coldest month
		
		mmax = maximum temperature in the warmest month
		sday = Julian date of the last freezing date of spring
		fday = Julian date of the first freezing date of autumn
		ffp = lenght of the frost-free period
		dd5 = degree-days >5 degrees C (based on mean monthly temperature)
		gsdd5 = degree-days >5 degrees C accumulating within the frost-free period
		d100 = Julian date the sum of degree-days >5 degrees C reaches 100
		dd0 = Degree-days <0 degrees C (based on mean monthly temperature)
		mmindd0 = Degree-days <0 degrees C (based on mean minimum monthly temperature)
		smrpb = Summer precipitation balance: (jul+aug+sep)/(apr+may+jun)
		smrsprpb = Summer/Spring precipitation balance: (jul+aug)/(apr+may)
		sprp = Spring precipitation: (apr+may)
		smrp = Summer precipitation: (jul+aug)
		winp = Winter precipitation: (nov+dec+jan+feb)




file: flower_dat.csv
description: julian date of 50% anthesis in 3 common gardens and 55 populations 
	(1023 observations) during year 2011
	
	Pop: population id (seed source location)
	Family: unique plant ID
	garden: common garden location (Ephraim, Majors, Orchard)
	ssp: identified plant subspecies (T = tridentata (basin), V = vaseyana (mountain),
		W = wyomingensis (Wyoming))
	julian: flowering date --> julian date of 50% anthesis
	long: longitude of source population
	lat: latitude of source population
	elve: elevation of source population
	provenical (seed source) climate data:
		mat = mean annual temperature
		map = mean annual precipitation
		gsp = growing season precipitation, April to September
		mtcm = mean temperature in the coldest month
		mmin = minimum temperature in the coldest month
		mtwm = mean temperature in the warmest month
		mmax = maximum temperature in the warmest month
		sday = Julian date of the last freezing date of spring
		fday = Julian date of the first freezing date of autumn
		ffp = lenght of the frost-free period
		dd5 = degree-days >5 degrees C (based on mean monthly temperature)
		gsdd5 = degree-days >5 degrees C accumulating within the frost-free period
		d100 = Julian date the sum of degree-days >5 degrees C reaches 100
		dd0 = Degree-days <0 degrees C (based on mean monthly temperature)
		mmindd0 = Degree-days <0 degrees C (based on mean minimum monthly temperature)
		smrpb = Summer precipitation balance: (jul+aug+sep)/(apr+may+jun)
		smrsprpb = Summer/Spring precipitation balance: (jul+aug)/(apr+may)
		sprp = Spring precipitation: (apr+may)
		smrp = Summer precipitation: (jul+aug)
		winp = Winter precipitation: (nov+dec+jan+feb)

#########################################################################################

file: flsum.csv
description: flowering model observed mean

	pop: population id (seed source location)
	ssp: identified plant subspecies (T = tridentata (basin), V = vaseyana (mountain),
		W = wyomingensis (Wyoming))
	garden: common garden location (Ephraim, Majors, Orchard)
	lat: latitude of source population
	d100: seed source Julian date the sum of degree-days >5 degrees C reaches 100
	observed.mean: extracted observed mean from model
	y.hat4.mean: extracted y hat mean from model
	fitted.mean: extracted fitted mean from model
	re_pop2: random effects from model
	
#########################################################################################

file: growth_dat.csv
description: growth in 3 common gardens, 2 years and 55 populations (2084 observations)

	Pop: population id (seed source location)
	ssp: identified plant subspecies (T = tridentata (basin), V = vaseyana (mountain),
		W = wyomingensis (Wyoming))
	type: subspecies:cytotype group (cytotype is ploidy (4x = tetraploid, 2x = diploid)
	family: unique plant ID
	garden: common garden location (Ephraim, Majors, Orchard)
	year: y11 = 2011; y12 = 2012
	grwvol_m: combonation of height and crown area via images (see manuscript)
	provenical (seed source) climate data:
		mat = mean annual temperature
		map = mean annual precipitation
		gsp = growing season precipitation, April to September
		mtcm = mean temperature in the coldest month
		mmin = minimum temperature in the coldest month
		mtwm = mean temperature in the warmest month
		mmax = maximum temperature in the warmest month
		sday = Julian date of the last freezing date of spring
		fday = Julian date of the first freezing date of autumn
		ffp = lenght of the frost-free period
		dd5 = degree-days >5 degrees C (based on mean monthly temperature)
		gsdd5 = degree-days >5 degrees C accumulating within the frost-free period
		d100 = Julian date the sum of degree-days >5 degrees C reaches 100
		dd0 = Degree-days <0 degrees C (based on mean monthly temperature)
		mmindd0 = Degree-days <0 degrees C (based on mean minimum monthly temperature)
		smrpb = Summer precipitation balance: (jul+aug+sep)/(apr+may+jun)
		smrsprpb = Summer/Spring precipitation balance: (jul+aug)/(apr+may)
		sprp = Spring precipitation: (apr+may)
		smrp = Summer precipitation: (jul+aug)
		winp = Winter precipitation: (nov+dec+jan+feb)
		
#########################################################################################

file: model_var_explained.csv
description: propotion of variation explained by each model for env, genetics, and gxe
	
	Trait: modeled trait seed yeild, growth, flower phenology, or survival
	Factor: component variation is contributed to, Environment (garden), Genetics (ssp), or GxE
	Propotion: propotion of variation
		
#########################################################################################

file: pca_synthesis.csv
description: data used for pca analsyis

	pop: population ID (seed source location)
	ssp: identified plant subspecies (T = tridentata (basin), V = vaseyana (mountain),
		W = wyomingensis (Wyoming))
	type: subspecies:cytotype group (cytotype is ploidy (4x = tetraploid, 2x = diploid)
	region: region of seed source (gb = great basin; im = wyoming basin)
	seed: fixed effect population means from seed model
	flower: fixed effect population means from flower phenology model
	growth: fixed effect population means from growth model
	survival: fixed effect population means  from survival model
	long: longitude of source population
	lat: latitude of source population
	elve: elevation of source population
	provenical (seed source) climate data:
		mat = mean annual temperature
		map = mean annual precipitation
		gsp = growing season precipitation, April to September
		mtcm = mean temperature in the coldest month
		mmin = minimum temperature in the coldest month
		mtwm = mean temperature in the warmest month
		mmax = maximum temperature in the warmest month
		sday = Julian date of the last freezing date of spring
		fday = Julian date of the first freezing date of autumn
		ffp = lenght of the frost-free period
		dd5 = degree-days >5 degrees C (based on mean monthly temperature)
		gsdd5 = degree-days >5 degrees C accumulating within the frost-free period
		d100 = Julian date the sum of degree-days >5 degrees C reaches 100
		dd0 = Degree-days <0 degrees C (based on mean monthly temperature)
		mmindd0 = Degree-days <0 degrees C (based on mean minimum monthly temperature)
		smrpb = Summer precipitation balance: (jul+aug+sep)/(apr+may+jun)
		smrsprpb = Summer/Spring precipitation balance: (jul+aug)/(apr+may)
		sprp = Spring precipitation: (apr+may)
		smrp = Summer precipitation: (jul+aug)
		winp = Winter precipitation: (nov+dec+jan+feb)	

#########################################################################################

file: prov_clim_contemp.csv
description: 55 sagebrush population seed-source climate. Information on climate 
	variables can be found here: http://charcoal.cnre.vt.edu/climate/details.php; 
	Precipitation in mm and temperature in degrees C

	pop = population ID (seed source location)
	long = population longitude 
	lat = popultion latitude
	elev = population elevation
	mat = mean annual temperature
	map = mean annual precipitation
	gsp = growing season precipitation, April to September
	mtcm = mean temperature in the coldest month
	mmin = minimum temperature in the coldest month
	mtwm = mean temperature in the warmest month
	mmax = maximum temperature in the warmest month
	sday = Julian date of the last freezing date of spring
	fday = Julian date of the first freezing date of autumn
	ffp = lenght of the frost-free period
	dd5 = degree-days >5 degrees C (based on mean monthly temperature)
	gsdd5 = degree-days >5 degrees C accumulating within the frost-free period
	d100 = Julian date the sum of degree-days >5 degrees C reaches 100
	dd0 = Degree-days <0 degrees C (based on mean monthly temperature)
	mmindd0 = Degree-days <0 degrees C (based on mean minimum monthly temperature)
	smrpb = Summer precipitation balance: (jul+aug+sep)/(apr+may+jun)
	smrsprpb = Summer/Spring precipitation balance: (jul+aug)/(apr+may)
	sprp = Spring precipitation: (apr+may)
	smrp = Summer precipitation: (jul+aug)
	winp = Winter precipitation: (nov+dec+jan+feb)	

#########################################################################################

file: seed_dat.csv
description: Seed yeild data from 39 populations, 2 gardens (majors and orchards), two 
	years, and two subspecies (ssp. wyomingensis and tridentata only). Total 583 obs.
	
	Pop: population id (seed source location)
	garden: common garden location (Ephraim, Majors, Orchard)
	year: y12 = 2012; y13 = 2013
	ssp: identified plant subspecies (T = tridentata (basin), V = vaseyana (mountain),
		W = wyomingensis (Wyoming))
	plotid: location in common garden plot
	polidy = identified plant cytotype (4x = tetraploid, 2x = diploid)	
	type = subspecies:cytotype group
	Family: unique plant ID
	subsamp: subsample
	weight: weight of seeds
	long: longitude of source population
	lat: latitude of source population
	elve: elevation of source population
	provenical (seed source) climate data:
		mat = mean annual temperature
		map = mean annual precipitation
		gsp = growing season precipitation, April to September
		mtcm = mean temperature in the coldest month
		mmin = minimum temperature in the coldest month
		mtwm = mean temperature in the warmest month
		mmax = maximum temperature in the warmest month
		sday = Julian date of the last freezing date of spring
		fday = Julian date of the first freezing date of autumn
		ffp = lenght of the frost-free period
		dd5 = degree-days >5 degrees C (based on mean monthly temperature)
		gsdd5 = degree-days >5 degrees C accumulating within the frost-free period
		d100 = Julian date the sum of degree-days >5 degrees C reaches 100
		dd0 = Degree-days <0 degrees C (based on mean monthly temperature)
		mmindd0 = Degree-days <0 degrees C (based on mean minimum monthly temperature)
		smrpb = Summer precipitation balance: (jul+aug+sep)/(apr+may+jun)
		smrsprpb = Summer/Spring precipitation balance: (jul+aug)/(apr+may)
		sprp = Spring precipitation: (apr+may)
		smrp = Summer precipitation: (jul+aug)
		winp = Winter precipitation: (nov+dec+jan+feb)


#########################################################################################

file: surv_dat.csv
description: Survival data from three common garden sites, 55 populations, 
	across 5 years (1299 observations).

	family = unique plant ID
	pop = population ID (seed source location)
	garden = common garden location (Ephraim, Majors, Orchard)
	ssp = identified plant subspecies (T = tridentata (basin),year V = vaseyana (mountain), 
		W = wyomingensis (Wyoming)
	polidy = identified plant cytotype (4x = tetraploid, 2x = diploid)	
	type = subspecies:cytotype group
	timedeath = number of months after planting until death
	time = time in months after planting until death or until the end of experiment
	death = survival status (0 = survived, 1 = mortality)




