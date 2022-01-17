
#' Afiliados según tipo de sindicato
#'
#' Imprime el número de afiliados/as a sindicatos según tipo de sindicato desde 1990
#' hasta 2020.
#'
#'
#' @export
#'
#' @examples
#' afiliados_tipo()
#'

afiliados_tipo <- function(){

  fecha <- c(1990:(lubridate::year(lubridate::today())-1))

  afiliados_tipo<-data.frame(1:length(fecha),
                             1:length(fecha),
                             1:length(fecha),
                             1:length(fecha),
                             1:length(fecha))

  for(i in 1:length(fecha)){

  aux <- dplyr::summarise(dplyr::group_by(activos_en(ano=fecha[i],mes=11),tipo),
                   total_socis=sum(total_socis))

  afiliados_tipo[i,] <- aux$total_socis

  }

  names(afiliados_tipo)<-c("SINDICATO EMPRESA","SINDICATO ESTABLECIMIENTO",
                           "SINDICATO INDEPENDIENTE","SINDICATO INTER EMPRESA",
                           "SINDICATO TRANSITORIO")

  afiliados_tipo$ano <- fecha

  afiliados_tipo$sindicatos <- afiliados_tipo$`SINDICATO EMPRESA`+
    afiliados_tipo$`SINDICATO ESTABLECIMIENTO` + afiliados_tipo$`SINDICATO INDEPENDIENTE` +
    afiliados_tipo$`SINDICATO INTER EMPRESA` + afiliados_tipo$`SINDICATO TRANSITORIO`

  afiliados_tipo$sindicatos_sin_indep <- afiliados_tipo$`SINDICATO EMPRESA`+
    afiliados_tipo$`SINDICATO ESTABLECIMIENTO` +
    afiliados_tipo$`SINDICATO INTER EMPRESA` + afiliados_tipo$`SINDICATO TRANSITORIO`

  afiliados_tipo

}



#' Tasa de afiliación sindical según tres metodologías de la Dirección del Trabajo
#'
#' dt = imprime las tasas oficiales de la DT publicada en compendios
#' res = imprime las tasas según metodología DT pero con datos de sindicatoscl
#'
#' metodologia1 = Población Afiliada / Total de ocupados*100
#' metodologia2 = Población Afiliada / Total de ocupados (excluye asalariados s.público)*100
#' metodologia3 = Población Afiliada (excluye afiliados independientes) / Total de ocupados
#' (excluye asalariados s.público)*100
#'
#'
#' @param metodo puede "res2 o "dt"
#'
#' @export
#'
#' @examples
#' tasa_sindicalizacion()
#'

tasa_sindicalizacion <- function(metodo="res"){

  if(metodo=="res"){

    afiliados_tipo <- afiliados_tipo()
    afiliados_tipo <- merge(ene,afiliados_tipo,by="ano",all.x = TRUE)

    afiliados_tipo$tasa1  <- afiliados_tipo$sindicatos / afiliados_tipo$ft_ocupada1

    afiliados_tipo$tasa2  <- afiliados_tipo$sindicatos / afiliados_tipo$ft_ocupada2

    afiliados_tipo$tasa3  <- afiliados_tipo$sindicatos_sin_indep / afiliados_tipo$ft_ocupada3
    afiliados_tipo[,c("ano","tasa1","tasa2","tasa3")]

  } else if(metodo=="dt"){

    oficial <- data.frame(

    ano=c(
    1990	,
    1991	,
    1992	,
    1993	,
    1994	,
    1995	,
    1996	,
    1997	,
    1998	,
    1999	,
    2000	,
    2001	,
    2002	,
    2003	,
    2004	,
    2005	,
    2006	,
    2007	,
    2008	,
    2009	,
    2010	,
    2011	,
    2012	,
    2013	,
    2014	,
    2015	,
    2016	,
    2017	,
    2018	,
    2019),

    tasa_sind1=c(
    13.4	,
    15.1	,
    14.8	,
    13.4	,
    12.9	,
    12.3	,
    NA		,
    11.5	,
    11.3	,
    10.7	,
    11.1	,
    10.9	,
    11.2	,
    11.8	,
    11.6	,
    11.5	,
    11	  ,
    11	  ,
    11.9	,
    12.5	,
    11.7	,
    11.8	,
    12.2	,
    11.9	,
    12.3	,
    12.9	,
    13.9	,
    14	  ,
    14	  ,
    13.1),

    tasa_sind2=c(
    16.2      	,
    18.2      	,
    17.9      	,
    16	        ,
    15.4      	,
    14.6      	,
    NA          ,
    13.3      	,
    13.1      	,
    12.7      	,
    13.2      	,
    12.9      	,
    13.1      	,
    13.8      	,
    13.7      	,
    13.4      	,
    12.8      	,
    12.9      	,
    13.9      	,
    14.6      	,
    13.9      	,
    14.1      	,
    14.6      	,
    14.2      	,
    14.7      	,
    15.4      	,
    16.5      	,
    17	        ,
    17   	      ,
    15.9),

    tasa_sind3=c(
    19.2,
    21.2,
    20.7,
    18.6,
    18,
    16.7,
    NA,
    15,
    15,
    14.5,
    14.8,
    14.6,
    14.8,
    15.6,
    15.6,
    15.1,
    14.5,
    14.8,
    16.1,
    17.3,
    15.8,
    15.7,
    16.6,
    16.4,
    17,
    17.9,
    19.6,
    20.5,
    20.6,
    18.9)

    )

    oficial

  } else{
    "introduce método correcto: res o dt"
  }

}

