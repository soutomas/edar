#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : fns_gg.R
# Use      : Wrapper functions for ggplot2
# Author   : Tomas Sou
# Created  : 2025-10-25
# Updated  : 2025-10-25
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Notes
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Updates
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Box plot wrapper for discrete covariates
#'
#' Sugar function to generate box plots for a chosen variable by discrete covariates.
#' Orientation will follow the axis of the discrete variables.
#' Numeric variables will be dropped, except the chosen variable to plot.
#'
#' @param d `<dfr>` A data frame.
#' @param var `<var>` A variable to plot as unquoted name.
#' @param cats `<var>` Optional. A vector of selected discrete variables as unquoted names.
#' @param ... List of arguments to pass to [ggplot2::geom_boxplot].
#' @returns A ggplot object of a box plot.
#' @export
#' @examples
#' iris |> ggcov_box(Sepal.Length)
#' sleep |> ggcov_box(extra,group)
#' sleep |> ggcov_box(extra,"group") # character for `cats` will not break
#' d <- mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggcov_box(mpg)
#' d |> ggcov_box(mpg,c("cyl","vs"))
ggcov_box = function(d, var, cats, ...){
  if(missing(var)) stop("Specify a variable to plot!")
  if(!missing(cats)) d = d |> dplyr::select({{var}},{{cats}})
  d = d |> tidyr::pivot_longer(
    cols = !(dplyr::where(~is.numeric(.x)) | {{var}}),
    names_to = "name",
    values_to = "levels"
  )
  nsub = d |> dplyr::distinct() |> nrow()
  d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=levels,y={{var}})+
    ggplot2::geom_boxplot(...)+
    ggplot2::geom_jitter(width=0.2,alpha=0.1)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption = paste0("n=",nsub))
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
utils::globalVariables(c("value"))

#' Histogram wrapper for continuous covariates
#'
#' Sugar function to generate histograms for numeric variables in a dataset.
#' Non-numeric variables will be dropped.
#'
#' @param d `<dfr>` A data frame.
#' @param cols `<var>` Optional. A vector of selected columns as unquoted names.
#' @param bins `<int>` Number of bins.
#' @param ... Other arguments to pass to [ggplot2::geom_histogram].
#' @returns A ggplot object with histograms of numeric variables.
#' @export
#' @examples
#' iris |> ggcov_hist()
#' iris |> ggcov_hist(c(Sepal.Width,Sepal.Length))
ggcov_hist = function(d, cols, bins=30, ...){
  if(!missing(cols)) d = d |> dplyr::select({{cols}})
  nsub = d |> dplyr::distinct() |> nrow()
  catv = d |> dplyr::select(dplyr::where(~!is.numeric(.x)))
  message("Dropped: ", paste(names(catv), collapse=" "))
  d = d |> tidyr::pivot_longer(cols=dplyr::where(is.numeric),names_to="name",values_to="value")
  d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=value)+
    ggplot2::geom_histogram(bins=bins, ...)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption=paste0("n=",nsub))
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Violin plot wrapper for discrete covariates
#'
#' Sugar function to generate violin plots for a chosen variable by discrete covariates.
#' Orientation will follow the axis of the discrete variables.
#' Numeric variables will be dropped, except the chosen variable to plot.
#'
#' @param d `<dfr>` A data frame.
#' @param var `<var>` A variable to plot as unquoted name.
#' @param cats `<var>` Optional. A vector of selected discrete variables as unquoted names.
#' @param ... List of arguments to pass to [ggplot2::geom_violin].
#' @returns A ggplot object with violin plots.
#' @export
#' @examples
#' iris |> ggcov_violin(Sepal.Length)
#' sleep |> ggcov_violin(extra,group)
#' sleep |> ggcov_box(extra,"group") # character for `cats` will not break
#' d <- mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggcov_violin(mpg)
#' d |> ggcov_violin(mpg,c("cyl","vs"))
ggcov_violin = function(d, var, cats, ...){
  if(missing(var)) stop("Specify a variable to plot!")
  if(!missing(cats)) d = d |> dplyr::select({{var}},{{cats}})
  nsub = d |> dplyr::distinct() |> nrow()
  d = d |> tidyr::pivot_longer(
    cols = !(dplyr::where(~is.numeric(.x)) | {{var}}),
    names_to = "name",
    values_to = "levels"
  )
  d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=levels,y={{var}})+
    ggplot2::geom_violin(trim=FALSE,quantile.linetype=2,draw_quantiles=c(0.25,0.5,0.75))+
    ggplot2::geom_jitter(width=0.2,alpha=0.1)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption=paste0("n=",nsub))
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# library(patchwork)

#' Add source label to a ggplot object
#'
#' Generate and add a source label with file path and run time to a ggplot object.
#'
#' @param plt A ggplot object.
#' @param span `<num>` Number of lines: either 1 or 2.
#' @param size `<num>` Text size.
#' @param col `<chr>` Colour of the text.
#' @param lab `<chr>` Custom label to use instead of the default.
#' @param omit `<chr>` Text to omit from the label.
#' @returns A ggplot object with the added label.
#' @export
#' @examples
#' # A source label can be easily added to a ggplot object.
#' library(ggplot2)
#' p = ggplot(mtcars, aes(mpg, wt)) + geom_point()
#' p |> ggsrc()
#' p |> ggsrc(lab="My label")
ggsrc = function(plt,span=2,size=8,col="grey55",lab=NULL,omit=""){
  labsrc = label_src(span) |> gsub(omit,"",x=_)
  if(!is.null(lab)) labsrc = lab
  out = patchwork::wrap_elements(plt) +
    patchwork::plot_annotation(
      caption = labsrc,
      theme = ggplot2::theme(plot.caption = ggplot2::element_text(colour=col,size=size))
    )
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Generate XY scatter plot
#'
#' Wrapper function to generate basic XY scatter plot for quick exploration.
#' Default to show Pearson correlation coefficient with p-value from [ggpubr::stat_cor()].
#' For more complex plots, it is recommended to use [ggplot2] directly.
#'
#' @param d `<dfr>` A data frame.
#' @param x `<var>` Variable for the x-axis as unquoted name.
#' @param y `<var>` Variable for the y-axis as unquoted name.
#' @param lm `<lgl>` `TRUE` to add regression line from linear model
#' @param cor `<lgl>` `TRUE` to show Pearson correlation coefficient with p-value
#'
#' @returns A ggplot object.
#' @export
#' @examples
#' mtcars |> ggxy(wt,hp)
#' mtcars |> ggxy(mpg,hp,lm=FALSE)
#' mtcars |> ggxy(cyl,hp,cor=FALSE)
ggxy = function(d,x,y,lm=TRUE,cor=TRUE){
  p = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x={{x}},y={{y}})+
    ggplot2::geom_point()
  if(lm) p = p + ggplot2::geom_smooth(method="lm")
  if(cor) p = p + ggpubr::stat_cor()
  return(p)
}
