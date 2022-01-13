
#' Buscar empresas o sindicatos por palabras claves
#'
#'
#'
#'
#'
#' @export
#'
#'
#' @examples
#' buscar_sindicatos(empresa_buscada="walmart",sindicato_buscado="lider")
#' buscar_sindicatos(empresa_buscada="codelco",sindicato_buscado="")
#' buscar_sindicatos(empresa_buscada="",sindicato_buscado="casa particular")

buscar_sindicatos <- function(empresa_buscada="",sindicato_buscado=""){
  empresa_buscada  <- tolower(empresa_buscada)
  sindicato_buscado <- tolower(sindicato_buscado)
  sindicatos$nombre <- tolower(sindicatos$nombre)
  sindicatos$empresa <- tolower(sindicatos$empresa)
  aux <- dplyr::filter(sindicatos,
                       stringr::str_detect(nombre, sindicato_buscado)
  )
  aux <- dplyr::filter(aux,
                stringr::str_detect(empresa, empresa_buscada)
  )
  #dplyr::select(aux,rsu_raf,nombre,empresa,total_socis)
  aux

}

