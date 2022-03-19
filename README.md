# gaml2r

 [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental) [![R-CMD-check](https://github.com/wilsontom/gaml2r/workflows/R-CMD-check/badge.svg)](https://github.com/wilsontom/gaml2r/actions) [![codecov](https://codecov.io/gh/wilsontom/gaml2r/branch/master/graph/badge.svg?token=NHwjPwgbAR)](https://codecov.io/gh/wilsontom/gaml2r) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0") 
 
 
 ### Getting Started
 
 ```r
 remotes::install_github('wilsontom/gaml2r')
 ```
 
  Then to open a GAML file simply use the `open_file` function;
 
 ```r
myData <- gaml2r::openFile('my_file.gaml', output = 'list')
 ```

