g = f = function() {
    "done"
}
typeInfo(f) <-
    SimultaneousTypeSpecification(
        returnType = "numeric"
     )


typeInfo(g) <-
    ReturnTypeSpecification(
        "numeric"
     ) 


f <- function() return(12)
typeInfo(f) <- ReturnTypeSpecification("numeric")

f()


f <- function(x) x
typeInfo(f) <- ReturnTypeSpecification("numeric")

f(10)
f(as.integer(10)) # okay since this is an InheritsTypeTest
f("")

ff <- function(x) x
typeInfo(ff) <- ReturnTypeSpecification(as("numeric", "StrictIsTypeTest"))
ff(as.integer(10)) # fails because now we have a strict test.


f <- function(x) return(x)
typeInfo(f) <- ReturnTypeSpecification("numeric")
f(10)
f(TRUE)
f("")




f <- function(x) { return() }
typeInfo(f) <-
    SimultaneousTypeSpecification(
        TypedSignature( x = "numeric" ),
        returnType = "NULL"
    )


f <- function(x) { return(2*x) }
typeInfo(f) <- ReturnTypeSpecification( "numeric" )

f(10)
f(matrix(0, 2, 2)) # Fails appropriately.




f <- function(x) {
    if (x==1)
        return(1)
    else
        return(FALSE)
}
typeInfo(f) <- SimultaneousTypeSpecification( returnType = "numeric" )

f(1)
f(2) # Fails because FALSE is returned.

