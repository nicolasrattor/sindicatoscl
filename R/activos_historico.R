
#' Cuenta los sindicatos en constitución o activos en cada periodo (año o mes)
#'
#'
#'
#'
#'
#'
#'
#' @export
#' @examples
#' activos_historico(desde=2020,hasta=2021)
#'
#'

activos_historico <- function(desde=2020,hasta=2021){

  fecha<-data.frame(ano=c(rep(desde:hasta,each=12)),
                    mes=c(rep(1:12,(hasta-desde+1))),
                    sindicatos=NA,
                    afiliads=NA)

  for(i in 1:nrow(fecha)){

    ano<-as.character(fecha[i,1])
    mes<-as.character(fecha[i,2])
    dias<- as.character(lubridate::days_in_month(paste0(ano,"-",mes,"-","01")))

    assign(
      paste0("proxy_",ano,"_",mes),
      dplyr::select(dplyr::filter(sindicatos, (estado=="ACTIVO" & lubridate::ymd(paste0(ano,"-",mes,"-",dias))>=lubridate::ymd(fecha_constitucion) )  |
                             estado!="ACTIVO" & (lubridate::ymd(paste0(ano,"-",mes,"-","01"))<=fecha_ultima_directiva) &
                             lubridate::ymd(paste0(ano,"-",mes,"-",dias))>=lubridate::ymd(fecha_constitucion) ),
             rsu_raf,total_socis
      ))

    fecha[i,3] <- nrow(get(paste0("proxy_",ano,"_",mes)))
    fecha[i,4] <- sum(dplyr::select(get(paste0("proxy_",ano,"_",mes)),total_socis))

  }

  fecha

}

