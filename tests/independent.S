f =
function(x, y, z)
{
  x + y
}

typeInfo(f) <-
  IndependentTypeSpecification(x = c("integer", "numeric", "matrix"),
                               y = c("integer", "matrix"))


# f(1, 3) fails
# f(1, as.integer(3)) okay
