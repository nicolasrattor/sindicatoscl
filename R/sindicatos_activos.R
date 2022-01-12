
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

sindicatos_activos <- function(){
  dplyr::select(sindicatos[sindicatos$estado=="ACTIVO",],-estado,-direccion,-nombre_oficina)
}

