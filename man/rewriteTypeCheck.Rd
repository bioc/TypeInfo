\name{rewriteTypeCheck}
\alias{rewriteTypeCheck}
\title{Insert code to support type validation}
\description{
  This generic function and its methods are used to
  modify the expressions in the body of a function
  in order to support the validation of type
  information in calls to this function.
  This changes the form of explicit calls to \code{return},
  modifies the last expression if it is not an explicit call to return,
  and adds an initial command to compute check the arguments in the cal
  via \code{\link{checkArgs}}.
}
\usage{
rewriteTypeCheck(f, doReturn = TRUE, checkArgs = TRUE)
}

\arguments{
  \item{f}{the object which is to be modified to add the information
    for checking the return value and checking the input arguments.
    These are functions, expressions, calls, and other language objects.}
  \item{doReturn}{a logical value. If this is \code{FALSE},
    the modifications are greatly simplified and no additions are made
    to handle the validation of the return value. This is used when the
    type information provides no information about the return type
    and so it cannot be validated or constrained.}
  \item{checkArgs}{a logical value indicating whether the modifications
    should including check the arguments. If the only type information
    given is about the return type, no checking of the arguments is
    necessary (in the current model).
   }
}
\details{

}
\value{
  The potentially modified version of the original input argument.
  The modifications contain any necessary changes to
  support the type checking at run-time.
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{}

\seealso{
  \code{\link{typeInfo}}
  \code{\link{checkArgs}}
  \code{\link{checkReturnValue}}  
}
\examples{

 f = function(x, y) {
   z = x + y
   sum(z)
 }
}
\keyword{IO}
\keyword{programming}
