\name{TypedSignature-class}
\docType{class}
\alias{TypedSignature-class}
\alias{hasParameterType,TypedSignature-method}
\alias{hasReturnType,TypedSignature-method}

\title{Class "TypedSignature" representing type information about
  function parameters and the return type}
\description{

  This class is used to describe an AND or simultaneous condition on the
  types of several arguments of a function call.  The entire test is
  satisfied if all the individual elements are satisfied.  One can
  represent the test elements for the different parameters as either
  class names (i.e. character strings or
  \code{\link{NamedTypeTest-class}} and sub-classes), and also predicate
  expressions using \code{DynamicTypeTest}.

  In addition to the types on the parameters, one can also specify
  a test for the return type if a call to the function matches this
  signature.
  This allows us to associate a specific return type with a specific
  set of input types.

  Currently this class is only used to describe the elements in
  \code{\link{SimultaneousTypeSpecification-class}} objects.
}
\section{Objects from the Class}{
  Use the constructor function \code{\link{TypedSignature}}
  to create objects of this class.
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{This object extends list. But this slot is
      intended to be opaque and should not be used directly.
    }
    \item{\code{returnType}:}{Object of class
      \code{"ClassNameOrExpression"}.
      This represents the description of the return type of the
     function associated with this set of  given input types.}
  }
}
\section{Extends}{
Class \code{"list"}, from data part.
Class \code{"vector"}, by class \code{"list"}.
}
\section{Methods}{
  \describe{
    \item{hasParameterType}{\code{signature(def = "TypedSignature")}:  }
    \item{hasReturnType}{\code{signature(def = "TypedSignature")}:  }
  }
}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu> }

\seealso{
 \code{\link{SimultaneousTypeSpecification}}
}

\keyword{classes}
