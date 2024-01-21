FROM rocker/r-ver:4.3.2

RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgit2-dev
    
COPY languager /usr/local/src/languager
COPY adjust_description.R /usr/local/src/languager/adjust_description.R

WORKDIR /usr/local/src/languager

RUN R -e "install.packages(c('bslib', 'config', 'dplyr', 'forcats', 'golem', 'lubridate', 'magrittr', 'pkgload', 'purrr', 'readr', 'remotes', 'rlang', 'roxygen2', 'shiny', 'stringr', 'tibble', 'tidyr'))"

# Run R script to remove dependencies from DESCRIPTION file
RUN Rscript adjust_description.R restricted=TRUE

# Expose dynamic port
EXPOSE $PORT

CMD R -e "options(shiny.host='0.0.0.0');source('app.R');languager::run_app(translator=FALSE)"
