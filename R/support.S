setGeneric("paramNames",
            function(def) standardGeneric("paramNames"))

setMethod("paramNames", "SimultaneousTypeSpecification",
           function(def) unique(as.character(sapply(def, names))))

setMethod("paramNames", "IndependentTypeSpecification",
           function(def) names(def))

setMethod("paramNames", "TypedSignature",
          function(def) names(def))

setMethod("paramNames", "ReturnTypeSpecification",
           function(def) character(0))

setMethod("paramNames", "function",
           function(def) names(formals(def)))
          
typeInfo =
function(func)
{
     return( attr(func, "TypeInfo") )
}

"typeInfo<-" =
function(func, rewrite = TRUE, value)
{
   if(is(func, "genericFunction"))
     stop("applying TypeInfo to generic functions not supported")
  
   if(rewrite) {
     if(is.null(attr(func, "TypeInfo")) && is.null(attr(func, "originalSource")))
        func = rewriteTypeCheck(func,  doReturn = hasReturnType(value), checkArgs = hasParameterType(value)) 
     else
        warning("redefine and reapply TypeInfo to ensure intended type checking")
   }

  ids = paramNames(value)
  if(length(ids) != 0) {
      m = match(ids, paramNames(func))
      if(any(is.na(m)))
        stop(paste("typed parameter(s) '", paste( ids[is.na(m)], collapse="', '"),
                   "' do not match named parameter(s) '", paste(paramNames(func), collapse="', '" ),
                   "'", sep="" ))
  }

  attr(func, "TypeInfo") = value

  func
}

typeInfoValidationError =
function( obj, args ) {
  classes = lapply( args, class )
  cond = paste(
    "TypeInfo could not match signature.\n",
    "Supplied arguments and their types:\n  ",
    paste(names(args), ": ", classes, sep="", collapse="\n  "),
    "\nAvailable signature(s):\n",
    paste(showTypeInfo( obj, names(args), prefix = "  " ), collapse="\n"),
    sep = "" )
  class(cond) = "TypeValidationError"
  stop(cond, call. = FALSE)
}


setGeneric("hasReturnType", function(def) standardGeneric("hasReturnType"))


setMethod("hasReturnType", "TypeSpecification",
             function(def) {
                 if(length(def@returnType) > 1  || !is.na(def@returnType))
                    TRUE
                 else
                    FALSE
             })


setMethod("hasReturnType", "SimultaneousTypeSpecification",
             function(def) {
                 if(callNextMethod())
                   return(TRUE)

                 any(sapply(def, hasReturnType))
             })


setMethod("hasReturnType", "function",
             function(def) {
                info = typeInfo(def)
                if(is.null(info))
                  return(FALSE)

                hasReturnType(info)
             })





setGeneric("hasParameterType", function(def) standardGeneric("hasParameterType"))

setMethod("hasParameterType", "function",
             function(def) {
                info = typeInfo(def)
                if(is.null(info))
                  return(FALSE)

                hasParameterType(info)
             })



setMethod("hasParameterType", "TypedSignature",
             function(def) {
                length(names(def)) > 0
             })

setMethod("hasParameterType", "NamedTypeTest",
             function(def) {
                length(names(def)) > 0
             })


setMethod("hasParameterType", "SimultaneousTypeSpecification",
             function(def) {
                 any(sapply(def, hasParameterType))
             })


setMethod("hasParameterType", "TypeSpecification",
             function(def) {
                 FALSE
             })

setMethod("hasParameterType", "IndependentTypeSpecification",
             function(def) {
                length(names(def))
             })




isLiteral =
function(x)
{
#  class(x) %in% c("character", "numeric", "logical", "list")

  !(class(x) %in% c("call", "expression", "language", "name"))
}
