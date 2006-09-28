\name{TypeSpecification-class}
\docType{class}
\alias{TypeSpecification-class}
\alias{IndependentTypeSpecification-class}
\alias{SimultaneousTypeSpecification-class}
\alias{ReturnTypeSpecification-class}
\alias{initialize,TypeSpecification-method}

\alias{initialize,TypeSpecifcation-method}

\title{Class "TypeSpecification" and derived class}
\description{
  The classes in this  collection are used to represent
  type information about a function in different ways.
  \code{TypeSpecification}   is the virtual base class
  and provides the common slot to describe the type
  for the return value of the function.

  The \code{\link{ReturnTypeSpecification-class}} is used
  when there is no information about the parameters
  of the function (either because there are no parameters
  or because we have no constraints on them).
  
  The classes \code{\link{IndependentTypeSpecification-class}} and
  \code{\link{SimultaneousTypeSpecification-class}} are used to describe
  constraints on the arguments to the function. Both are lists, but behave
  very differently in the type checking. The difference is more
  difficult to describe succinctly than it is conceptually.
  

  \code{\link{SimultaneousTypeSpecification-class}} is used when we want to
  specify information about the types of several
  arguments in  a call taken as a group and
  imposing a constraint on that group of values.
  This corresponds to a call signature in the method dispatching.
  It says match each argument in turn with the given types
  and confirm the match over all of these tests.
  For example, we might have a function that
  accepts either (a) two numbers, or (b) two matrices.
  In that case, we need to specify the acceptable argument types
  as pairs:  c("numeric", "numeric") and
  c("matrix", "matrix").
  The key idea here is that the constraints on the types are
  AND-ed together across the different arguments.
  In our example, we impose the constraint
  \code{is.numeric(arg1) && is.numeric(arg2)}.
  
 
  The \code{\link{IndependentTypeSpecification-class}} is used
  when we want to specify something about the types of different parameters
  but do not want the types to be AND-ed together.
  If we had a function that accepts a matrix or a number for its
  first parameter, and a matrix or string for its second parameter
  or any combination of those, then we would use the
  \code{\link{IndependentTypeSpecification-class}}.
  The term 'independent' is intended to suggest that the
  type checking is done for each parameter separately
  or independently of the others and then the check succeeds if all
  arguments pass.
  The phrase simultaneous means that we test the types of the arguments
  as a unit or simultaneously.
  The names can be easily changed to something more suggestive.
  It is the concept that is important.


  A description of a quite different nature may also help and also
  provide information about the contents of these different list
  classes.  For \code{\link{IndependentTypeSpecification-class}}, one can think of
  the list as having an element for each parameter for which we want to
  specify type information. This element is, at its simplest, a
  character vector giving the names of the acceptable classes.
  (We can have more complex elements such as expressions.)
  I think of this as being a collection of column vectors hanging from
  the parameters.
  
  For \code{\link{SimultaneousTypeSpecification-class}}, we have rows or tuples of
  type information.  These are call signatures.
  So we have   

  \code{IndependentTypeSpecification} corresponds to the
  \code{SimultaneousTypeSpecification} in the following computational
  manner. We can take the cartesian product (e.g. via
  \code{\link[base]{expand.grid}}) of the inputs for
  \code{IndependentTypeSpecification} to form all possible combinations
  of types for the parameters and then we have the
  tuples for the corresponding \code{SimultaneousTypeSpecification}.
}
\section{Constructors}{
 One can create objects of the three non-virtual classes using the
 corresponding constructor functions in the package.  These are
 \code{\link{ReturnTypeSpecification}},
 \code{\link{IndependentTypeSpecification}},
 \code{\link{SimultaneousTypeSpecification}}.
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{each of the non-virtual classes is really
      a list. They inherit the list properties and all the relevant
      methods.  This slot is implementation specific and should not be used.  }
    \item{\code{returnType}:}{Object of class
      \code{\link{ClassNameOrExpression-class}}.
      This describes the return type for the function.
      In \code{SimultaneousTypeDescription} objects, we can also
      specify return type information corresponding to each
      signature, i.e.  in the \code{\link{TypedSignature-class}}.
    }
  }
}
\section{Extends}{
Class \code{"list"}, from data part.
Class \code{"TypeSpecification"}, directly.
Class \code{"vector"}, by class \code{"list"}.
}
\section{Methods}{
  Available methods are computed in the example below; see the
  corresponding help page for details.
}
\references{}
\author{Duncan Temple Lang <duncan@wald.ucdavis.edu>}
\note{}

\seealso{
  \code{\link{IndependentTypeSpecification}}
  \code{\link{SimultaneousTypeSpecification}}
  \code{\link{ReturnTypeSpecification}}
  \code{\link{typeInfo}},   \code{\link{typeInfo<-}}
  \code{\link{checkArgs}}, \code{\link{checkReturnValue}}
}
\examples{
showMethods(classes=c(
              "TypeSpecification",
              "IndependentTypeSpecification",
              "SimultaneousTypeSpecification",
              "ReturnTypeSpecification"))
}
\keyword{classes}
