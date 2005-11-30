f <- function(x) {
     return(tmp <<- tmp + x)
}
typeInfo(f) <-
     SimultaneousTypeSpecification(
       TypedSignature( x="numeric" ),
       returnType = "numeric")


tmp <- 0
g =
function(x) {
  checkReturnValue(.val <- tmp <<- tmp + 1, return(.val), NULL)
  cat("still going\n")
}

attr(g, "TypeInfo") <- ReturnTypeSpecification("numeric")
