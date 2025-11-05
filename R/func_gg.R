#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : func_gg.R
# Use      : Wrapper functions for ggplot2
# Author   : Tomas Sou
# Created  : 2025-10-25
# Updated  : 2025-11-05
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Notes
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Updates
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Box plot wrapper for categorical covariates
#'
#' Create box plots for a chosen variable by all discrete covariates in a dataset.
#' Numeric variables will be dropped, except the chosen variable to plot.
#'
#' @param d `<dfr>` A data frame.
#' @param var `<var>` A variable to plot as unquoted name.
#' @param cats `<var>` Optional. Categorical variables to plot as a vector of unquoted names.
#' @param alpha `<num>` Alpha value for [ggplot2::geom_jitter].
#' @param show `<lgl>` `TRUE` to show data using [ggplot2::geom_jitter].
#' @param nsub `<lgl>` Show number of observations.
#' @param ... Additional arguments for [ggplot2::geom_boxplot].
#'
#' @returns A ggplot object.
#' @export
#' @examples
#' d = mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggbox(mpg)
#' d |> ggbox(mpg,alpha=0.5)
#' d |> ggbox(mpg,show=FALSE)
#' d |> ggbox(mpg,nsub=FALSE)
#' d |> ggbox(mpg,c(cyl,vs))
ggbox = function(d, var, cats, alpha=0.1, show=TRUE, nsub=TRUE, ...){
  if(missing(var)) stop("Specify a variable to plot!")
  if(!missing(cats)) d = d |> dplyr::select({{var}},{{cats}})
  nSub = NULL
  if(nsub) nSub = paste0("n=",nrow(d))
  x = d |> dplyr::select(dplyr::where(~is.numeric(.x)),-{{var}})
  message("Dropped: ", paste(names(x), collapse=" "))
  d = d |> tidyr::pivot_longer(
    cols = !(dplyr::where(~is.numeric(.x)) | {{var}}),
    names_to = "name",
    values_to = "levels"
  )
  out = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=levels,y={{var}})+
    ggplot2::geom_boxplot(...)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption=nSub)
  if(show) out = out + ggplot2::geom_jitter(width=0.2, alpha=alpha)
  return(out)
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
#' @param nsub `<lgl>` Show number of observations.
#' @param ... Additional arguments for [ggplot2::geom_histogram].
#' @returns A ggplot object.
#' @export
#' @examples
#' iris |> gghist()
#' iris |> gghist(c(Sepal.Width,Sepal.Length))
gghist = function(d, cols, bins=30, nsub=TRUE, ...){
  if(!missing(cols)) d = d |> dplyr::select({{cols}})
  nSub = NULL
  if(nsub) nSub = paste0("n=",nrow(d))
  catv = d |> dplyr::select(dplyr::where(~!is.numeric(.x)))
  message("Dropped: ", paste(names(catv), collapse=" "))
  d = d |> tidyr::pivot_longer(cols=dplyr::where(is.numeric),names_to="name",values_to="value")
  d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=value)+
    ggplot2::geom_histogram(bins=bins, ...)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption=nSub)
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
#' library(ggplot2)
#' p = ggplot(mtcars, aes(mpg, wt)) + geom_point()
#' p |> ggsrc()
#' p |> ggsrc(lab="My label")
ggsrc = function(plt,span=2,size=8,col="grey55",lab=NULL,omit=""){
  labsrc = label_src(span,omit)
  if(!is.null(lab)) labsrc = lab
  out = patchwork::wrap_elements(plt) +
    patchwork::plot_annotation(
      caption = labsrc,
      theme = ggplot2::theme(plot.caption = ggplot2::element_text(colour=col,size=size))
    )
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Time-profile plot wrapper
#'
#' Create plots for time profile data such as PK and PD plots.
#'
#' @param d `<dfr>` A data frame.
#' @param x,y `<var>` Variables for x- and y-axis as unquoted names
#' @param id `<var>` Variable for grouping ID such as subject ID as unquoted name.
#' @param ... Other arguments to pass to [ggplot2::aes] for additional mapping.
#' @param nsub `<lgl>` `TRUE` to show number of subjects as per `id` in caption.
#' @param logx,logy `<lgl>` `TRUE` to log x- and y-axis.
#' @param alpha_point `<num>` Alpha value for [ggplot2::geom_point].
#' @param alpha_line `<num>` Alpha value for [ggplot2::geom_line].
#' @param xlab,ylab `<chr>` Labels for x- and y-axis.
#' @param ttl,sttl,cap `<chr>` Title. Subtitle. Caption.
#' @returns A ggplot object.
#' @export
#' @examples
#' Theoph |> ggtpp(x=Time,y=conc,id=Subject)
ggtpp = function(
    d, x, y, id, ...,
    nsub=TRUE, logx=FALSE, logy=FALSE,
    alpha_point=0.2, alpha_line=0.1,
    xlab=NULL, ylab=NULL, ttl=NULL, sttl=NULL, cap=NULL
  ){
  labn = NULL
  nSub = d |> dplyr::distinct({{id}}) |> dim()
  if(!missing(id) && nSub[2]>0) labn = paste0("nSub=",nSub[1])
  out = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x={{x}}, y={{y}}, group={{id}}, ...)+
    ggplot2::geom_point(alpha=alpha_point)+
    ggplot2::geom_line(alpha=alpha_line)+
    ggplot2::labs(
      title = ttl,
      x = xlab,
      y = ylab,
      caption = paste0(labn,cap)
    )
  if(logx) out = out + xgxr::xgx_scale_x_log10()
  if(logy) out = out + xgxr::xgx_scale_y_log10()
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Violin plot wrapper for categorical covariates
#'
#' Create violin plots for a chosen variable by all discrete covariates in a dataset.
#' Numeric variables will be dropped, except the chosen variable to plot.
#'
#' @param d `<dfr>` A data frame.
#' @param var `<var>` A variable to plot as unquoted name.
#' @param cats `<var>` Optional. Categorical variables to plot as a vector of unquoted names.
#' @param alpha `<num>` Alpha value for [ggplot2::geom_jitter].
#' @param show `<lgl>` `TRUE` to show data using [ggplot2::geom_jitter].
#' @param nsub `<lgl>` Show number of observations.
#' @param ... Additional arguments for [ggplot2::geom_violin].
#' @returns A ggplot object.
#' @export
#' @examples
#' d = mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggvio(mpg)
#' d |> ggvio(mpg,alpha=0.5)
#' d |> ggvio(mpg,show=FALSE)
#' d |> ggvio(mpg,nsub=FALSE)
#' d |> ggvio(mpg,c(cyl,vs))
ggvio = function(d, var, cats, alpha=0.1, show=TRUE, nsub=TRUE, ...){
  if(missing(var)) stop("Specify a variable to plot!")
  if(!missing(cats)) d = d |> dplyr::select({{var}},{{cats}})
  nSub = NULL
  if(nsub) nSub = paste0("n=",nrow(d))
  x = d |> dplyr::select(dplyr::where(~is.numeric(.x)),-{{var}})
  message("Dropped: ", paste(names(x), collapse=" "))
  d = d |> tidyr::pivot_longer(
    cols = !(dplyr::where(~is.numeric(.x)) | {{var}}),
    names_to = "name",
    values_to = "levels"
  )
  out = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=levels,y={{var}})+
    ggplot2::geom_violin(trim=FALSE,quantile.linetype=2,draw_quantiles=c(0.25,0.5,0.75))+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption=nSub)
  if(show) out = out + ggplot2::geom_jitter(width=0.2,alpha=alpha)
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' XY scatter plot wrapper
#'
#' Create basic XY scatter plot for quick data exploration.
#' Default to show Pearson correlation coefficient with p-value using [ggpubr::stat_cor].
#' For more complex plots, it is recommended to use [ggplot2] directly.
#'
#' @param d `<dfr>` A data frame.
#' @param x,y `<var>` Variables for x- and y-axis as unquoted names.
#' @param ... Other arguments to pass to [ggplot2::aes] for additional mapping.
#' @param lm `<lgl>` `TRUE` to add regression line from linear model.
#' @param se `<lgl>` `TRUE` to show standard error with the regression line.
#' @param nsub `<lgl>` Show number of observations.
#' @param cor `<lgl>` `TRUE` to show Pearson correlation coefficient with p-value.
#' @param pv `<dbl>` Precision for the p-value, e.g., 0.001 to show 3 decimal places.
#' @param legend `<lgl>` `TRUE` to show legend.
#' @seealso [ggpubr::stat_cor]
#' @returns A ggplot object.
#' @export
#' @examples
#' mtcars |> ggxy(wt,hp)
#' mtcars |> ggxy(wt,hp,col=factor(gear))
#' mtcars |> ggxy(wt,hp,col=factor(gear),legend=FALSE)
#' mtcars |> ggxy(wt,hp,col=factor(gear),pch=factor(am))
#' mtcars |> ggxy(wt,hp,pv=0.001)
#' mtcars |> ggxy(wt,hp,nsub=FALSE)
#' mtcars |> ggxy(wt,hp,se=FALSE)
#' mtcars |> ggxy(wt,hp,lm=FALSE)
#' mtcars |> ggxy(wt,hp,cor=FALSE)
ggxy = function(d,x,y,...,lm=TRUE,se=TRUE,cor=TRUE,pv=NULL,nsub=TRUE,legend=TRUE){
  nSub = NULL
  if(nsub) nSub = paste0("n=",nrow(d))
  p = d |>
    ggplot2::ggplot()+
    ggplot2::aes(x={{x}},y={{y}},...)+
    ggplot2::geom_point(show.legend=legend)+
    ggplot2::labs(caption=nSub)
  if(lm) p = p + ggplot2::geom_smooth(method="lm",se=se,show.legend=legend)
  if(cor) p = p + ggpubr::stat_cor(p.accuracy=pv,show.legend=FALSE)
  return(p)
}
