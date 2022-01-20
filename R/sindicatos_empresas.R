
#' Filtrar sindicatos de empresa o establecimiento.
#'
#'
#' No distingue entre receso y activos
#'
#' @return Una tibble
#'
#' @export
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
