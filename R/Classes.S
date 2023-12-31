# This is a class to represent a test of
#    is(x, ?) i.e. is compatible with
# or
#    class(x) == ?, i.e. strict "is"
# We can support multiple names, i.e. character vectors of length > 1.

setClass("NamedTypeTest", contains = c("character"))# , "VIRTUAL"))

# These are the two sub-classes that give the different flavors of the tests.
# i.e. class(x) %in% classes. or is(x, classes)
#
#XXX Should the prototype be character(0) (the default) or NA.
setClass("InheritsTypeTest", contains = "NamedTypeTest", prototype = as.character(NA))
setClass("StrictIsTypeTest", contains = "NamedTypeTest", prototype = as.character(NA))

setClassUnion("DynamicTypeTest", c("call", "expression"))

InheritsTypeTest = function(class) new("InheritsTypeTest", class)
StrictIsTypeTest = function(class) new("StrictIsTypeTest", class)

# An object that can be used to perform a test about an object.
setClassUnion("ClassNameOrExpression",
                c("NamedTypeTest", "DynamicTypeTest"))



#  An object for representing type information about a function
#  It has a slot for specifying  the return type as a character vector.
setClass("TypeSpecification",
          representation(returnType = "ClassNameOrExpression"),
          prototype = list(returnType = new("InheritsTypeTest")),
          contains = "VIRTUAL")

setMethod("initialize", "TypeSpecification",
          function( .Object, ..., returnType ) {
              if (!missing(...))
                  .Object@.Data = lapply(..., maybeInheritsTypeTest)
              if (!missing( returnType ))
                  .Object@returnType = maybeInheritsTypeTest( returnType )
              .Object
          })

# This represents information about the expected/desired/required
# types of the specified arguments in a call. It is a list
# with elements for different arguments. The elements must be
# named to identify the corresponding parameter.
# The type each element is a ClassNameOrExpression.
setClass("TypedSignature",
#            representation(
#                           ,returnType = "ClassNameOrExpression"
#                          ),
            contains = c("TypeSpecification", "list"),
            prototype = prototype(returnType = new("InheritsTypeTest")))


setAs("character", "NamedTypeTest",
       function(from) new( "InheritsTypeTest", from ))


# A constructor function for the class TypedSignature.
TypedSignature =
function(..., returnType, obj = new("TypedSignature", list(...)))
{
  if(!missing(obj))
     obj@.Data = list(...)

  if(length(obj) != 0 && any(is.null(names(obj))))
     stop("all TypedSignature elements must be named")

  if(!missing(returnType))
    obj@returnType = maybeInheritsTypeTest( returnType )

  obj
}


if(FALSE) {
TypeSpecification =
function(..., returnType, .obj)
{
  if(!missing(obj))
     .obj@.Data = list(...)

  if(!missing(returnType))
    .obj@returnType = ReturnTypeSpecification( returnType )

  .obj
}
}

# Should be listOf TypedSignature.
setClass("SimultaneousTypeSpecification",
           contains = c("list", "TypeSpecification"))

SimultaneousTypeSpecification =
function(..., returnType, obj = new("SimultaneousTypeSpecification", list(...)))
{
  if(!missing(obj))
     obj@.Data = list(...)

  if(!missing(returnType))
    obj@returnType = maybeInheritsTypeTest( returnType )

  obj
}    

# This is for a collection of classes for a single parameter
# where we will take an object compatible with any of these
# classes
# setClass("ParameterTypes", contains = "character")

# List of character vectors or expressions
setClass("IndependentTypeSpecification",
           contains=c("list", "TypeSpecification"))


IndependentTypeSpecification =
function(..., returnType, obj = new("IndependentTypeSpecification", list(...)))
{
  if(!missing(obj)) 
     obj@.Data = list(...)

  if(length(obj) != 0 && any(is.null(names(obj))))
     stop("all IndependentTypeSpecification elements must be named")
  
  obj@.Data = lapply(obj,
    function(el) { if(is.character(el) && !is(el, "NamedTypeTest")) as(el, "InheritsTypeTest") else el})

  if(!missing(returnType))
    obj@returnType = maybeInheritsTypeTest( returnType )

  obj
}


maybeInheritsTypeTest =
function( type ) {
  if(is.character(type) && !is(type, "NamedTypeTest"))
    type = new("InheritsTypeTest", type)
  type
}

setClass("ReturnTypeSpecification",
          contains = c("TypeSpecification"))  # no need for list.

ReturnTypeSpecification =
function(type, obj = new("ReturnTypeSpecification"))
{
  obj@returnType = maybeInheritsTypeTest( type )
  obj
}  


