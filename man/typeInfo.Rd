\name{typeInfo}
\alias{typeInfo}
\alias{typeInfo<-}
\title{Get or set type information for a function.}
\description{
  These functions provide controlled access to type information
  for a function.
  They encapsulate the way the information is stored for the function
  (although it is trivial to find out how it is done and where the
  information is)
}
\usage{
typeInfo(func)
"typeInfo<-"(func, rewrite = TRUE, value)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{func}{the function whose type information is to be accessed}
  \item{rewrite}{a logical value. This controls whether the body of the
    function \code{func} is rewritten so that checks for the arguments
    and return type are added to the code and the appropriate
    actions are taken when the function returns control to the caller.
    This is necessary to get calls to \code{return} in the function
    to behave correctly and allow the return value to be validated.
  }
  \item{value}{an object of class \code{\link{TypeSpecification-class}}}
}

\value{
  \code{typeInfo} returns the type information associated with
  the function.
  \code{typeInfo<-} returns the modified function.
}
\references{\url{http://www.omegahat.org/OptionalTyping}}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{checkArgs}}
  \code{\link{checkReturnValue}}  
}

\keyword{programming}
\keyword{interface}
