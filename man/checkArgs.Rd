\name{checkArgs}
\docType{methods}
\alias{checkArgs}
\alias{checkArgs-methods}
\alias{checkArgs,missing-method}
\alias{checkArgs,function-method}
\alias{checkArgs,IndependentTypeSpecification-method}
\alias{checkArgs,SimultaneousTypeSpecification-method}
\alias{checkArgs,InheritsTypeTest-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Validate the arguments in a call to a typed function.}
\description{
  This function is used to validate the arguments in a call
  to a function that has associated type information about the
  parameters.  The types for the parameters are currently
  given associated with the function via  an attribute
  \code{"ParameterTypes"}. In the body of the function,
  one can call \code{checkArgs} and the specification is
  taken and used to compute whether the elements in the call
  are compatible with those in the signatures.

  There are currently several ways to specify the signatures.
  One is as a list of  explicit parameter name - class
  name pair vectors given as
  \code{c(paramName = className, paramName = className, ...)}.
  Alternatively, one can use an expression to perform a dynamic test.
  For example, one can test the length of an object, e.g.
  \code{c(x = length(x) < 4, y = length(y) == length(x))}.
  Each expression should return a logical value indicating whether
  the expected condition was satisfied.
  A third form of specifying signatures is given using class names
  for individual parameters and just matching the argument
  class to these names. This differs from the first form
  because the arguments are not checked simultaneoulsy, but
  rather one at a time. The test for a given argument is
  whether it is in the named vector of classes.

}
\usage{
checkArgs(f = sys.function(1), argNames, args = NULL, forceAll = FALSE,
          env = sys.frame(1), isMissing = logical(0))
}
\arguments{
  \item{f}{the function object. If this is missing, the function is
    taken as the function being called in the previous frame, i.e. the
    one that called \code{checkArgs}.
   }
   \item{argNames}{a character vector giving the names of the arguments
     that are to be checked.}
  \item{args}{a list of named argument values.}
  \item{forceAll}{a logical value. If this is \code{TRUE}, then we
    evaluate all of the arguments in the call frame of the function
    being evaluated whose arguments we are to check. If this is
    \code{FALSE},
    This should be a three-level enum to represent
     evaluate as needed, evaluate all referenced in any of the
     signatures and evaluate all of the arguments now.
   }
   \item{env}{the environment in which arguments are located.}
}
\details{

}
\value{
  If the check succeeds in matching the arguments to the parameter types,
  the signature that matched is returned.
  Otherwise, an error is raised.
  If the signature is returned, this can be used to validate the
  return value in the context of that signature.

  Note that if an instance of
  \code{\link{SimultaneousTypeSpecification-class}}
  is provided to this function, the \code{\link{TypedSignature-class}}
  elements are searched sequentially until a matching one is found.
  That matching signature is returned.  Therefore, the order the
  signatures are specified within the
  \code{\link{SimultaneousTypeSpecification-class}} object is
  important. This could change if we wanted. At present, it is up to the author to specify
  what they want to have happen. We could use the S4 signature
  matching technique when this is finalized and implemented in C code.
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{This is intended to be a prototype.
  We need to define methods or dispatch differently at least for
  different types of signature specification, i.e. the simultaneous
  constraints and the independent constraint.
}

\seealso{
 \code{\link{typeInfo}}
}
\examples{




 bob = function(x, y) {
         checkArgs()  # Completely unecessary as we don't specify type information.
         "Finished"
       }

  # a call generates a warning to say that there was no type information.
 bob()  

}
\keyword{programming}
\keyword{interface}
