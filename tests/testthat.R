library(testthat)
library(lintr)
library(fairqDataTrafficDetectors)

Sys.setenv(NOT_CRAN = "true")

test_check("fairqDataTrafficDetectors")
