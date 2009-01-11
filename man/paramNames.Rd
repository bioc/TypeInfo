\name{paramNames}
\docType{methods}
\alias{paramNames}
\alias{paramNames,SimultaneousTypeSpecification-method}
\alias{paramNames,IndependentTypeSpecification-method}
\alias{paramNames,TypeSpecification-method}
\alias{paramNames,NamedTypeTest-method}
\alias{paramNames,TypedSignature-method}
\alias{paramNames,ReturnTypeSpecification-method}
\alias{paramNames,function-method}
\title{Compute the names of all the specified parameters in a TypeSpecification object}
\description{
  This generic function has methods  for computing the names of
  all the parameters in a type specification for a function
  for which type information is explicitly specified.
  There is also a method for functions which merely returns the names of
  the formal parameters, i.e. a call to \code{\link[base]{formals}}.
}
\usage{
paramNames(def)
}
\arguments{
  \item{def}{the object from which we are to identify the names of the
     parameters}
}

\value{
  A character vector giving the names of the parameters that
  were found.
}

\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{typeInfo}}
}

\keyword{programming}
\keyword{interface}
