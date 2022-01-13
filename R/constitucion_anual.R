
#' Cuenta los sindicatos en constitución o activos en cada periodo (año o mes)
#'
#'
#'
#'
#'
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

