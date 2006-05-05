library(Biobase)
library(TypeInfo)
typeInfo( copyEnv ) <-
     SimultaneousTypeSpecification(
         TypedSignature(
            oldEnv = "environment" ,
            newEnv = "environment" ,
            all.names = "logical"
        ),
        returnType = "vector")
