## R CMD check results

0 errors | 0 warnings | 0 note

## Comments for resubmission 

1. The Description field is intended to be a (one paragraph) description of what the package does and why it may be useful. Please add more details about the package functionality and implemented methods in your Description text.
For more details: 
<https://contributor.r-project.org/cran-cookbook/general_issues.html#description-length> 

Response: The Description field has been updated with more details as requested. 

2. If there are references describing the methods in your package, please add these in the description field of your DESCRIPTION file in the form authors (year) <doi:...> authors (year, ISBN:...) or if those are not available: <https:...> with no space after 'doi:', 'https:' and angle brackets for auto-linking. (If you want to add a title as well please put it in
quotes: "Title")
For more details: 
<https://contributor.r-project.org/cran-cookbook/description_issues.html#references>

Response: No reference added as this package is a collection of convenient functions without new methodology. 

3. Please add \value to .Rd files regarding exported methods and explain the functions results in the documentation. Please write about the structure of the output (class) and also what the output means. (If a function does not return a value, please document that too, e.g. 
\value{No return value, called for side effects} or similar) For more details: 
<https://contributor.r-project.org/cran-cookbook/docs_issues.html#missing-value-tags-in-.rd-files>
Missing Rd-tags:
     fc.Rd: \value

Response: The return value for `fc()` has been updated to state that a logical vector indicating if the operation succeeded for each of the files attempted will be returned. 

4. \dontrun{} should only be used if the example really cannot be executed (e.g. because of missing additional software, missing API keys, ...) by the user. That's why wrapping examples in \dontrun{} adds the comment ("# Not run:") as a warning for the user. Does not seem necessary. 
Please replace \dontrun with \donttest.
Please unwrap the examples if they are executable in < 5 sec, or replace dontrun{} with \donttest{}.
For more details: 
<https://contributor.r-project.org/cran-cookbook/general_issues.html#structuring-of-examples> 

Response: 
-	The example for `ggsrc()` is now unwrapped. 
-	The example for `ft_def()` remains wrapped in \dontrun{} as it would change the default values in the user’s workspace. 
-	The example for `fc()` remains wrapped in \dontrun{} as it would need to copy and generate a file in the user’s file space. 

5. Please write TRUE and FALSE instead of T and F. Please don't use "T" or "F" as vector names.
For more details: 
<https://contributor.r-project.org/cran-cookbook/code_issues.html#tf-instead-of-truefalse>

Response: The corresponding code has been updated to TRUE and FALSE accordingly. 

6. You write information messages to the console that cannot be easily suppressed.
It is more R like to generate objects that can be used to extract the information a user is interested in, and then print() that object. 
Instead of print()/cat() rather use message()/warning() or
if(verbose)cat(..) (or maybe stop()) if you really have to write text to the console. (except for print, summary, interactive functions)
-> R/init.R
For more details: 
<https://contributor.r-project.org/cran-cookbook/code_issues.html#using-printcat>

Response: The corresponding code has been updated to `message()`. 

7. Please ensure that your functions do not write by default or in your examples/vignettes/tests in the user's home filespace (including the package directory and getwd()). This is not allowed by CRAN policies. 
Please omit any default path in writing functions. In your examples/vignettes/tests you can write to tempdir().
-> R/init.R
For more details: 
<https://contributor.r-project.org/cran-cookbook/code_issues.html#writing-files-and-directories-to-the-home-filespace>

Response: The default path in `fc()` has been omitted. Its example has been updated to use tempdir() but still wrapped in \dontrun{} as it would need to copy and generate a file in the user’s file space. 


