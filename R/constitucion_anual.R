
#' Cuenta los sindicatos en constitución o activos en cada periodo (año o mes)
#'
#'
#'
#'
#'
#'
#'
#' @examples
#' constitucion_anual()
#' activos_historico(desde=2020,hasta=2021)
#' activos_en(ano=1990,mes=1)
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

