#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : fns_gg.R
# Use      : Wrapper functions for ggplot2
# Author   : Tomas Sou
# Created  : 2025-10-25
# Updated  : 2025-10-27
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Notes
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Updates
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Box plot wrapper for categorical covariates
#'
#' Create box plots for a chosen variable by all discrete covariates.
#' Numeric variables will be dropped, except the chosen variable to plot.
#'
#' @param d `<dfr>` A data frame.
#' @param var `<var>` A variable to plot as unquoted name.
#' @param cats `<var>` Optional. Categorical variables to plot as a vector of unquoted names.
#' @param ... Additional arguments for [ggplot2::geom_boxplot].
#' @returns A ggplot object of a box plot.
#' @export
#' @examples
#' d <- mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggbox(mpg)
#' d |> ggbox(mpg,c(cyl,vs))
ggbox = function(d, var, cats, ...){
  if(missing(var)) stop("Specify a variable to plot!")
  if(!missing(cats)) d = d |> dplyr::select({{var}},{{cats}})
  nsub = d |> nrow()
  x = d |> dplyr::select(dplyr::where(~is.numeric(.x)),-{{var}})
  message("Dropped: ", paste(names(x), collapse=" "))
  d = d |> tidyr::pivot_longer(
    cols = !(dplyr::where(~is.numeric(.x)) | {{var}}),
    names_to = "name",
    values_to = "levels"
  )
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
#' Create histograms for all numeric variables in a dataset.
#' Non-numeric variables will be dropped.
#'
#' @param d `<dfr>` A data frame.
#' @param cols `<var>` Optional. Columns to plot as a vector of unquoted names.
#' @param bins `<int>` Number of bins.
#' @param ... Additional arguments for [ggplot2::geom_histogram].
#' @returns A ggplot object with histograms of numeric variables.
#' @export
#' @examples
#' iris |> gghist()
#' iris |> gghist(c(Sepal.Width,Sepal.Length))
gghist = function(d, cols, bins=30, ...){
  if(!missing(cols)) d = d |> dplyr::select({{cols}})
  nsub = d |> nrow()
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
#' Add source file label to a ggplot object
#'
#' Add a label with the current source file path and run time to a ggplot object.
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
#' p <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
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
#' Violin plot wrapper for categorical covariates
#'
#' Create violin plots for a chosen variable by all discrete covariates.
#' Numeric variables will be dropped, except the chosen variable to plot.
#'
#' @param d `<dfr>` A data frame.
#' @param var `<var>` A variable to plot as unquoted name.
#' @param cats `<var>` Optional. Categorical variables to plot as a vector of unquoted names.
#' @param ... Additional arguments for [ggplot2::geom_violin].
#' @returns A ggplot object with violin plots.
#' @export
#' @examples
#' d <- mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggvp(mpg)
#' d |> ggvp(mpg,c(cyl,vs))
ggvp = function(d, var, cats, ...){
  if(missing(var)) stop("Specify a variable to plot!")
  if(!missing(cats)) d = d |> dplyr::select({{var}},{{cats}})
  nsub = d |> nrow()
  x = d |> dplyr::select(dplyr::where(~is.numeric(.x)),-{{var}})
  message("Dropped: ", paste(names(x), collapse=" "))
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
#' XY scatter plot wrapper
#'
#' Create basic XY scatter plot for quick data exploration.
#' Default to show Pearson correlation coefficient with p-value using [ggpubr::stat_cor()].
#' For more complex plots, it is recommended to use [ggplot2] directly.
#'
#' @param d `<dfr>` A data frame.
#' @param x `<var>` Variable for the x-axis as unquoted name.
#' @param y `<var>` Variable for the y-axis as unquoted name.
#' @param ... Other arguments for [ggplot2::aes] for additional mapping.
#' @param lm `<lgl>` `TRUE` to add regression line from linear model.
#' @param se `<lgl>` `TRUE` to show standard error with the regression line.
#' @param cor `<lgl>` `TRUE` to show Pearson correlation coefficient with p-value.
#' @param pacc `<dbl>` Precision for the p-value, e.g., 0.0001 to show 4 decimal places.
#' @seealso [ggpubr::stat_cor]
#' @returns A ggplot object.
#' @export
#' @examples
#' mtcars |> ggxy(wt,hp)
#' mtcars |> ggxy(wt,hp,col=factor(gear))
#' mtcars |> ggxy(wt,hp,col=factor(gear),pch=factor(am))
#' mtcars |> ggxy(wt,hp,pacc=0.001)
#' mtcars |> ggxy(wt,hp,se=FALSE)
#' mtcars |> ggxy(wt,hp,lm=FALSE)
#' mtcars |> ggxy(wt,hp,cor=FALSE)
ggxy = function(d,x,y,...,lm=TRUE,se=TRUE,cor=TRUE,pacc=NULL){
  nsub = d |> nrow()
  p = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x={{x}},y={{y}},...)+
    ggplot2::geom_point()+
    ggplot2::labs(caption=paste0("n=",nsub))
  if(lm) p = p + ggplot2::geom_smooth(method="lm",se=se)
  if(cor) p = p + ggpubr::stat_cor(p.accuracy=pacc,show.legend=FALSE)
  return(p)
}
