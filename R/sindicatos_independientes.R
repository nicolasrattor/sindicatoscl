
#' Filtrar sindicatos según agrupaciones relevantes
#'
#'
#'
#'
#'
#'
#'
#' @examples
#' sindicatos_activos()
#' sindicatos_empresas()
#'

sindicatos_independientes <- function(){
  dplyr::select(sindicatos[sindicatos$tipo %in%
                             c("SINDICATO INDEPENDIENTE"),],-tipo,-direccion,-nombre_oficina)
}
