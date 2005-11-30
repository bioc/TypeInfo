foo =
function(x, .return = return(z))
{
  if(x)
     z = bar(x+1, return(x + 1))
  else
     z = bar(x+1)
  
  cat("Finishing foo\n")
  z
}

f = function(x)
{
  if(x)
    return(10)
  else {
     x = 20
     y = sum(x)
  }

  20
}  

g = function(x)
{
   return(x+1)
}  

bar =
function(a, b = return(a))
{
  if(missing(b)) {
    if(FALSE) {
      argName = substitute(a)
      .return = get(".return", sys.frame(1))
      .return[[2]] = argName
      b = quote(do.call("return", list(x = argName)))
      bb = substitute(return(x), list(x = argName))
    }

    f = sys.function(1)
    .return = formals(f)[[".return"]]
  }
  
  cat("in bar", a, "\n")

  eval.parent(.return)
#  print(eval.parent(eval.parent(b)))
  
  cat("Finishing bar\n")
  return(10)
}  


