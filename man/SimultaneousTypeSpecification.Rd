\name{SimultaneousTypeSpecification}
\alias{SimultaneousTypeSpecification}
\title{Create type signature information governing parameters in a call.}
\description{
  This function is a constructor for specifying different
  permissible  combinations of argument types in a call to a function.
  Each combination of types identifies a signature and in a call,
  the types of the arguments are compared with these types. If all
  are compatible with the specification, then the call is valid.
  Otherwise, we check other permissible combinations.

  Note that if an instance of
  \code{\link{SimultaneousTypeSpecification-class}}
  is provided to the \code{\link{checkArgs}} function, the \code{\link{TypedSignature-class}}
  elements are searched sequentially until a matching one is found.
  That matching signature is returned.  Therefore, the order the
  signatures are specified within the
  \code{\link{SimultaneousTypeSpecification-class}} object is
  important. This could change if we wanted. At present, it is up to the author to specify
  what they want to have happen. We could use the S4 signature
  matching technique when this is finalized and implemented in C code.  
}
\usage{
SimultaneousTypeSpecification(..., returnType, obj = new("SimultaneousTypeSpecification", list(...)))
}

\arguments{
  \item{\dots}{named \code{\link{TypedSignature}} objects. The names
    identify the parameter to which the type specification applies.}
  \item{returnType}{if supplied this should be an object of class \code{\link{ClassNameOrExpression-class}}.}
  \item{obj}{the instance of \code{\link{TypeSpecification-class}} that is to
       be populated with the content of \code{\dots} and \code{returnType}.}
}
\details{
}
\value{
  The return value is \code{obj}.
  By default, this has class \code{\link{SimultaneousTypeSpecification-class}}.
  It should be an object of class \code{\link{TypeSpecification-class}}.
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{}



\seealso{
  \code{\link{IndependentTypeSpecification}}
  \code{\link{typeInfo}} 
}
\examples{
foo =
function(x, y)
{
  x + y
}

typeInfo(foo) =
    SimultaneousTypeSpecification(
         TypedSignature(x = "integer", y = "integer"),
         TypedSignature(x = "numeric", y = "logical"))
}
\keyword{programming}
\keyword{interface}
