center <- function(x, type = c("mean", "median", "trimmed")) {
       type <- match.arg(type)
       switch(type,
              mean = mean(x),
              median = median(x),
              trimmed = mean(x, trim = .1))
     }
     x <- rcauchy(10)
     center(x, "t")



# Really want to write this as
setClass("CentralMeasure", contains = "EnumValue")

