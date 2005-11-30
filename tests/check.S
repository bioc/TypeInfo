f = 
function(x, y = 2, z = 3)
{
  checkArgs()

  x + y + z
}  

typeInfo(f) =
  IndependentTypeSpecification(x = "numeric",
                               y = "numeric",
                               z = "numeric")
