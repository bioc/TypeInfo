foo =
function(x, y)
{
  x + y
}

typeInfo(foo) =
    SimultaneousTypeSpecification(
         c(x = "integer", y = "integer"),
         c(x = "numeric", y = "logical"))


bar =
function(x, y, z)
{

}

typeInfo(bar) = 
    SimultaneousTypeSpecification(
         c(x = "integer", y = "integer"),
         c(x = "numeric", y = "logical"))


foobar =
function(x, y, z = 10)
{
  sig = checkArgs(foobar, c("x", "y"))

  if(x < 0) {
    cat("returning from first return x< 0\n")
    return(x+y+z)
  }

  if(y == TRUE) {
    cat("returning from second return: y == TRUE\n")
    return("This is string")
  }

  cat("About to check return value of x+y\n")
  checkReturnValue(x+y, base::return(x+y), sig)
  cat("Still going to pi\n")
  pi
}

# This has no return value for the first signature,
# a return type 
typeInfo(foobar) =
    SimultaneousTypeSpecification(
         list(x = "integer", y = quote(is(y, "integer") && length(y) == length(x))),
         TypedSignature(x = "numeric", y = "logical", returnType = "integer"),
         returnType = "numeric"
        )



# The return type for this one is symbolically the same as that of the input
# parameter a.
pow =
function(a, b)
{
   return(a^b)
}  

typeInfo(pow) = 
IndependentTypeSpecification(
        a = c("numeric", "matrix", "array"),
        b = "numeric",
        returnType = quote(class(a)) 
)



plot =
function(x, ...)
{  
  TRUE
}

typeInfo(plot) =
 SimultaneousTypeSpecification(
    c(x = "integer")#XXX, y = "integer", foo = "numeric")
 )

zz =
function(x, y)
{
  x+y
}  

if(FALSE) # XXX
typeInfo(zz) = ReturnTypeInfo("numeric")


if(FALSE) {
 z = 1:2
 foo(z[1], z[2])
 foo(1, TRUE)

    # Fails as expected
 foo("a", 3)
 foo(foo)


 foobar(3, TRUE)



 pow(2, 3)
 pow(matrix(1:4, 2), 3)

 z = rewrite(foobar)
 z(1, FALSE, as.integer(3))
}
