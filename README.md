
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/yonicd/noplyr.svg?branch=master)](https://travis-ci.org/yonicd/noplyr)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

> Disclaimer: this is experimental, use deliberately and with caution.

# noplyr

Run basic functions of `dplyr` and `tidyr` with only base `R` and
`rlang`.

## When could this package be useful?

  - Non DBI related data manipulations
  - Continuous integration `R` scripts
  - Low package dependency workflows or products

## Installation

``` r
remotes::install_github('yonicd/noplyr')
```

## Current Build

``` r
data.frame(package = c('rlang','dplyr','tidyr'),
           stringsAsFactors = FALSE)%>%
  noplyr::group_by(package)%>%
  noplyr::mutate(version = as.character(packageVersion(package)))%>%
  knitr::kable()
```

| package | version |
| :------ | :------ |
| dplyr   | 0.7.5   |
| rlang   | 0.2.1   |
| tidyr   | 0.8.1   |

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

### CoC

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
