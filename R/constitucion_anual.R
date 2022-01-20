
#' Cuenta los sindicatos que se constituyeron cada año
#'
#'
#'
#' @return Una tibble con el número de sindicatos y afiliados a sindicatos
#' que se constituyeron cada año
#'
#' @export
#'
#' @examples
#' constitucion_anual()
#'

constitucion_anual <- function(){
 anual <- dplyr::summarise(dplyr::group_by(
  dplyr::mutate(sindicatos,ano=lubridate::year(fecha_constitucion)),
 ano
  ),
 sindicatos=dplyr::n(),
 afiliads=sum(total_socis))
 dplyr::arrange(anual,-ano)
}

