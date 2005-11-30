g = f <- function(x) {
    x <- x^2
     return(x)
}
typeInfo(f) <-
     SimultaneousTypeSpecification( TypedSignature( x="numeric" ) )

f(1)

