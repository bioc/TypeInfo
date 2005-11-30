
g =
function() {

   ctr <- 1
   while(TRUE) {
     if(runif(1) > 0.5)
       return(ctr)

     ctr <- ctr + 1
   }
}

typeInfo(g) <- ReturnTypeSpecification("numeric")


gg =
function(n)
{
   ans = numeric(n)
   ctr <- 1
   while(TRUE) {
     v = runif(1)
     if(v > 0.5) {
       ans[ctr] <- v
       ctr <- ctr + 1       
       break
     }
   }
   ans 
}
