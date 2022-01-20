
#' Filtra sindicatos activos
#'
#'
#'
#'
#' @return Una tibble con listado de sindicatos activos
#'
#' @export
#'
#' @examples
#' sindicatos_activos()
#'

sindicatos_activos <- function(){
  dplyr::select(sindicatos[sindicatos$estado=="ACTIVO",],-estado,-direccion,-nombre_oficina)
}


#' Filtra sindicatos activos y de empresa o establecimiento
#'
#'
#'
#'
#' @return Una tibble con listado de sindicatos activos y de empresa
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

