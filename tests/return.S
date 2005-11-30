gg =
function(x) {

  y = x + as.integer(1)

  if(y < 0)
     return(FALSE)

  y
}

typeInfo(gg) =
  ReturnTypeSpecification("integer")


ff =
function(x)
{

  y = x + as.integer(1)

  if(y < 0)
     return(FALSE)

  y
}

typeInfo(ff) =
  SimultaneousTypeSpecification(
           TypedSignature(x = quote(x < -1), returnType = "logical"),
           TypedSignature(x = quote(x >= -1), returnType = "integer")                                
                   
  )


zz =
function(x)
{

  y = x + as.integer(1)

  if(y < 0)
     return(FALSE)

  y
}

typeInfo(zz) =
  ReturnTypeSpecification(quote(ifelse(x < -1, "logical", "integer")))

 




