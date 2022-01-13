#' SII
#'
#' Datos del Servicio de Impuestos Internos, consolidado de años 2018 y 2019.
#' Cada fila es una empresa, no existen duplicados.
#' El dato para cada empresa es el más actual del SII.
#'
#' Un contribuyente es clasificado como empresa,
#' cuando cumpla con uno o más de los siguientes atributos:
#' Es identificado como contribuyente de primera vategoría,
#' presenta declaración jurada 1887 y/o es declarante vigente de IVA
#'
#' @format Data frame con variables:
#' \describe{
#' \item{rut_empresa}{Rut de la empresa}
#' \item{nt_sii}{Número de trabajadores de la empresa.
#' Los trabajadores se contabilizan por empleador,
#' por lo que aquellos con más de una relación de dependencia laboral
#' en el año se cuentan en cada una de ellas.
#' El número de trabajadores se encuentra asociado a la dirección del domicilio o
#' casa Matriz de la Empresa y no necesariamente donde el trabajador presta sus
#' servicios. El número de trabajadores es el promedio mensual de la empresa}
#' \item{ventas_sii}{Ventas anuales. Las ventas anuales de un contribuyente
#' se calculan mediante un algoritmo que utiliza códigos declarados en los
#' Formularios 22 y 29, el cual podría no necesariamente representar su valor
#' económico real}
#' \item{rubro_sii}{Actividad económica de la empresa.
#' A partir del año tributario 2019, el rubro económico se determina como
#' la actividad vigente durante el año correspondiente ante el SII para aquellos
#' contribuyentes que registren una única actividad económica. En caso de poseer
#' múltiples actividades, se determina como la principal aquella declarada en la
#' consulta de actividad económica principal al momento de declarar el Formulario 29}
#'
#' @source \url{https://www.sii.cl/sobre_el_sii/nominapersonasjuridicas.html}
#' @examples
#'
"sii"
