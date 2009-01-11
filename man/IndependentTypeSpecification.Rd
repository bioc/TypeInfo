\name{IndependentTypeSpecification}
\alias{IndependentTypeSpecification}
\title{Create separate type information for different parameters.}
\description{
 This function is a constructor for the
 \code{\link{IndependentTypeSpecification-class}} class.
 In short, it collects information about the possible
 types of parameters that is used to validate arguments in a call
 separately. This contrasts with checking the combination of
 arguments in the call against a particular signature.
}
\usage{
IndependentTypeSpecification(..., returnType, obj = new("IndependentTypeSpecification", list(...)))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{name elements of which are either character vectors
    or expressions/calls that can be evaluated.
    These are of type \code{\link{ClassNameOrExpression-class}}.
  }
  \item{returnType}{the expected type of the return value. This is optional.}
  \item{obj}{the instance of class \code{\link{TypeSpecification-class}} that is to
    be populated with the values from \code{\dots} and \code{returnType}.}
}

\value{
  The return value is  \code{obj}
  after it has been populated with the arguments \code{\dots} and
  \code{returnType}.
}

\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{typeInfo}},   \code{\link{typeInfo<-}}
  \code{\link{checkArgs}}, \code{\link{checkReturnValue}}  
  \code{\link{IndependentTypeSpecification-class}}
  \code{\link{SimultaneousTypeSpecification}} 
  \code{\link{SimultaneousTypeSpecification-class}}
}
\examples{
pow = function(a, b)
{
     # the return here is important to ensure the return value is checked.
   return(a^b)
}  

typeInfo(pow) = 
  IndependentTypeSpecification(
        a = c("numeric", "matrix", "array"),
        b = "numeric",
        returnType = quote(class(a)) 
   )


IndependentTypeSpecification(
        a = c("numeric", "matrix", "array"),
        b = new("StrictIsTypeTest","numeric"),
        c = new("StrictIsTypeTest",c("numeric", "complex")),
        d = as("numeric", "NamedTypeTest"),
        e = new("InheritsTypeTest", c("numeric", "complex"))
 )
}
\keyword{programming}
\keyword{interface}
