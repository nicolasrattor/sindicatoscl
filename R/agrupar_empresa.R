
#' Agrupa por empresa e indica N de sindicatos activos y afiliados/as
#'
#'
#'
#'
#'
#'
#' @export
#'
#' @examples
#' empresas_sindicatos_activos()
#'

empresas_sindicatos_activos <- function(){
  empresas <- dplyr::select(sindicatos[sindicatos$tipo %in%
                             c("SINDICATO EMPRESA","SINDICATO ESTABLECIMIENTO")&
                             sindicatos$estado=="ACTIVO",],
                -tipo,-direccion,-nombre_oficina)
  dplyr::mutate(
    dplyr::filter(dplyr::arrange(dplyr::summarise(dplyr::group_by(empresas,rut_empresa),
                   sindicatos=dplyr::n(),
                   afiliads=sum(total_socis)),-sindicatos),!is.na(rut_empresa)),
  tamano_promedio=afiliads/sindicatos)
}


