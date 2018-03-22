if (Sys.info()["sysname"] == "Darwin") {
  userPackageDir = sprintf("%s/R/%s.%s", path.expand("~"), R.Version()$major, R.Version()$minor)
  dir.create(userPackageDir, showWarnings = FALSE, recursive = TRUE)  
  .libPaths(userPackageDir)
}

options(
  warnPartialMatchArgs = TRUE,
  warnPartialMatchAttr = TRUE,
  warnPartialMatchDollar = TRUE,
  repos = c(CRAN = "https://cloud.r-project.org"),
  browserNLdisabled = TRUE
)
