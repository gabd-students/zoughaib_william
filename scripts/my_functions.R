## William Zoughaib
## Two Functions


library(tidyverse)

### Creating my std_err function
####calculate standard error of the mean
#### chosen vector family_ages plus a dog <- c(51,51,22,20,5).  will be replacing vector with family_ages
#### Second argument will be to remove or keep NA.  (Default is false)
family_ages <- c(51,51,22,20,5)

std_error <- function(vector,na.rm=FALSE){   #function argument tells R that we are creating a function
  ifelse(na.rm,
         vector <- na.omit(vector),          #na.rm is always default.  
         vector)
  (sd(vector)/sqrt(length(vector)))}         # actually formula to obtain std_error

std_error(family_ages,na.rm=FALSE)
std_error(family_ages,na.rm=TRUE)
#### std_error for both of these is the same.  



### Create Scaled Mass index function using scaled_mass vector
#### Mass argument represents mass for birds
#### Tarsus argument represents tarsus length
#### Slope argument represents slope argument
##### each of these arguments will be set to zero
#### Remember to use function() to create SMI function; remember to use {} as that actually creates function

scaled_mass <- function(mass=0,tarsus=0,slope=0){
  mass*(((mean(tarsus))/tarsus))^slope 
  }

scaled_mass(mass=mass <- c(26.7,22.8,25.7,26.1,23.9),tarsus=tarsus <- c(18.4,17.5,18.4,18.0,18.2),slope=1.5)
  
  

###THE END