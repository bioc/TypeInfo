setGeneric("paramNames",
            function(def) {
              standardGeneric("paramNames")
            })

setMethod("paramNames", "SimultaneousTypeSpecification",
           function(def) {
             unique(as.character(sapply(def, names)))
           })

setMethod("paramNames", "IndependentTypeSpecification",
           function(def) {
             names(def)
           })

setMethod("paramNames", "ReturnTypeSpecification",
           function(def) {
              character(0)
           })


setMethod("paramNames", "function",
           function(def)
             names(formals(def)))
          



typeInfo =
function(func)
{
     return( attr(func, "TypeInfo") )
}

"typeInfo<-" =
function(func, value, rewrite = TRUE)
{

   if(is(func, "genericFunction"))
     stop("Type information for a function is not supported for generic functions. The type information comes from methods. The return type will be handled in the future directly by the setGeneric and setMethod functions.")

  
   if(rewrite) {
     if(is.null(attr(func, "TypeInfo")) && is.null(attr(func, "originalSource")))
        func = rewriteTypeCheck(func,  doReturn = hasReturnType(value), checkArgs = hasParameterType(value)) 
     else
        warning("Looks like we have already done the rewrite of the body of the function")
   }
   
  ids = paramNames(value)
  if(length(ids) != 0) {
      m = match(ids, names(formals(func)))
      if(any(is.na(m)))
        stop("names of parameters in type specification don't match formal parameter names: ", paste(ids[is.na(m)]))
  }

  attr(func, "TypeInfo") = value

  func
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
