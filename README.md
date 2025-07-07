# fairq-data-traffic-detectors

This repository contains R code that retrieves data from 
https://api.viz.berlin.de/daten/verkehrsdetektion and stores it in a Clickhouse 
database.


## How to get started

- Create an .Renviron file in the project folder, see `.Renviron_template` for 
the structure
- Build the R package
- Create database as described in https://github.com/fairqBerlin/fairq-data/tree/public/inst/db (schema fairq_raw)


## Most important files

- `inst/RScripts/main.R` is a script that retrieves data from 
https://api.viz.berlin.de/daten/verkehrsdetektion. It retrieves all data from
January 2015 until a specified year and month.
As soon as the data in the API are updated, update the maximum year and month
in `create_urls()` (file `R/02_urls.R`), rebuild the R package and run `main.R`
again. This will update all years' data. This ensures 
that any updated values are included.
- `inst/reports/data_validation/data_validation.qmd` creates a data validation
report of all traffic data that is stored in the database.

## Create a Data validation report

### Use Quarto

```
quarto render inst/reports/data_validation/data_validation.qmd --output data_validation.pdf
```

### With Docker

1. Build the docker image: 

   ```
   docker build --network=host -t fairq-data-traffic-detectors .
   ```

2. Run the docker container: 

   ```
   docker run -it --rm fairq-data-traffic-detectors bash
   ``````

3. Render the report using quarto: 

   ```
   quarto render inst/reports/data_validation/data_validation.qmd
   ```

4. Fetch the container id:

   ```
   docker ps
   ```

5. Copy the report from the container:

   ```
   docker cp <CONTAINER ID>:/app/inst/reports/data_validation/data_validation.pdf data_validation.pdf
   ```

## Input and output

### Input

- API https://api.viz.berlin.de/daten/verkehrsdetektion

### Output

- Database, schema `fairq_raw`

## Code style

Please use the RStudio code autoformatter by pressing `Ctrl + Shift + A`
to format the selected code.
