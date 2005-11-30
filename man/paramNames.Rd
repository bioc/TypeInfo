\name{paramNames}
\alias{paramNames}
\alias{paramNames,SimultaneousTypeSpecification}
\alias{paramNames,IndependentTypeSpecification}
\alias{paramNames,function}
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
\details{
}
\value{
  A character vector giving the names of the parameters that
  were found.
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{}

\seealso{
  \code{\link{typeInfo}}
}
\examples{

}
\keyword{programming}
\keyword{interface}
