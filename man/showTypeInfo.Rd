\name{showTypeInfo}
\docType{methods}
\alias{showTypeInfo}
\alias{showTypeInfo,ANY-method}
\alias{showTypeInfo,function-method}
\alias{showTypeInfo,SimultaneousTypeSpecification-method}
\alias{showTypeInfo,IndependentTypeSpecification-method}
\alias{showTypeInfo,TypedSignature-method}
\alias{showTypeInfo,InheritsTypeTest-method}
\alias{showTypeInfo,StrictIsTypeTest-method}
\alias{showTypeInfo,DynamicTypeTest-method}
\title{Display information about argument types}

\description{
  This generic function returns type specifications as a list.
  Elements in the list contain information about different parts of the
  signature. The order and white spece of the list suggests structure of
  the type specification.

  \code{showTypeInfo} is usually invoked with a single argument, the
  name of the function with type information. 
}

\usage{
showTypeInfo(object, name=character(), prefix="", ...)
}
\arguments{
  \item{object}{The object about which type information is required}
  \item{name}{Class name, not normally specified by user.}
  \item{prefix}{Used by methods to ensure pretty indentation type specifications.}
  \item{...}{Additional arguments used for derivatives of \code{NamedTypeTest}, not noramlly assigned by user.}
}

\value{
  A list containing type information for \code{def}
}

\author{MT Morgan <mtmorgan@fhcrc.org>}

\seealso{
  \code{\link{typeInfo}}
}
\examples{
foo <- function(x) { return(x) }
typeInfo( foo ) <- SimultaneousTypeSpecification(
  TypedSignature( x = "numeric" ),
  returnType = "numeric" )
res <- showTypeInfo( foo )
cat( res, sep="\n" )
}
\keyword{programming}
\keyword{interface}
