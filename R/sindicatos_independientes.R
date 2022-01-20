
#' Filtra sindicatos según independientes
#'
#'
#'
#'
#' @return Filtra sindicatos dejando solo a los de empresas independientes
#'
#' @export
#'
#' @examples
#' sindicatos_activos()
#' sindicatos_empresas()
#'

sindicatos_independientes <- function(){
  dplyr::select(sindicatos[sindicatos$tipo %in%
                             c("SINDICATO INDEPENDIENTE"),],-tipo,-direccion,-nombre_oficina)
}
