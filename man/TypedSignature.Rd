\name{TypedSignature}
\alias{TypedSignature}
\title{Constructor for a TypedSignature object}
\description{
  This is a constructor function for the
  \code{\link{TypedSignature-class}}
  that represents constraints
  on the types or values of a combination
  of parameters.
  It takes named arguments that identify the
  types of the parameters.
  Each parameter type should be
  an object that is \dQuote{compatible with}
  \code{\link{ClassNameOrExpression-class}},
  i.e. a test for inheritance or a dynamic expression.
}
\usage{
TypedSignature(..., returnType, obj = new("TypedSignature", list(...)))
}
\arguments{
  \item{\dots}{the types for the parameters given as \code{name = type}
    to identify the parameter and its type description.}
  \item{returnType}{the type description for the return value.
    This applies to the particular combination of inputs given in \dots}
  \item{obj}{the instance to populate with the information given
    in the other arguments. This allows us to pass in objects of
    sub-classes to this function or to populate previously
    created objects.}
}
\value{
  The populated value of \code{obj}, by default
  an object of class \code{\link{TypedSignature-class}}.
}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{SimultaneousTypeSpecification}}
  \code{\link{typeInfo}}
  \code{\link{checkArgs}}
}
\examples{
 TypedSignature(x = "logical", y = quote(length(y) == length(x)))
}
\keyword{interface}
\keyword{programming}

