# library(Biobase)
Aggregate =
function (x, agg) 
{
    if (!is(agg, "aggregator")) 
        stop("second argument must be an aggregator")
    if (is.null(x) || length(x) == 0) 
        return()
    if (is.character(x)) {
        for (i in 1:length(x)) {
            nm <- x[i]
            if (!exists(nm, env = aggenv(agg), inherits = FALSE)) 
                assign(nm, env = aggenv(agg), initfun(agg)(nm, 
                  x))
            else {
                v1 <- get(nm, env = aggenv(agg))
                assign(nm, aggfun(agg)(nm, v1), env = aggenv(agg))
            }
        }
    }
    else if (is.list(x)) {
        nms <- names(x)
        for (i in 1:length(x)) {
            nm <- nms[i]
            if (!exists(nm, env = aggenv(agg), inherits = FALSE)) 
                assign(nm, env = aggenv(agg), initfun(agg)(nm, 
                  x[[i]]))
            else {
                v1 <- get(nm, env = aggenv(agg))
                assign(nm, env = aggenv(agg), aggfun(agg)(nm, 
                  v1, x[[i]]))
            }
        }
    }
    else stop("bad type for Aggregate")
}

typeInfo(Aggregate) <-
     SimultaneousTypeSpecification(
         TypedSignature(
            x = "ANY" ,
            agg = "aggregate"
        ),
        returnType = "NULL")
