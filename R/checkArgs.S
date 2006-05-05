# Todo
#
# Deal with missing, ANY, NULL, NA
# Scalar classes.
#


#  To validate the return value, we have tried to do this without
# modifying the original function definition. The approach was to
# define a new version of the function return() in the call frame
# of the function invocation. Then, this would receive the return
# value and be able to fetch the signature of the actual call
# from the parent frame, i.e. that of the function of interest.
# The trick was that the default argument of the jump would be
#   return(value)
# But this is defined in the wrong environment and context. This has to be
# explicitly passed by the caller to act as a jump out of the original function.
# We then tried to construct the expression and evaluate it in the parent frame
# of the call to our local return() function. But this didn't work, so we ended
# up developing the function rewriteTypeCheck() and using that.


setGeneric("checkArgs", 
function(f = sys.function(1), argNames, args = NULL, forceAll = FALSE, env = sys.frame(1),
          isMissing = logical(0))
{
 standardGeneric("checkArgs")
})

setMethod("checkArgs", "missing",
function(f = sys.function(1), argNames, args = NULL, forceAll = FALSE, env = sys.frame(1),
          isMissing = logical(0)) {
    f = sys.function(-2)
    env = sys.frame(-2)
    checkArgs(f, env = env)
})

setMethod("checkArgs", "function",
#
# This method merely locates the type information for the function and
# resolves the relevant arguments and then passes the pair onto another method
# for checkArgs().
#
#
function(f = sys.function(1), argNames, args = NULL, forceAll = FALSE, env = sys.frame(1),
          isMissing = logical())
{
  types = typeInfo(f)
  if(is.null(types)) {
      warning(paste("no TypeInfo available in function '", substitute(f), "'", sep=""))
      return(TRUE)
  }

  argNames = names(formals(f))
  isMissing = sapply(argNames, function(var)
    eval(substitute(missing(i), list(i = as.name(var))), env))
  names(isMissing) = argNames

 
  ## Degenerate case where there is no information on the parameters -- can we actually get here?
  if(length(types@.Data) == 0) {
    if(!(is.call(types@returnType) || is.expression(types@returnType) || !is.na(types@returnType)) )
        warning("TypeInfo found 0-length parameter and return type information")

    return(NULL)
  }

  if(missing(args)) {
   if(missing(argNames)) {
    if(forceAll)
       argNames = objects(env)
    else
       argNames = paramNames(types)
   }

   args = mget(argNames, env)
 }


  checkArgs(types, args = args, env = env, isMissing)
})

setMethod("checkArgs", "IndependentTypeSpecification",
#
# This checks the arguments in args against the type specification given by f which is
# a list of type specifications that are treated one at a time and all arguments must
# satisfy their own type specification.
#
function(f = sys.function(1), argNames, args = NULL,
         forceAll = FALSE, env = sys.frame(1), isMissing = logical(0)) {
  for(i in names(f)) {
    # Add in support for checking all the arguments and handling errors to cumulate them into a single
    # exception.
    tmp = checkType(args[[i]], f[[i]], env, i)
    if(is.logical(tmp) && !tmp)
      typeInfoValidationError( f[[i]], args[i] )
  }
  NULL
})


setMethod("checkArgs", "SimultaneousTypeSpecification",
function(f = sys.function(1), argNames, args = NULL, forceAll = FALSE,
          env = sys.frame(1), isMissing = logical(0)) {

  for(type in f) {
    if(all(sapply(names(type),
                   function(x) {
                     tt = type[[x]]
                     if(is.call(tt) || is.expression(tt)) {
                        eval(tt, env)
                     } else if(tt == "ANY")
                         TRUE
                     else if(tt == "NULL")
                       is.null(args[[x]])
                     else if(is(tt, "NamedTypeTest")) {
                         checkType( args[[x]], tt, env )
                     }
                     else 
                       is(args[[x]], tt)
#                     else
#                       stop("Incorrect parameter type specification for ", x, " in ", paste(names(type), type,  sep = " = ", collapse = ", "))
                   }))) {

      # Won't handle case when we just return from the end of the function. So need to explicitly add
      # validate function.
#      if((is(type, "TypedSignature") && !is.na(type@returnType))  ||
#            (is.call(types@returnType) || is.expression(types@returnType) || !is.na(types@returnType))) {
#       }
      
      return(type)
    }
  }

  typeInfoValidationError( f, args )
}
)


setMethod("checkArgs",  "InheritsTypeTest",
function(f = sys.function(1), argNames, args = NULL, forceAll = FALSE, env = sys.frame(1),
          isMissing = logical(0))
{
#   %in%
  FALSE
})





checkReturnValue =
function(returnType, returnJump, sig = NULL, f = sys.function(-1))
{
  if(!missing(sig) && !is.null(sig) && (is(sig, "TypedSignature") || is(sig, "TypeSpecification")) && !is.na(sig@returnType)) {
     type = sig@returnType
  } else {
     types = typeInfo(f)
     if(!is(types, "TypeSpecification"))
       returnJump
     
     type = types@returnType
  }

  status = checkType(returnType, type, sys.frame(1))
  if(is.logical(status) && status)
    return(returnJump)
  else {
     cond = paste("TypeInfo got '", class(returnType), "', expected '", type, "'", sep = "")
     class(cond) = "ReturnTypeValidationError"
     stop(cond)
  }

  returnJump
}  






# "ClassNameOrExpression"
# "DynamicTypeTest"              
# "InheritsTypeTest"             
# "NamedTypeTest"    -
# "TypeSpecification"
# "TypedSignature"               

setGeneric("checkType",
           function(value, type, env, name = "") standardGeneric("checkType"),
           valueClass = "logical")


setMethod("checkType", c(type = "StrictIsTypeTest"),
           function(value, type, env, name = "") {
              if(length(type) == 1 && is.na(type))
                return(TRUE)
              
              class(value) %in% type
           })

setMethod("checkType", c(type="InheritsTypeTest"),
           function(value, type, env, name = "") {
              if(length(type) == 1 && is.na(type))
                return(TRUE)
              
              any(sapply(type, function(klass) is(value, klass) ))
           })

setMethod("checkType", c(type = "DynamicTypeTest"),
           function(value, type, env, name = "") {
              #XXX need to know the name of the variable in the test.
              status = eval(type, env)
              if(is.character(status) && !inherits(status, "condition"))
                status = is(value, status)

              status
           })

#setMethod("checkType", c("environment", "DynamicTypeTest"),
#           function(value, type, env) {
#              eval(type, env)
#           })





