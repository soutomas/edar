#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : init.R
# Use      : Convenient functions
# Author   : Tomas Sou
# Created  : 2025-08-29
# Updated  : 2025-10-07
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Notes
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Updates
# na
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Functions
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Copy to destination
#'
#' Copy file to destination and rename if desired.
#'
#' @param fpath File path of the source file
#' @param tag [optional] <chr> Tag to the filename
#' @param des Destination folder
#' @export
#' @examples
#' \dontrun{
#' # Copy a file to home directory
#' fc("myfile.R",des="~")
#' }
fc = function(fpath,tag="-",des="/home/souto1/Documents/"){
  # Copy
  fname = basename(fpath)
  fstem = tools::file_path_sans_ext(fname)
  fext = tools::file_ext(fname)
  file.copy(fpath,des,overwrite=T)
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
#' @param d A data frame
#' @param fnote [optional] <chr> Footnote
#' @param ttl [optional] <chr> Title
#' @param src [optional] <int> Either 1 or 2 to add source label over 1 or 2 lines
#' @param sig <int> Number of significant digits to compute
#' @param dig <int> Number of decimal places to display
#' @returns A flextable object
#' @export
#' @examples
#' iris |> ft()
#' mtcars |> ft()
#' mtcars |> ft(src=1)
#' mtcars |> ft(sig=1)
#' mtcars |> ft(sig=2,dig=1)
ft = function(d,fnote=NULL,ttl=NULL,src=NULL,sig=3,dig=3){
  flextable::set_flextable_defaults(font.family="Calibri Light", font.size=10, padding=3)
  on.exit(flextable::init_flextable_defaults(), add=TRUE)
  labsrc = NULL
  if(!is.null(src) && src %in% c(1,2)) labsrc = label_src(src)
  out = d |>
    dplyr::mutate(dplyr::across(dplyr::where(is.double), ~signif(.x,sig))) |>
    flextable::flextable() |>
    flextable::colformat_double(digits=dig) |>
    flextable::autofit() |>
    flextable::add_header_lines(ttl) |>
    flextable::add_footer_lines(c(fnote,labsrc))
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# library(patchwork)

#' Add source label to ggplot
#'
#' Generate and add a source label with file path and run time to a ggplot object.
#'
#' @param plt A ggplot object
#' @param span <num> Number of lines: either 1 or 2
#' @param size <num> Text size
#' @param col <chr> Colour of the text
#' @param lab [optional] <chr> Custom label to use instead of the default
#' @param omit [optional] <chr> Text to omit from the label
#' @returns A ggplot object with the added label
#' @export
#' @examples
#' \dontrun{
#' # A source label can be easily added to a ggplot object.
#' library(ggplot2)
#' p = ggplot(mtcars, aes(mpg, wt)) + geom_point()
#' p |> ggsrc()
#' }
ggsrc = function(plt,span=2,size=8,col="grey55",lab=NULL,omit=""){
  lab1 = label_src(1) |> gsub(omit,"",x=_)
  lab2 = label_src(2) |> gsub(omit,"",x=_)
  lab3 = lab1
  if(span==2) lab3 = lab2
  if(!is.null(lab)) lab3 = lab
  out = patchwork::wrap_elements(plt) +
    patchwork::plot_annotation(
      caption = lab3,
      theme = ggplot2::theme(plot.caption = ggplot2::element_text(colour=col,size=size))
    )
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Set colour scales
#'
#' Set colour scales for the desired number of colours.
#'
#' @param n <int> Number of colours to output
#' @param show <lgl> `TRUE` to show the output colours
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
#' @param d A data frame
#' @param fnote [optional] <chr> Footnote
#' @param cap [optional] <chr> Caption
#' @param sig <int> Number of significant digits to compute
#' @param dig <int> Number of decimal places to display
#' @returns A kable object
#' @export
#' @examples
#' iris |> kbl2()
#' mtcars |> kbl2()
#' mtcars |> kbl2(sig=2,dig=1)
kbl2 = function(d,fnote=NULL,cap=NULL,sig=3,dig=3){
  d |>
    dplyr::mutate(dplyr::across(dplyr::where(is.double), ~signif(.x,sig))) |>
    kableExtra::kbl(caption=cap,digits=dig) |>
    kableExtra::kable_classic(full_width=F) |>
    kableExtra::footnote(fnote,general_title="")
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Generate source label
#'
#' Generate a source label with file path and run time.
#' In interactive sessions, this function uses `rstudioapi` to get the file path.
#' It is designed to work in a script file in RStudio when running interactively.
#' It will return empty if run in the console.
#'
#' @param span <int> Number of lines: either 1 or 2
#' @param omit [optional] <chr> Text to omit from the label
#' @param tz <lgl> `FALSE` to exclude time stamp
#' @returns A label with source file path and run time
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
  labtz = paste0("\nRun: ",format(Sys.time(),usetz=T))
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
#' @param omit [optional] <chr> Text to omit from the label
#' @returns A label with time stamp
#' @export
#' @examples
#' label_tz()
label_tz = function(omit=""){
  out= paste0("Run: ",format(Sys.time(),usetz=T)) |> gsub(omit,"",x=_)
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Summarise continuous variables by group
#'
#' Summarise continuous variables by group.
#' Non-numeric variables will be dropped.
#'
#' @param d A data frame
#' @param cols [optional] <chr> A vector of column names to select
#' @param ... [optional] <unquoted names> Columns to group by
#' @param xname [optional] <chr> Characters to omit in output column names
#' @returns A data frame of summarised variables
#' @export
#' @examples
#' mtcars |> summ_by()
#' mtcars |> summ_by("mpg")
#' mtcars |> summ_by("mpg",vs)
#' mtcars |> summ_by("mpg",vs,am)
#' mtcars |> summ_by(c("mpg","disp"))
#' mtcars |> summ_by(c("mpg","disp"),vs)
#' mtcars |> summ_by(c("mpg","disp"),vs,xname="mpg_")
#' # grouping without column selection is possible but rarely useful in large dataset
#' mtcars |> summ_by(NULL,vs)
summ_by = function(d,cols=NULL,...,xname=""){
  if(!is.null(cols)) d = d |> dplyr::select(...,{{cols}})
  d. = d |> dplyr::group_by(...)
  gps = d. |> attr("groups")
  if(is.null(gps)) d. = d |>
    dplyr::select(dplyr::where(is.numeric)) |>
    tidyr::pivot_longer(dplyr::everything(),names_to="name") |>
    dplyr::group_by(name)
  if(is.null(gps)){
    catv = d |> dplyr::select(dplyr::where(~!is.numeric(.x)))
    cat("Dropped:",names(catv),"\n")
  }
  if(is.null(gps) & xname=="") xname = paste0(names(d.),"_",collapse="|")
  if(!is.null(gps)) gps = gps |> dplyr::select(-.rows) |> names()
  x = d. |> dplyr::select(dplyr::where(is.numeric)) |> ncol() - length(gps)
  if(x==1 & xname=="") xname = paste0(names(d.),"_",collapse="|")
  out = d. |>
    dplyr::summarise(
      dplyr::across(
        dplyr::where(is.numeric),
        list(
          n = ~length(.x),
          nNA = ~sum(is.na(.x)),
          Mean = ~mean(.x, na.rm=T),
          Med = ~median(.x, na.rm=T),
          SD  = ~sd(.x, na.rm=T),
          Min = ~min(.x, na.rm=T),
          P10 = ~quantile(.x, 0.1, na.rm=T),
          P90 = ~quantile(.x, 0.9, na.rm=T),
          Max = ~max(.x, na.rm=T)
        )
      )
    ) |>
    dplyr::rename_with(~gsub(xname,"",.x))
  return(out)
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Summarise categorical variables
#'
#' Summarise categorical variables. Numeric variables will be dropped.
#'
#' @param d A data frame
#' @param pos [optional] <chr>/<int> Position (name or numeric) of the summary list to return
#' @returns A list containing summaries of the categorical variables
#' @export
#' @examples
#' sleep |> summ_cat()
#' sleep |> summ_cat(1)
#' sleep |> summ_cat("group")
summ_cat = function(d,pos=NULL){
  x = d |> dplyr::select(dplyr::where(is.numeric))
  cat("Dropped:",names(x),"\n")
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
