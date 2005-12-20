setGeneric("showTypeInfo",
           function( object, name = character(), prefix = "", ... ) standardGeneric("showTypeInfo"))

.showTypeInfoReturnType <- function( object, name = "returnType", prefix = "" ) {
  if (!is.na(object@returnType))
    showTypeInfo( object@returnType, name, prefix)
  else
    NULL
}

.prefixIncr <- function( s ) return( paste( s, "  ", sep = "" ))

setMethod("showTypeInfo",
          signature( object = "ANY" ),
          function( object, name = character(), prefix = "" ) {
            stop("showTypeInfo not implemented for '", class(object), "'\n", sep="")
          })

setMethod("showTypeInfo",
          signature( object = "function" ),
          function( object, name = character(), prefix = "" ) {
            showTypeInfo( typeInfo( object ))
          })

setMethod("showTypeInfo",
          signature( object = "IndependentTypeSpecification" ),
          function( object, name = character(), prefix = "" ) {
            name <- paramNames(object)
            c(paste( prefix, "[IndependentTypeSpecification]", sep = "" ),
              unlist( sapply(seq( along = object ),
                             function(i) showTypeInfo( object[[i]], name[[i]],
                                                      prefix = .prefixIncr( prefix )))),
              .showTypeInfoReturnType( object, prefix = .prefixIncr( prefix )))
          })

setMethod("showTypeInfo",
          signature( object = "SimultaneousTypeSpecification"),
          function( object, name = character(), prefix = "" ) {
            c(paste( prefix, "[SimultaneousTypeSpecification]", sep = "" ),
              unlist( sapply(seq( along = object ),
                             function(i) showTypeInfo(object[[i]], prefix = .prefixIncr( prefix )))),
              .showTypeInfoReturnType( object, prefix = .prefixIncr( prefix )))
          })

setMethod("showTypeInfo",
          signature( object = "TypedSignature" ),
          function( object, name = character(), prefix = "" ) {
            name <- paramNames( object )
            c(paste(prefix, "[TypedSignature]", sep = ""),
              as.vector( sapply(1:length(object),
                                function(i) showTypeInfo(object[[i]], name[[i]],
                                                         prefix = .prefixIncr( prefix )))),
              .showTypeInfoReturnType( object, prefix = .prefixIncr( prefix )))
          })

setMethod("showTypeInfo",
          signature( object = "InheritsTypeTest" ),
          function( object, name, prefix ) {
            paste(prefix, name, ": ",
                  "is(", name, ", c(",
                  paste("'", as.character( object ), "'", sep = "", collapse = ", "), "))",
                  "  [InheritsTypeTest] ",
                  collapse = "", sep = "")
          })

setMethod("showTypeInfo",
          signature( object = "StrictIsTypeTest" ),
          function( object, name, prefix ) {
            paste(prefix, name, ": ",
                  "class(", name, ") %in% c(",
                  paste("'", as.character(object), "'", sep="", collapse = ", "), "))",
                  " [StrictIsTypeTest]",
                  collapse = "", sep = "")
                  
          })

setMethod("showTypeInfo",
          signature( object = "DynamicTypeTest" ),
          function( object, name, prefix ) {
            paste(prefix, name, ": ",
                  as.expression( object ), " [DynamicTypeTest]", sep = "")
          })

print.IndependentTypeSpecification <- function( x, ... )
  cat( showTypeInfo( x ), sep="\n")

print.SimultaneousTypeSpecification <- function( x, ... )
  cat( showTypeInfo( x ), sep="\n")

print.TypedSignature <- function( x, ... )
  cat( showTypeInfo( x ), sep="\n")

## print.InheritsTypeTest =
## function(x, ...) {
  
##   tmp = paste("[InheritsTypeTest] ", "is( , c(",
##          paste("'", as.character(x), "'", sep = "", collapse = ", "),
##          "))", collapse = "", sep = "")

##   print(tmp)
## }


## print.StrictIsTypeTest =
## function(x, ...) {
##   tmp = paste("[StrictIsTypeTest] ", "class( ) %in% c(",
##          paste("'", as.character(x), "'", sep = "", collapse = ", "),
##          "))", collapse = "", sep = "")


##   print(tmp)
## }

