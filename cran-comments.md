## R CMD check results

0 errors | 0 warnings | 2 notes

* checking for future file timestamps ... NOTE
  unable to verify current time
  
  This issue has been documented here:
  https://stat.ethz.ch/pipermail/r-package-devel/2019q1/003577.html 

* checking R code for possible problems ... NOTE
  summ_by: no visible binding for global variable 'name'
  summ_by: no visible binding for global variable '.rows'
  Undefined global functions or variables:
    .rows name
    
  The 'name' and '.rows' variables are part of the default output 
  from dplyr::pivot_longer() and base::attr(), respectively,
  and do not need to be defined. 


