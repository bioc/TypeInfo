#
# This file contains the methods for rewriting the body of a function
# and all its sub-expressions so that we
#   a) call checkArgs() as the first action of the function
#   b) call checkReturnValue() when we return.
# The second involves replacing calls to return() with calls to checkReturnValue().
# Also, we have to deal with the case that there is no explicit return.

# We have not dealt with all cases. We'll find them as we go since this is a prototype.

# Don't deal with the case 

setGeneric("rewriteTypeCheck",  function(f, doReturn = TRUE, checkArgs = TRUE, addInvisible = FALSE) { standardGeneric("rewriteTypeCheck") })

setMethod("rewriteTypeCheck", "function",
function(f, doReturn = TRUE, checkArgs = TRUE, addInvisible = FALSE)
{
  ff = f
  b = body(f)

  checkArgs = checkArgs && length(formals(f))
  
  if(doReturn || checkArgs) 
      b  = rewriteTypeCheck(b, doReturn, checkArgs)
  

  if(doReturn && (inherits(b, "{") || is.name(b))) {

       # This modifies the last expression in the body { } if it has not already been rewritten
       # which would happen if it is an explicit return(....) .
     n = length(b)
     e = if(is.name(b)) b else b[[n]]

     if(is(e, "if") || is(e, "for") || is(e, "while")) {
     } else if(is.name(e)) {    
        e = substitute(checkReturnValue(v, return(v)), list(v = e))
        if(checkArgs)
          e[[4]] = quote(.sig)
        if(inherits(b, "{"))
          b[[n]] = e
        else
          b = e
     } else if((!is.call(e) && as.character(e[[1]]) == "checkReturnValue")
                  ||  (is.call(e) && as.character(e[[1]]) != "checkReturnValue")
                  || isLiteral(e)){
             # By assigning the value to an intermediate variable, we avoid evaluating
             # the expression twice in the call to checkReturnValue and the return from that.

        b[[n]] = substitute(.val <- val, list(val = e))
        if(checkArgs)
           b[[n+1]] = substitute(checkReturnValue(v, return(v), .sig), list(v = as.name(".val")))
        else
           b[[n+1]] = substitute(checkReturnValue(v, return(v)), list(v = as.name(".val")))

        if(is.call(e) && as.character(e[[1]]) == "invisible") {
          b[[n+1]][[3]] = quote(return(invisible(.val)))
        }
     }
   }


  n = length(b)
  if(checkArgs) {
       # Now put in a call to checkArgs() as the first expression of the body.
       # Note that if we don't have to do type checking on the return value,
       # we don't assign the return value of checkArgs().
     b[3:(n + 1)] = b[2:n]
     if(doReturn)
        b[[2]] = quote(.sig <- checkArgs())
     else
        b[[2]] = quote(checkArgs())    
   }


   # Now put the changes back into the function and attach
   # the type information.
  body(f) = b
  environment(f)  = environment(ff)

  attributes(f) = attributes(ff)
  attr(f, "originalSource") = attr(f, "source")
  attr(f, "source") = deparse(f)


  f
})

setMethod("rewriteTypeCheck", "{",
function(f, doReturn = TRUE, checkArgs = TRUE, addInvisible = FALSE)
{
  for(i in 2:length(f)) {
    f[[i]] = rewriteTypeCheck(f[[i]], doReturn, checkArgs, addInvisible)
  }

 f
})

setMethod("rewriteTypeCheck", "ANY", function(f, doReturn = TRUE, checkArgs = TRUE, addInvisible = FALSE) f)


rewriteLanguage =
function(f, doReturn = TRUE, checkArgs = TRUE, addInvisible = FALSE)
{
  f[[3]] = rewriteTypeCheck(f[[3]], doReturn, checkArgs, addInvisible)

  if(length(f) == 4) 
    f[[4]] = rewriteTypeCheck(f[[4]], doReturn, checkArgs, addInvisible)
  

  f
}  

setMethod("rewriteTypeCheck", "if", rewriteLanguage)
setMethod("rewriteTypeCheck", "while", rewriteLanguage)
setMethod("rewriteTypeCheck", "for", rewriteLanguage)

setMethod("rewriteTypeCheck", "call",
function(f, doReturn = TRUE, checkArgs = TRUE, addInvisible = FALSE)
{
  if(!doReturn)
    return(f)

  if(is.name(f[[1]]) && as.character(f[[1]]) %in% c("break", "repeat"))
    return(f)
  else if(is.name(f[[1]]) && as.character(f[[1]]) == "return") {
     addAssign = FALSE  # .val <- expression in original return
     if(length(f) == 1) {
       f = call("checkReturnValue", NULL)
       addAssign = TRUE
     }

     if( addAssign || isLiteral(f[[2]]) || is.call(f[[2]])) {
       f[[2]] = call('<-', as.name(".val"), f[[2]])
       f[[3]] = substitute(return(.val))
     } else if(is.name(f[[2]]))
       f[[3]] = f

     if(addInvisible) {
       q = quote(invisible(x))
       q[[2]] = f[[3]]
       f[[3]] = q
     }

     f[[1]] = as.name("checkReturnValue")     
     if(checkArgs)
        f[[4]] = as.name(".sig")
     
   } else {
    start = 2

    if(is.call(f[[1]]))
      start = 1
    else if(as.character(f[[1]]) == "invisible") {
      addInvisible = TRUE
    }
    for(i in seq(start, length(f))) {
       f[[i]] = rewriteTypeCheck(f[[i]], doReturn, checkArgs, addInvisible)
    }
  }
  f
}  
)



