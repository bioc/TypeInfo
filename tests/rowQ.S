rowQ =  orig =
function (imat, which)
{
    if (inherits(imat, "ExpressionSet"))
        imat = exprs(imat)
    if (any(is.na(imat)))
        stop("cannot handle missing values  -- yet")
    if (!is.finite(which) || length(which) != 1 || !is.numeric(which))
        stop("which must be length one, and numeric")
    .Call("rowQ", imat, which, PACKAGE = "Biobase")
}


tt = SimultaneousTypeSpecification(
         TypedSignature(
            imat = "fixME" ,
            which = "fixME"
        ),
        returnType = "fixME")
typeInfo(rowQ) <- tt



