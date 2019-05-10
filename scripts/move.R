# from: https://stackoverflow.com/questions/52096919/move-a-column-conveniently/52096938#52096938

move <- function(data, cols, ref, side = c("before","after")){
  if(! requireNamespace("dplyr")) 
    stop("Make sure package 'dplyr' is installed to use function 'move'")
  side <- match.arg(side)
  cols <- rlang::enquo(cols)
  ref  <- rlang::enquo(ref)
  if(side == "before") 
    dplyr::select(data,1:!!ref,-!!ref,-!!cols,!!cols,dplyr::everything()) 
  else
    dplyr::select(data,1:!!ref,-!!cols,!!cols,dplyr::everything())
}