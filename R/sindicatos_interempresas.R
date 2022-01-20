
#' Filtra sindicatos dejando solo a los interempresa
#'
#'
#'
#' @return Una tibble
#'
#'
#' @export
#'
#' @examples
#' sindicatos_activos()
#' sindicatos_empresas()
#'

sindicatos_interempresas <- function(){
  dplyr::select(sindicatos[sindicatos$tipo %in%
                             c("SINDICATO INTER EMPRESA"),],-tipo,-direccion,-nombre_oficina)
}


