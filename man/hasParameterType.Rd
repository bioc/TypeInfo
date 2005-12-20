\name{hasParameterType}
\docType{methods}
\alias{hasParameterType}
\alias{hasParameterType,NamedTypeTest-method}
\alias{hasParameterType,SimultaneousTypeSpecification-method}
\alias{hasParameterType,TypeSpecification-method}
\alias{hasParameterType,IndependentTypeSpecification-method}
\alias{hasReturnType}
\alias{hasReturnType,TypeSpecification-method}
\alias{hasReturnType,SimultaneousTypeSpecification-method}
\alias{hasParameterType,function-method}
\alias{hasReturnType,function-method}

\title{Functions to query existence of specific type information}
\description{
  These functions and the associated methods are used to determine if a
  function has type specification for any of the parameters
  and also for the return type.
  These are used when rewriting the body of the function to
  support type checking (see \code{\link{rewriteTypeCheck}}).
  We use these predicate functions to determine if
  we have information about any parameter types and if not
  we do not add a check of the arguments (i.e. a call to \code{\link{checkArgs}}). Similarly,
  we determine if we have any information about the return type before
  adding a call to \code{\link{checkReturnValue}}.
  

  They are used internally. They are exported in order to make them
  available for others to use in providing alternatives to this
  prototype implementation and also to overcome an anomoly in
  the \code{callNextMethod()} mechanism that appears to disappear
  when the generic is exported from the NAMESPACE.
  
  
}
\usage{
hasParameterType(def)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{def}{the object which is to be queried.
    This can be a function or  a \code{\link{TypeSpecification-class}}
    instance which is typically extracted from the function.
    Generally, a user would pass the function to the function call
    and the resulting sequence of recursive method calls will occur.
    }
}
\value{
  A logical value indicating if the object \code{def}
  \dQuote{has} the relevant facet/property.
}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{rewriteTypeCheck}}
  \code{\link{checkArgs}}
  \code{\link{checkReturnValue}}
}
\examples{

hasReturnType(SimultaneousTypeSpecification(
                       TypedSignature(x="integer", returnType = "duncan")))


# FALSE
hasReturnType(SimultaneousTypeSpecification(TypedSignature(x="integer")))

# TRUE
hasReturnType(SimultaneousTypeSpecification(returnType = "duncan"))

# TRUE
hasReturnType(ReturnTypeSpecification("duncan"))

hasReturnType(IndependentTypeSpecification(x = c("integer", "logical"),
                                           y  = "character",
                                           returnType = "duncan"))

hasReturnType(IndependentTypeSpecification(x = c("integer", "logical"),
                                           y  = "character"))

}
\keyword{interface}
\keyword{programming}
