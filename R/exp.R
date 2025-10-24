#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : exp.R
# Use      : Experimental functions
# Author   : Tomas Sou
# Created  : 2024-10-09
# Updated  : 2025-10-25
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Notes
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Updates
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Fn: Negate

`%ni%` = Negate(`%in%`)

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ggplot

# Fn: Save ggplot
# loc_out = "CDLX313A/mas/mas_2/model/pgm_001/MT-11214/Activity_02/outputs"
ggout = function(plt,fname,loc="",width=7,height=7){
  if(loc=="") loc = loc_out
  fpath = file.path(base,loc,fname)
  ggsave(fpath,plt,unts="in",width=width,height=height)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Generate XY scatter plot
#'
#' Wrapper function to generate basic XY scatter plot for quick exploration.
#' Default to show Pearson correlation coefficient with p-value.
#' For more complex plots, it is recommended to use [ggplot2] directly.
#'
#' @param d `<dfr>` A data frame.
#' @param x `<var>` Variable for the x-axis as unquoted name.
#' @param y `<var>` Variable for the y-axis as unquoted name.
#' @param ... Additional arguments.
#' @returns A ggplot object.
#' @export
#' @examples
#' mtcars |> ggxy(mpg,drat)
ggxy = function(d,x,y,...){
  p = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x={{x}},y={{y}})+
    ggplot2::geom_point()
  p = p + ggplot2::geom_smooth(method="lm")
  p = p + ggpubr::stat_cor()
  return(p)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# library(gt)

gt2 = function(d,src=NULL,fnote=NULL,width=500){
  out = d %>%
    gt::gt() %>%
    gt::tab_source_note(src) %>%
    gt::tab_options(
      column_labels.font.weight = "bold",
      table.font.size = 11,
      table.width = width
    )
  if(!is.null(fnote)) out = out %>% gt::tab_footnote(fnote)
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# library(janitor)

# tabyl as input
tabsum = function(d,...){
  d = d |> distinct(...)
  out = d |>
    janitor::tabyl(...) |>
    janitor::adorn_percentages(c("all")) |>
    janitor::adorn_totals(c("row", "col")) |>
    janitor::adorn_pct_formatting(digits=2) |>
    janitor::adorn_ns(format_func=\(x)x);out
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Fn: Render all Rmd files

render2 = function(fnameRmd,tag="-"){
  knitr::purl(fnameRmd, quiet=T, documentation=0)
  rmarkdown::render(fnameRmd)
  fcopy(gsub(".Rmd",".html",fnameRmd),tag=tag)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# runShell

# fShell = function(){
#   src = dir("~/Documents/src","runShell.sh")
#   dst = file.path(getwd(),src)
#   file.copy(src,dst)
# }

