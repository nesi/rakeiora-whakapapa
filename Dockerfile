FROM rocker/tidyverse:4.1.0
RUN Rscript -e 'remotes::install_version("vcfR", "1.12.0")'
RUN Rscript -e 'remotes::install_version("pedigreemm","0.3-3")'
RUN Rscript -e 'install.packages("rrBLUP")'
