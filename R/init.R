#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : init.R
# Use      : Convenient functions
# Author   : Tomas Sou
# Created  : 2025-08-29
# Updated  : 2025-10-22
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Notes
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Updates
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Functions
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Copy file to destination
#'
#' Copy file to destination and add date to file name with a tag as desired.
#'
#' @param fpath `<chr>` File path of the source file
#' @param tag `<chr>` Tag to the filename
#' @param des `<chr>` Destination folder
#' @returns A logical vector indicating if the operation succeeded for each of the files
#' @export
#' @examples
#' \dontrun{
#' # Copy a file to home directory
#' tmp <- tempdir()
#' fc("myfile.R",des=tmp)
#' }
fc = function(fpath,tag="-",des=""){
  # Copy
  fname = basename(fpath)
  fstem = tools::file_path_sans_ext(fname)
  fext = tools::file_ext(fname)
  file.copy(fpath,des,overwrite=TRUE)
  # Rename
  today = format(Sys.time(),"%y%m%d")
  fname_to = paste0(fstem,tag,today,".",fext)
  fpath1 = file.path(des,fname)
  fpath2 = file.path(des,fname_to)
  file.rename(fpath1,fpath2)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# library(flextable)

#' flextable wrapper
#'
#' Sugar function for default flextable output.
#'
#' @param d `<dfr>` A data frame
#' @param fnote `<chr>` Footnote
#' @param ttl `<chr>` Title
#' @param sig `<int>` Number of significant digits to compute
#' @param dig `<int>` Number of decimal places to display
#' @param src `<int>` Either 1 or 2 to add source label over 1 or 2 lines
#' @param omit `<chr>` Text to omit from the source label
#' @returns A flextable object
#' @export
#' @examples
#' mtcars |> head() |> ft()
#' mtcars |> head() |> ft(src=1)
#' mtcars |> head() |> ft("Footnote")
#' mtcars |> head() |> ft("Footnote",src=1)
#' mtcars |> head() |> ft(sig=2,dig=1)
ft = function(d, fnote=NULL, ttl=NULL, sig=8, dig=2, src=0, omit=""){
  labsrc = NULL
  if(src %in% c(1,2)) labsrc = paste0(label_src(src,omit))
  if(!is.null(fnote)) labsrc = paste0("\n",labsrc)
  lab = fnote
  if(!is.null(labsrc)) lab = paste0(fnote,labsrc)
  out = d |>
    dplyr::mutate(dplyr::across(dplyr::where(~ is.numeric(.x) && is.double(.x)), ~signif(.x,sig))) |>
    flextable::flextable() |>
    flextable::colformat_double(digits=dig) |>
    flextable::autofit() |>
    flextable::add_header_lines(ttl) |>
    flextable::add_footer_lines(lab) |>
    flextable::align(align="left", part="all")
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' flextable default
#'
#' Sugar function to set flextable defaults.
#' The arguments are passed to [flextable::set_flextable_defaults()].
#'
#' @param font `<chr>` Font family - for `font.family`
#' @param fsize `<int>` Font size (in point) - for `font.size`
#' @param pad `<int>` Padding space around text - for `padding`
#' @returns A list containing previous default values
#' @seealso [flextable::set_flextable_defaults()]
#' @export
#' @examples
#' \dontrun{
#' ft_def()
#' }
ft_def = function(font="Calibri Light", fsize=10, pad=3){
  flextable::set_flextable_defaults(
    font.family = font,
    font.size = fsize,
    padding = pad,
    na_str = "",
    nan_str = ""
  )
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Box plot wrapper
#'
#' Sugar function to generate box plots for a continuous variable by discrete variables.
#' Orientation will follow the axis of the discrete variables.
#'
#' @param d `<dfr>` A data frame
#' @param cont `<var>` A continuous variable to plot as unquoted name
#' @param cats `<chr>` Optional. A character vector of selected discrete variables
#' @param ... List of arguments to pass to [ggplot2::geom_boxplot]
#' @returns A ggplot object of a box plot
#' @export
#' @examples
#' iris |> ggcov_box(Sepal.Length)
#' d <- mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggcov_box(mpg)
#' d |> ggcov_box(mpg,c("cyl","vs"))
ggcov_box = function(d, cont, cats=NULL, ...){
  if(!is.null(cats)) d = d |> dplyr::select({{cont}},{{cats}})
  d = d |> tidyr::pivot_longer(-dplyr::where(is.numeric),names_to="name", values_to="levels")
  nsub = d |> dplyr::distinct() |> nrow()
  d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=levels,y={{cont}})+
    ggplot2::geom_boxplot(...)+
    ggplot2::geom_jitter(width=0.2,alpha=0.1)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption = paste0("n=",nsub))
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Histogram wrapper for continuous variables
#'
#' Sugar function to generate histograms of numeric variables in a dataset.
#' Non-numeric variables will be dropped.
#'
#' @param d `<dfr>` A data frame
#' @param cols `<chr>` Optional. A character vector of selected columns
#' @param bins `<int>` Number of bins
#' @param ... Other arguments to pass to [ggplot2::geom_histogram]
#' @returns A ggplot object with histograms of numeric variables
#' @export
#' @examples
#' iris |> ggcov_hist()
#' iris |> ggcov_hist(c("Sepal.Width","Sepal.Length"))
ggcov_hist = function(d, cols=NULL, bins=30, ...){
  if(!is.null(cols)) d = d |> dplyr::select({{cols}})
  nsub = d |> dplyr::distinct() |> nrow()
  catv = d |> dplyr::select(dplyr::where(~!is.numeric(.x)))
  message("Dropped: ", paste(names(catv), collapse=" "))
  d |>
    tidyr::pivot_longer(cols=dplyr::where(is.numeric),names_to="name",values_to="value") |>
    ggplot2::ggplot()+
    ggplot2::aes(x=value)+
    ggplot2::geom_histogram(bins=bins, ...)+
    ggplot2::facet_wrap(~name,scales="free")+
    ggplot2::labs(caption=paste0("n=",nsub))
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Violin plot wrapper
#'
#' Sugar function to generate violin plots for a continuous variable.
#' Orientation will follow the axis of the discrete variables.
#'
#' @param d `<dfr>` A data frame
#' @param cont `<var>` A continuous variable to plot as unquoted name
#' @param cats `<chr>` Optional. A character vector of selected discrete variables
#' @param ... List of arguments to pass to [ggplot2::geom_violin]
#' @returns A ggplot object with violin plots
#' @export
#' @examples
#' iris |> ggcov_violin(Sepal.Length)
#' d <- mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
#' d |> ggcov_violin(mpg)
#' d |> ggcov_violin(mpg,c("cyl","vs"))
ggcov_violin = function(d, cont, cats=NULL, ...){
  if(!is.null(cats)) d = d |> dplyr::select({{cont}},{{cats}})
  d = d |> tidyr::pivot_longer(-dplyr::where(is.numeric),names_to="name", values_to="levels")
  nsub = d |> dplyr::distinct() |> nrow()
  d |>
    ggplot2::ggplot()+
    ggplot2::aes(x=levels,y={{cont}})+
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
#' @param plt A ggplot object
#' @param span `<num>` Number of lines: either 1 or 2
#' @param size `<num>` Text size
#' @param col `<chr>` Colour of the text
#' @param lab `<chr>` Custom label to use instead of the default
#' @param omit `<chr>` Text to omit from the label
#' @returns A ggplot object with the added label
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
#' Set colour scales
#'
#' Set colour scales for the desired number of colours.
#'
#' @param n `<int>` Number of colours to output
#' @param show `<lgl>` `TRUE` to show the output colours
#' @returns Hex code of colours that can be used for plotting
#' @export
#' @examples
#' hcln(6,FALSE)
#' hcln(8,TRUE)
hcln = function(n,show=FALSE){
  hues = seq(15, 375, length=n+1)
  out = hcl(h=hues, c=100, l=65)[1:n]
  if(show) scales::show_col(out)
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' kable wrapper
#'
#' Sugar function for default kable output.
#'
#' @param d `<dfr>` A data frame
#' @param fnote `<chr>` Footnote
#' @param cap `<chr>` Caption
#' @param sig `<int>` Number of significant digits to compute
#' @param dig `<int>` Number of decimal places to display
#' @param src  `<int>` Either 1 or 2 to add source label over 1 or 2 lines
#' @param omit `<chr>` Text to omit from the source label
#' @returns A kable object
#' @export
#' @examples
#' mtcars |> head() |> kb()
#' mtcars |> head() |> kb(src=1)
#' mtcars |> head() |> kb("Footnote")
#' mtcars |> head() |> kb("Footnote",src=1)
#' mtcars |> head() |> kb(sig=2,dig=1)
kb = function(d, fnote=NULL, cap=NULL, sig=8, dig=2, src=0, omit=""){
  labsrc = NULL
  if(src %in% c(1,2)) labsrc = paste0(label_src(src,omit))
  if(!is.null(fnote)) labsrc = paste0("\n",labsrc)
  lab = fnote
  if(!is.null(labsrc)) lab = paste0(fnote,labsrc)
  d |>
    dplyr::mutate(dplyr::across(dplyr::where(~ is.numeric(.x) && is.double(.x)), ~signif(.x,sig))) |>
    kableExtra::kbl(caption=cap,digits=dig) |>
    kableExtra::kable_classic(full_width=FALSE) |>
    kableExtra::footnote(lab,general_title="")
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Generate source label
#'
#' Generate a source label with file path and run time.
#' In interactive sessions, the function uses `rstudioapi` to get the file path.
#' It is designed to work in a script file in RStudio when running interactively.
#' It will return empty if run in the console directly.
#'
#' @param span `<int>` Number of lines: either 1 or 2
#' @param omit `<chr>` Text to omit from the label
#' @param tz `<lgl>` `FALSE` to exclude time stamp
#' @returns A label showing the source file path with a time stamp
#' @export
#' @examples
#' label_src(1)
#' label_src(tz=FALSE)
label_src = function(span=2,omit="",tz=TRUE){
  loc_src = getwd()
  if(interactive()) loc_src = rstudioapi::getActiveDocumentContext()$path |> dirname()
  fname_src = knitr::current_input() |> gsub(".rmarkdown",".qmd",x=_)
  if(interactive()) fname_src = rstudioapi::getActiveDocumentContext()$path |> basename()
  fpath_src  = file.path(loc_src,fname_src)
  labtz = paste0("\nRun: ",format(Sys.time(),usetz=TRUE))
  if(!tz) labtz = NULL
  lab1 = paste0("Source:",fpath_src,labtz)
  lab2 = paste0("Source:",loc_src,"/\n",fname_src,labtz)
  out = lab1
  if(span==2) out = lab2
  out = out |> gsub(omit,"",x=_)
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Generate time stamp label
#'
#' Generate a time stamp label of the current time.
#'
#' @param omit `<chr>` Text to omit from the label
#' @returns A label with time stamp
#' @export
#' @examples
#' label_tz()
label_tz = function(omit=""){
  out= paste0("Run: ",format(Sys.time(),usetz=TRUE)) |> gsub(omit,"",x=_)
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Summarise continuous variables by group
#'
#' Summarise continuous variables by group.
#' Non-numeric variables will be dropped.
#'
#' @param d `<dfr>` A data frame
#' @param cols `<chr>` A vector of column names to select
#' @param ... `<var>` Columns to group by as unquoted variable names
#' @param pct `<num>` A vector of two indicating the percentiles to compute
#' @param xname  `<chr>` Characters to omit in output column names
#' @returns A data frame of summarised variables
#' @export
#' @examples
#' iris |> summ_by()
#' iris |> summ_by(pct=c(0.1,0.9))
#' d <- mtcars |> dplyr::mutate(vs=factor(vs), am=factor(am))
#' d |> summ_by("mpg")
#' d |> summ_by("mpg",vs)
#' d |> summ_by("mpg",vs,am)
#' d |> summ_by(c("mpg","disp"))
#' d |> summ_by(c("mpg","disp"),vs)
#' d |> summ_by(c("mpg","disp"),vs,xname="mpg_")
#' # grouping without column selection is possible but rarely useful in large dataset
#' d |> summ_by(NULL,vs)
summ_by = function(d, cols=NULL, ..., pct=c(0.25,0.75), xname=""){
  if(!is.null(cols)) d = d |> dplyr::select(...,{{cols}})
  d. = d |> dplyr::group_by(...)
  gps = d. |> attr("groups")
  if(is.null(gps)) d. = d |>
    dplyr::select(dplyr::where(is.numeric)) |>
    tidyr::pivot_longer(dplyr::everything(),names_to="name") |>
    dplyr::group_by(dplyr::pick(dplyr::contains("name")))
  if(is.null(gps)){
    catv = d |> dplyr::select(dplyr::where(~!is.numeric(.x)))
    message("Dropped: ", paste(names(catv), collapse=" "))
  }
  if(is.null(gps) & xname=="") xname = paste0(names(d.),"_",collapse="|")
  if(!is.null(gps)) gps = gps |> dplyr::select(-dplyr::last_col()) |> names()
  x = d. |> dplyr::select(dplyr::where(is.numeric)) |> ncol() - length(gps)
  if(x==1 & xname=="") xname = paste0(names(d.),"_",collapse="|")
  out = d. |>
    dplyr::summarise(
      dplyr::across(
        dplyr::where(is.numeric),
        list(
          n = ~length(.x),
          nNA = ~sum(is.na(.x)),
          Mean = ~mean(.x, na.rm=TRUE),
          SD  = ~sd(.x, na.rm=TRUE),
          Min = ~min(.x, na.rm=TRUE),
          Plo = ~quantile(.x, pct[1], na.rm=TRUE),
          Med = ~median(.x, na.rm=TRUE),
          Pup = ~quantile(.x, pct[2], na.rm=TRUE),
          Max = ~max(.x, na.rm=TRUE)
        )
      )
    ) |>
    dplyr::rename_with(~gsub(xname,"",.x)) |>
    dplyr::rename_with(~gsub("Plo",paste0("P",pct[1]*100), .x), dplyr::contains("Plo")) |>
    dplyr::rename_with(~gsub("Pup",paste0("P",pct[2]*100), .x), dplyr::contains("Pup"))
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Summarise categorical variables
#'
#' Summarise categorical variables. Numeric variables will be dropped.
#'
#' @param d A data frame
#' @param pos `<chr>`/`<int>` Position (name or integer) of the summary list to return
#' @returns A list containing summaries of the categorical variables
#' @export
#' @examples
#' iris |> summ_cat()
#' sleep |> summ_cat()
#' sleep |> summ_cat(1)
#' sleep |> summ_cat("group")
summ_cat = function(d,pos=NULL){
  x = d |> dplyr::select(dplyr::where(is.numeric))
  message("Dropped: ", paste(names(x), collapse=" "))
  out = d |>
    dplyr::select(-dplyr::where(is.numeric)) |>
    lapply(janitor::tabyl) |>
    lapply(janitor::adorn_totals)
  for (i in seq_along(out)){
    out[[i]] = out[[i]] |> dplyr::rename(!!names(out[i]):=1)
  }
  if(!is.null(pos)) out = out |> magrittr::extract2(pos)
  return(out)
}
