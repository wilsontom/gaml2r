# gamlr

 [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![R-CMD-check](https://github.com/wilsontom/gamlr/workflows/R-CMD-check/badge.svg)](https://github.com/wilsontom/gamlr/actions) [![codecov](https://codecov.io/gh/wilsontom/gamlr/branch/master/graph/badge.svg?token=NHwjPwgbAR)](https://codecov.io/gh/wilsontom/gamlr) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0") 
 
 
 ### Getting Started
 
 ```r
 remotes::install_github('wilsontom/gaRI')
 ```
 
  Then to open a GAML file simply use the `open_file` function;
 
 ```r
myData <- gamlr::openFile('my_file.gaml', output = 'list')
 ```

