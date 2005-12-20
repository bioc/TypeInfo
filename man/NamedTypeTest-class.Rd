\name{NamedTypeTest-class}
\docType{class}
\alias{NamedTypeTest-class}
\alias{InheritsTypeTest-class}
\alias{StrictIsTypeTest-class}
\alias{coerce,character,NamedTypeTest-method}
\alias{InheritsTypeTest}
\alias{StrictIsTypeTest}

\title{Class "NamedTypeTest" and sub-classes for tests on class of an object. }
\description{
  These classes are for specifying a test on the type of an object
  using the class of that object and comparing it to target class
  names.  The tests can be either for
  \code{x inherits from class name} (or \code{is(x, "className")})
  or \code{x is an instance of class name} (i.e. \code{class(x) ==
    "className"}).
  The first of these is represented by \code{InheritsTypeTest}
  and the second by \code{StrictTypeTest}.
}
\section{Objects from the NamedTypeTest class}{
 Objects can be created for the non-virtual classes
 using \code{new("InheritsTypeTest",...)}
 and \code{new("StrictIsTypeTest",...)} or the convenience functions
 \code{InheritsTypeTest(...)}, \code{StrictIsTypeTest(...)}
 Additionally,  where appropriate,
 a character vector is coerced  to \code{InheritsTypeTest}.
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{Object of class \code{"character"}.
      This is an internal data type to represent the class names.
      It is not to be used directly. It is inherited from the
      \dQuote{character} class.
     }
  }
}
\section{Extends}{
Class \code{"character"}, from data part.
Class \code{"ClassNameOrExpression"}, directly.
Class \code{"vector"}, by class \code{"character"}.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "character", to =
	"NamedTypeTest")}: 
       converts a character vector into a \code{InheritsTypeTest}.}
  }
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{}


\seealso{
  \code{\link{TypedSignature}}
  \code{\link{TypeSpecification-class}}  
}
\examples{
  new("InheritsTypeTest",  c("A", "B"))

  m = array(1:60, c(3, 4, 5))
  tt = new("StrictIsTypeTest",  c("matrix"))
  TypeInfo:::checkType(m, tt)

  tt = new("StrictIsTypeTest",  c("array"))
  TypeInfo:::checkType(m, tt)
}
\keyword{classes}
