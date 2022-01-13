
#' Cuenta los sindicatos en constitución o activos en cada periodo
#'
#'
#'
#'
#'
#'
#' @export
#'
#' @examples
#'
#' activos_en(ano=1990,mes=1)
#'


activos_en <- function(ano=2021,mes=6){

  fecha<-data.frame(i=1:length(c(rep(1920:2021,each=12))),
                    ano=c(rep(1920:2021,each=12)),
                    mes=c(rep(1:12,(2021-1920+1))))

  marca <- fecha[fecha$ano==ano&fecha$mes==mes,1]

  ano<-as.character(fecha[marca,2])
  mes<-as.character(fecha[marca,3])
  dias<-as.character(lubridate::days_in_month(paste0(ano,"-",mes,"-","01")))

  aux <- dplyr::filter(sindicatos, (estado=="ACTIVO" & lubridate::ymd(paste0(ano,"-",mes,"-",dias))>=lubridate::ymd(fecha_constitucion) )  |
                         estado!="ACTIVO" & (lubridate::ymd(paste0(ano,"-",mes,"-","01"))<=fecha_ultima_directiva) &
                         lubridate::ymd(paste0(ano,"-",mes,"-",dias))>=lubridate::ymd(fecha_constitucion) )

  aux

}


