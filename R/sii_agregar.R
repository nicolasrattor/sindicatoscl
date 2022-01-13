
#' Agrega información del Servicio de impuestos internos
#'
#' Se filtra la data a los sindicatos activos y de empresa o establecimiento.
#' Luego se agregan variables del Servicio de Impuestos Internos relacionadas a
#' ventas, número de trabajadores y actividad económica.
#'
#'
#'
#' @export
#'
#' @examples
#'
#' datos <- sii_agregar()
#' table(datos$rubro_sii,useNA="ifany")
#' table(datos$ventas_sii,useNA="ifany")
#' nrow(datos[datos$tasa_sindicalizacion<=1&!is.na(datos$tasa_sindicalizacion),])
#' summary(datos[datos$tasa_sindicalizacion<=1,]$tasa_sindicalizacion)


sii_agregar <- function(){

  aux <- merge(sindicatoscl::sindicatos_activos_empresas(),sii,by="rut_empresa",all.x = TRUE)
  #nrow(aux[aux$nt_sii>0&!is.na(aux$nt_sii),])
  aux$tasa_sindicalizacion <- aux$total_socis/aux$nt_sii
  dplyr::arrange(dplyr::select(aux,nombre,rut_empresa,total_socis,
                               nt_sii,tasa_sindicalizacion,rubro_sii,ventas_sii),
                 -nt_sii)


}


