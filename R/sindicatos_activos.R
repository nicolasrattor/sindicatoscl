
#' Filtrar sindicatos según agrupaciones relevantes
#'
#'
#'
#'
#'
#'
#' @export
#'
#' @examples
#' sindicatos_activos()
#'

sindicatos_activos <- function(){
  dplyr::select(sindicatos[sindicatos$estado=="ACTIVO",],-estado,-direccion,-nombre_oficina)
}


#' Filtrar sindicatos según agrupaciones relevantes
#'
#'
#'
#'
#'
#'
#' @export
#'
#' @examples
#' sindicatos_activos_empresas()
#'

sindicatos_activos_empresas <- function(){
  dplyr::select(sindicatos[sindicatos$estado=="ACTIVO"&
                             sindicatos$tipo %in%
                             c("SINDICATO EMPRESA","SINDICATO ESTABLECIMIENTO"),],
                -estado,-direccion,-nombre_oficina)
}

