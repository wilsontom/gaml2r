# gaml2r

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![R-CMD-check](https://github.com/wilsontom/gaml2r/workflows/R-CMD-check/badge.svg)](https://github.com/wilsontom/gaml2r/actions) [![codecov](https://codecov.io/gh/wilsontom/gaml2r/branch/master/graph/badge.svg?token=NHwjPwgbAR)](https://codecov.io/gh/wilsontom/gaml2r) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")

### Getting Started

``` r
 remotes::install_github('wilsontom/gaml2r')
```

Then to open a GAML file simply use the `open_file` function;

``` r
myData <- gaml2r::openFile('my_file.gaml', output = 'list', include_injection_info = FALSE)
```

Using `output = 'list'` will return a list for each sample, where `output = 'tbl_df'` then all the data is returned in long format, as a tibble.

If the `gaml` file has been created using custom export options (to include the sample injection properties), then specifying `include_injection_info = TRUE` will output these values alongside the exported data. 


The SHA1 Integrity Algorithm for a GAML file can be retrieved using the following function;

``` r
SHA1 <- gaml2r::get_sha1('my_file.gaml')  
```

Details on the GAML conversion parameters can be retrieved using the `get_parameters` function.

``` r
GAML_Params <- gaml2r::get_parameters('my_file.gaml')
```
