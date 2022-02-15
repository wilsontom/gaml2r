# gaRI

 [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![R-CMD-check](https://github.com/wilsontom/gaRI/workflows/R-CMD-check/badge.svg)](https://github.com/wilsontom/gaRI/actions) 
 
 > **g**eneralized **a**nalytical markup manguage: **R**efractive **I**ndex
 
 ## Getting Started
 
 The `gaRI` package can easily be installed direct from GitHub
 
 ```r
 remotes::install_github('wilsontom/gaRI')
 ```
 
 
 Then to open a GAML file containing Refractive Index data, simply use the `open_file` function;
 
 ```r
myData <- gaRI::openFile('my_file.gaml')
 ```


 To extract the data into a `tibble` ready for plotting;
 
 ```r
library(magrittr)

sampleName <- myData %>% purrr::map_chr(., ~ {
  .$sampleName
})

print(sampleName)

allData <- list()
for (i in seq_along(sampleName)) {
  allData[[i]] <-
    tibble::tibble(
      sampleName = sampleName[[i]],
      retentionTime = myData[[i]]$time,
      refractiveIndex = myData[[i]]$abs
    )
} 
 

allDataFinal <- allData %>% dplyr::bind_rows()

```
 


