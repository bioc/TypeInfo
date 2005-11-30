i =
function(n)
{
  invisible(diag(n))
}

typeInfo(i) = ReturnTypeSpecification("matrix")

h =
function(n)
{
  return(invisible(diag(n)))
}


g =
function()
{
  invisible(return(x+y))
}

# 
gg =
function()
{
  invisible(return(x))
}


 # Works.
ggg =
function()
{
  invisible(x)
}  
