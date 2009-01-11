\name{ReturnTypeSpecification}
\alias{ReturnTypeSpecification}
\title{Constructor for specifying information about only the return type}
\description{
  This function is a constructor for a class that
  represents information only about the return type
  of a function and explicitly has no information about
  the parameters.
}
\usage{
ReturnTypeSpecification(type, obj = new("ReturnTypeSpecification"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{type}{the type specification.
    This should be an object of class ClassNameOrExpression
    or coercible to one.}
  \item{obj}{the instance that is to be populated and returned.}
}

\value{
 By default, an object of class
 \code{\link{ReturnTypeSpecification-class}}.
 However, it merely returns the value of
 \code{obj} after populating it with the value of \code{type}.
 So strictly the return value is the augmented
 value of \code{obj}.
   
}

\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{IndependentTypeSpecification}}
  \code{\link{SimultaneousTypeSpecification}}  
}
\examples{
 ReturnTypeSpecification(quote(length(x) == 3))

 ReturnTypeSpecification("matrix")

 ReturnTypeSpecification(new("StrictIsTypeTest", "matrix"))
}
\keyword{interface}
\keyword{programming}

