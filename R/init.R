#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Filename : init.R
# Use      : Convenient functions
# Author   : Tomas Sou
# Created  : 2025-08-29
# Updated  : 2025-10-16
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
#' @param fpath `<chr>` File path of the source file
#' @param tag `<chr>` Tag to the filename
#' @param des `<chr>` Destination folder
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
ft = function(d,fnote=NULL,ttl=NULL,sig=8,dig=2,src=0,omit=""){
  labsrc = NULL
  if(src %in% c(1,2)) labsrc = paste0(label_src(src,omit))
  if(!is.null(fnote)) labsrc = paste0("\n",labsrc)
  lab = fnote
  if(!is.null(labsrc)) lab = paste0(fnote,labsrc)
  out = d |>
    dplyr::mutate(dplyr::across(dplyr::where(~ is.double(.x) && !lubridate::is.Date(.x)), ~signif(.x,sig))) |>
    flextable::flextable() |>
    flextable::colformat_double(digits=dig) |>
    flextable::autofit() |>
    flextable::add_header_lines(ttl) |>
    flextable::add_footer_lines(lab)
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
    padding = pad
  )
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# library(patchwork)

#' Add source label to ggplot
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
#' \dontrun{
#' # A source label can be easily added to a ggplot object.
#' library(ggplot2)
#' p = ggplot(mtcars, aes(mpg, wt)) + geom_point()
#' p |> ggsrc()
#' p |> ggsrc(lab="My label")
#' }
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
kb = function(d,fnote=NULL,cap=NULL,sig=8,dig=2,src=0,omit=""){
  labsrc = NULL
  if(src %in% c(1,2)) labsrc = paste0(label_src(src,omit))
  if(!is.null(fnote)) labsrc = paste0("\n",labsrc)
  lab = fnote
  if(!is.null(labsrc)) lab = paste0(fnote,labsrc)
  d |>
    dplyr::mutate(dplyr::across(dplyr::where(~ is.double(.x) && !lubridate::is.Date(.x)), ~signif(.x,sig))) |>
    kableExtra::kbl(caption=cap,digits=dig) |>
    kableExtra::kable_classic(full_width=F) |>
    kableExtra::footnote(lab,general_title="")
}

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#' Generate source label
#'
#' Generate a source label with file path and run time.
#' In interactive sessions, this function uses `rstudioapi` to get the file path.
#' It is designed to work in a script file in RStudio when running interactively.
#' It will return empty if run in the console.
#'
#' @param span `<int>` Number of lines: either 1 or 2
#' @param omit `<chr>` Text to omit from the label
#' @param tz `<lgl>` `FALSE` to exclude time stamp
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
#' @param omit `<chr>` Text to omit from the label
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
#' @param d `<dfr>` A data frame
#' @param cols `<chr>` A vector of column names to select
#' @param ... `<var>` Columns to group by as unquoted variable names
#' @param pct `<num>` A vector of two indicating the percentiles to compute
#' @param xname  `<chr>` Characters to omit in output column names
#' @returns A data frame of summarised variables
#' @export
#' @examples
#' mtcars |> summ_by()
#' mtcars |> summ_by(pct=c(0.1,0.9))
#' mtcars |> summ_by("mpg")
#' mtcars |> summ_by("mpg",vs)
#' mtcars |> summ_by("mpg",vs,am)
#' mtcars |> summ_by(c("mpg","disp"))
#' mtcars |> summ_by(c("mpg","disp"),vs)
#' mtcars |> summ_by(c("mpg","disp"),vs,xname="mpg_")
#' # grouping without column selection is possible but rarely useful in large dataset
#' mtcars |> summ_by(NULL,vs)
summ_by = function(d, cols=NULL, ..., pct=c(0.25,0.75), xname=""){
  plo = paste0("P",pct[1])
  if(!is.null(cols)) d = d |> dplyr::select(...,{{cols}})
  d. = d |> dplyr::group_by(...)
  gps = d. |> attr("groups")
  if(is.null(gps)) d. = d |>
    dplyr::select(dplyr::where(is.numeric)) |>
    tidyr::pivot_longer(dplyr::everything(),names_to="name") |>
    dplyr::group_by(dplyr::pick(dplyr::contains("name")))
  if(is.null(gps)){
    catv = d |> dplyr::select(dplyr::where(~!is.numeric(.x)))
    cat("Dropped:",names(catv),"\n")
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
          Mean = ~mean(.x, na.rm=T),
          Med = ~median(.x, na.rm=T),
          SD  = ~sd(.x, na.rm=T),
          Min = ~min(.x, na.rm=T),
          Plo = ~quantile(.x, pct[1], na.rm=T),
          Pup = ~quantile(.x, pct[2], na.rm=T),
          Max = ~max(.x, na.rm=T)
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
