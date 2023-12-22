# 00 Preparation ---------------------------------------------------------------

cat("System information:\n")
sysinfo <- Sys.info()
for (i in seq_along(sysinfo))
  cat(" ", names(sysinfo)[i], ":", sysinfo[i], "\n")
options(warn = 2)

library("fairqDataTrafficDetectors")
library("methods")
sessionInfo()

# 01 Start ETL -----------------------------------------------------------------

status <- main()
