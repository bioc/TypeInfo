print.InheritsTypeTest =
function(x, ...) {
  
  tmp = paste("[InheritsTypeTest] ", "is( , c(",
         paste("'", as.character(x), "'", sep = "", collapse = ", "),
         "))", collapse = "", sep = "")

  print(tmp)
}


print.StrictIsTypeTest =
function(x, ...) {
  tmp = paste("[StrictIsTypeTest] ", "class( ) %in% c(",
         paste("'", as.character(x), "'", sep = "", collapse = ", "),
         "))", collapse = "", sep = "")


  print(tmp)
}

