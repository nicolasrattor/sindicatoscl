
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



sindicatos_empresas <- function(){
  dplyr::select(sindicatos[sindicatos$tipo %in%
                             c("SINDICATO EMPRESA","SINDICATO ESTABLECIMIENTO"),],
                -tipo,-direccion,-nombre_oficina)
}
