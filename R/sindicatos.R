#' Sindicatos
#'
#' Registro administrativo de sindicatos activos y en receso en Chile (1920-2021).
#'
#' Cada fila es un sindicato.
#'
#' El registro es de la Dirección del Trabajo, la institución que principalmente
#' produce y centraliza los datos sobre sindicatos en Chile,
#' al ser el lugar en donde los sindicatos deben registrarse para constituirse como tales,
#' además de entregar información sobre sus elecciones internas y
#' contratos colectivos para mantener su estado de activos.
#'
#' Los datos del registro abarcan a  todas las organizaciones sindicales en Chile y
#' son los que, una vez depurados, la institución utiliza para publicar
#' en sus Compendios y Anuarios las tasas de sindicalización oficiales y
#' otros datos sobre sindicatos.
#' Sin embargo, en este proceso la organización demora aproximadamente dos años,
#' no quedando a disposición de la ciudadanía el microdato con los que elabora
#' sus informes. El registro no solo permite calcular el dato
#' actualizado a la fecha de descarga de los sindicatos activos en Chile,
#' logrando un monitoreo en tiempo real de una parte de las relaciones laborales
#' en el país; sino que también permite tener obtener los datos de sindicatos activos
#' para antes del año 1990, cuestión que ningún compendio o anuario de la
#' Dirección del Trabajo registra.
#'
#' Sobre la calidad del dato de trabajadores/as afiliados:
#' este no es del todo exacto, ya que el número de afiliados es el registrado
#' por la Dirección del Trabajo en el último trámite realizado por el sindicato.
#' Por tanto, si un sindicato en 2015 tiene 5000 socios, esos 5000 socios
#' corresponden al último periodo registrado por la DT para ese sindicato,
#' probablemente 2017-2020 en ese caso. Para cada periodo o tiempo t hay una sub o
#' sobreestimación en el número de afiliados/as de cada sindicato.
#' Por ende, es necesario tomar este dato como un proxy,
#' cuyo ajuste con la realidad es probable que disminuya mientras más nos alejamos
#' de la fecha en la que es descargada la base de datos.
#'
#' @format Una data frame con variables:
#' \describe{
#' \item{rsu_raf}{Identificador del sindicato}
#' \item{nombre}{Nombre del sindicato}
#' \item{rut_empresa}{Rut de la empresa}
#' \item{empresa}{Nombre de la empresa}
#' \item{estado}{Estado del sindicato: ACTIVO, RECESO, DISUELTO, CADUCADO O ELIMINADO}
#' \item{tipo}{Tipo de sindicato: SINDICATO EMPRESA, SINDICATO ESTABLECIMIENTO,
#' SINDICATO INDEPENDIENTE, SINDICATO INTER EMPRESA o SINDICATO TRANSITORIO}
#' \item{direccion}{Dirección a la que se asocia el sindicato. Suele ser la de la casa matriz de la empresa}
#' \item{region}{Región de la dirección a la que se asocia el sindicato. Suele ser la de la casa matriz de la empresa}
#' \item{socios}{Número de socios de sindicato registrados en último trámite}
#' \item{socias}{Número de socias de sindicato registradas en último trámite}
#' \item{total_socis}{Número de socios y socias de sindicato registrados en último trámite}
#' \item{fecha_constitucion}{Fecha de constitución del sindicato}
#' \item{fecha_ultima_directiva}{Fecha de elección de directiva. Se usa como proxy de último trámite}
#' \item{nombre_oficina}{Nombre oficina de Inspección del Trabajo en que se hizo el trámite}
#' \item{cae}{Clasificador de Actividad Económica}
#' }
#'
#' @source \url{https://tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx}
#' @examples
#'
"sindicatos"
