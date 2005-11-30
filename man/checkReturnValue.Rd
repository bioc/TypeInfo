\name{checkReturnValue}
\alias{checkReturnValue}
\title{Verify the return value from the function has the appropriate type}
\description{
  This function is the counterpart to \code{\link{checkArgs}}
  in the type validation for an R function.
  When called, either implicitly or explicitly when the function
  returns, it attempts to determine whether the value being
  returned by the function call is valid relative
  to the type information of the function and the call itself.
  Specifically, it uses the signature of the current call to the
  function if it is available (returned by \code{\link{checkArgs}})
  to see if it has a specified return type. If so,
  it compares the return value to that.
  Otherwise, it checks to see if the return type for the
  overall type info object (not just the specific type signature
  for the call) is specified and then uses that to validate the
  type. If neither is specified, then the value is not validated
  and the value returned.
}
\usage{
checkReturnValue(value, returnJump, sig, f = sys.function(1))
}
\arguments{
  \item{value}{the value to be returned that is to be validated.}
  \item{returnJump}{this is a very special value which is a call to
    return the value of \code{value}. It must be explicitly given
    in the call to \code{checkReturnValue} and is used
    to ensure that the return from \code{checkReturnValue}
    returns from the calling function also in the case
    that the value is valid. This is a piece of magic in R
    that is very powerful using the lazy evaluation of the
    arguments that allows us to return from the place that the
    \code{return} call was specified.
  }
  \item{sig}{the signature corresponding to the call of the function
    \code{f}. This should have a \code{returnType} slot
    that contains class information or an expression. Otherwise,
    the value is taken from the \code{\link{TypeSpecification-class}}
    object for the entire function and its \code{returnType} slot.
  }
  \item{f}{the function object whose return value is to be validated.
      It is from this that we get the type info via \code{\link{typeInfo}}.}
  }
\details{
}  
\value{
  If the validation takes place and is successful
  or simply doesn't take place because no \code{returnType} is
  available, the return value is \code{value}.
  Otherwise, if the validation fails, an error is raised.
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{This is a prototype to illustrate the idea.
  It might be done in C code in the future within the R
  interpreter.
}

\seealso{
  \code{\link{checkArgs}}
  \code{\link{TypeSpecification-class}}  
}
\examples{
}
\keyword{programming}
\keyword{interface}
