\name{ClassNameOrExpression-class}
\docType{class}
\alias{ClassNameOrExpression-class}

\title{Class "ClassNameOrExpression" to represent type information as
  either class names or arbitrary language test}

\description{

  This class is used to represent a type test that is specified either
  as a collection of class names (and whether to check for strict
  equality or inheritance) or a dynamic predicate expression that is
  evaluated at run-time to determine whether the test is satisfied.

  We may not need this in the "new" class hierarchy.  It was created
  originally to be a union of character vectors, \code{call}s or
  \code{expression}s. But now that we have \code{NamedTypeTest} and
  \code{DynamicTypeTest}, we could perhaps use a common base class.

}

\section{Objects from the Class}{

  A virtual Class: No objects may be created from it.

}

\section{Methods}{

  No methods defined with class "ClassNameOrExpression" in the
  signature.

}

\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}

\seealso{
  \code{\link{TypedSignature}}
  \code{\link{TypedSignature-class}}
  \code{\link{ReturnTypeSpecification}}
}

\keyword{classes}
