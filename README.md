
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/bplyr.svg?branch=master)](https://travis-ci.org/yonicd/bplyr)
[![Codecov test
coverage](https://codecov.io/gh/yonicd/bplyr/branch/master/graph/badge.svg)](https://codecov.io/gh/yonicd/bplyr?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2019_03_05-yellowgreen.svg)](http://tinyurl.com/y4cpzsxq)

# base + plyr = bplyr

Run basic functions of `dplyr` and `tidyr` with only base `R` and
`rlang`.

> Disclaimer: this is experimental, use deliberately and with caution.

> Previously called noplyr

## When could this package be useful?

  - Non DBI related data manipulations
  - Continuous integration `R` scripts
  - Low package dependency workflows or products

All functions in bplyr mimic specific functions in dplyr and tidyr, and
have a trailing prefix b\_\* to them. so arrange is b\_arrange and so
forth.

This has been done as to not create namespace conflicts with dplyr or
tidyr, as this package does not try to replace the intended full
features of those packages, but create light weight, fast installing
alternatives when applicable.

## Installation

``` r
remotes::install_github('yonicd/bplyr')
```

## Current Build

``` r
data.frame(package = c('rlang','dplyr','tidyr'),
           stringsAsFactors = FALSE)%>%
  bplyr::b_group_by(package)%>%
  bplyr::b_mutate(version = as.character(packageVersion(package)))%>%
  knitr::kable()
```

| package | version |
| :------ | :------ |
| dplyr   | 0.8.4   |
| rlang   | 0.4.4   |
| tidyr   | 1.0.2   |

### dplyr

  - arrange
  - count
  - filter
  - group\_by
  - mutate
  - rename
  - select
  - summarize

### tidyr

  - gather
  - spread
  - unite

### todo

  - do
  - joins
  - binds
  - separate

### Similar Packages

  - [freebase](https://github.com/hrbrmstr/freebase) : A ‘usethis’-esque
    Package for Base R Versions of ‘tidyverse’ Code

  - [tbltools](https://github.com/mkearney/tbltools): Tools for Working
    with Tibbles

### CoC

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
