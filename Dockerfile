#################################################################
# Dockerfile
# Description:      R and required packages to make the permutation analysis of p-values
# Base Image:       r-base:4.3.1
#################################################################

#R image to be the base in order to build our new image
FROM  r-base:4.3.1

#Maintainer and author
MAINTAINER Magdalena Arnal

#Install Ubuntu extensions in order to run r
RUN apt-get update && apt-get install -y\
 wget unzip bzip2 g++ make\
 r-cran-xml\
 libssl-dev\
 libcurl4-openssl-dev\
 libxml2-dev\
 libfftw3-dev

ENV PATH=pkg-config:$PATH

#Install packages from CRAN
RUN Rscript -e 'install.packages(c("R.utils","data.table", "gtools", "gplots", "BiocManager", "harmonicmeanp"))'

#Install bioconductor packages
RUN Rscript -e 'BiocManager::install(c("multtest"))'

#Install the remaining packages
RUN Rscript -e 'install.packages(c("mutoss","metap"))'

# Clean up and set Workingdir at Home
RUN apt-get clean
WORKDIR /
