FROM inwt/r-geos:4.4.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gdebi \
    libcairo2-dev \
    pandoc \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# install fonts
ADD fonts fonts
RUN unzip fonts/Montserrat.zip -d /usr/local/share/fonts/montserrat \
    && fc-cache -sv

# install quarto & tinytex
ADD https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.39/quarto-1.6.39-linux-amd64.deb quarto.deb
RUN gdebi -n -q quarto.deb \
    && rm quarto.deb \
    && quarto install tinytex

ADD . .

RUN installPackage \
    ggmap \
    INWTstyles \
    INWTutils \
    rmarkdown

CMD ["quarto", "render", "inst/reports/data_validation/data_validation.qmd"]
