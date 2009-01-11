\name{DynamicTypeTest-class}
\docType{class}
\alias{DynamicTypeTest-class}
\alias{DynamicTypeTest}

\title{Class "DynamicTypeTest" for computed tests on objects.}
\description{
  This virtual class is used interntally to unite type signatures that
  perform a computation to assess argument type suitability.
}
\section{Slots}{None.}
\section{Extends}{
Class \code{"ClassNameOrExpression"}, directly.
}
\section{Methods}{None.}

\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{TypedSignature}}
  \code{\link{TypeSpecification-class}}  
}
\examples{
  checkedSqrt <- function(x) {
      return(sqrt(x))
  }

  typeInfo(checkedSqrt) <-
    SimultaneousTypeSpecification(
      TypedSignature(x=quote(
        is(x, "numeric") && all(x>=0))))

  typeInfo(checkedSqrt)

  checkedSqrt(2)
  try(checkedSqrt(-2))
}
\keyword{classes}
