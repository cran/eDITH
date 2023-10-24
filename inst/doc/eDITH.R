## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("eDITH")

## ---- eval=FALSE--------------------------------------------------------------
#  devtools::install_github("lucarraro/eDITH")

## ----overview, echo=FALSE, fig.cap="Flowchart for the choice of covariates used to fit the eDITH model.", out.width = '90%'----
knitr::include_graphics("flowchart_cov.png")


## ---- eval=FALSE--------------------------------------------------------------
#  # Extract river from DEM
#  river <- rivnet::extract_river(outlet=c(637478,237413),
#                      EPSG=21781, #CH1903/LV03 coordinate system
#                      ext=c(6.2e5,6.6e5,2e5,2.5e5),
#                      z=9)
#  
#  # Aggregate river - default thrA and maxReachLength = 2500 m
#  river <- rivnet::aggregate_river(river, maxReachLength = 2500)
#  
#  # Hydraulic data: width = 8 m, discharge = 15 m3/s at the outlet
#  hydrodata <- data.frame(data = c(8, 15),
#                          type = c("w", "Q"),
#                          node = river$AG$outlet*c(1, 1))
#  
#  # Assign hydraulic variables across the river network
#  river <- rivnet::hydro_river(hydrodata, river)
#  
#  # Attribute landcover classes as covariates
#  r1 <- terra::rast(system.file("extdata/landcover.tif",
#                         package = "rivnet"))
#  river <- rivnet::covariate_river(r1, river)
#  

## ---- eval=FALSE--------------------------------------------------------------
#  data(dataC)

## ---- eval=FALSE--------------------------------------------------------------
#  dataC[which(dataC$ID==2),]
#  #>    ID       values
#  #> 1   2 0.000000e+00
#  #> 25  2 1.037331e-12
#  #> 49  2 8.176798e-13

## ---- eval=FALSE--------------------------------------------------------------
#  sites <- unique(dataC$ID)
#  values <- numeric(length(sites))
#  for (ind in 1:length(sites)){
#    s <- sites[ind]
#    values[ind] <- mean(dataC$values[dataC$ID==s])
#  }
#  
#  plot(river)
#  rivnet::points_colorscale(river$AG$X[unique(dataC$ID)], river$AG$Y[unique(dataC$ID)],
#                            values)
#  title("Mean observed DNA concentration [mol m-3]")
#  

## ----map2, echo=FALSE, out.width = '80%'--------------------------------------
knitr::include_graphics("map2.png")


## ---- eval=FALSE--------------------------------------------------------------
#  covariates <- data.frame(urban = river$SC$locCov$landcover_1,
#                           agriculture = river$SC$locCov$landcover_2,
#                           forest = river$SC$locCov$landcover_3,
#                           elev = river$AG$Z,
#                           log_drainageArea = log(river$AG$A))
#  

## ---- eval=FALSE--------------------------------------------------------------
#  set.seed(1)
#  out.bt.cov <- run_eDITH_BT(dataC, river, covariates)
#  

## ---- eval=FALSE--------------------------------------------------------------
#  set.seed(1)
#  out.bt.aem <- run_eDITH_BT(dataC, river)
#  

## ---- eval=FALSE--------------------------------------------------------------
#  set.seed(27)
#  out.opt.aem <- run_eDITH_optim(dataC, river, n.AEM = 10,
#  	n.attempts = 1)

## ---- eval=FALSE--------------------------------------------------------------
#  plot(out.opt.aem$C[dataC$ID], dataC$values,
#       xlim=c(0,8e-12), ylim=c(0, 8e-12), asp=1,
#       xlab = "Modelled concentration [mol m-3]",
#       ylab = "Observed concentration [mol m-3]")
#  abline(0,1)

## ----Cobs, echo=FALSE, out.width = '80%'--------------------------------------
knitr::include_graphics("Cobs.png")


## ---- eval=FALSE--------------------------------------------------------------
#  plot(river, out.opt.aem$C, colLevels=c(0, max(values), 1000), addLegend = FALSE,
#       colPalette = hcl.colors(1000, "Reds 3", rev=T))
#  rivnet::points_colorscale(river$AG$X[unique(dataC$ID)], river$AG$Y[unique(dataC$ID)],
#                            values)
#  title("DNA concentration [mol m-3]")

## ----mapC, echo=FALSE, out.width = '80%'--------------------------------------
knitr::include_graphics("mapC.png")


## ---- eval=FALSE--------------------------------------------------------------
#  plot(river, out.opt.aem$p)
#  title('DNA production rate [mol m-2 s-1]')

## ----mapp, echo=FALSE, out.width = '80%'--------------------------------------
knitr::include_graphics("mapp.png")


## ---- eval=FALSE--------------------------------------------------------------
#  plot(river, out.opt.aem$probDet)
#  title('Detection probability')

## ----mappD, echo=FALSE, out.width = '80%'-------------------------------------
knitr::include_graphics("mappD.png")


