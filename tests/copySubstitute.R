library(TypeInfo)
require(Biobase)
copySubstitute <- Biobase::copySubstitute


typeInfo( copySubstitute ) <-
    IndependentTypeSpecification(
            src = c("character", "connection"),
            dest = expression(is(dest, class(src))),
            symbolValues = "list" ,
            symbolDelimiter = expression(is.character(symbolDelimiter) &&
                length(symbolDelimiter) == 1 &&
                all(nchar(symbolDelimiter) == 1)),
            allowUnresolvedSymbols = "logical" ,
            recursive = "logical" ,
            removeExtension = "character",
            returnType = "NULL")


infile  = tempfile()
outfile = tempfile()

writeLines(text=c("We will perform in @WHAT@:",
  "So, thanks to @WHOM@ at once and to each one,",
  "Whom we invite to see us crown'd at @WHERE@."),
  con = infile)

## create the symbol table
z = list(WHAT="measure, time and place", WHOM="all", WHERE="Scone")

## run copySubstitute
copySubstitute(infile, outfile, z)

cat("Next call should be an error\n")
## should be caught, but is not
tryCatch({
  copySubstitute(123, outfile, z);
  stop("should have caught that!")
  }, error=function(err) {})
