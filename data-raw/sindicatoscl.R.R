
## datos de https://tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx

## Cargar paquetes
library(readxl)
library(tidyverse)
library(lubridate)
library(janitor)

## Función para extraer solo números (ignorando dígito verificador)
numextract <- function(string){
  str_extract(string, "\\-*\\d+\\.*\\d*")
}

#### 1. Cargar snapshot histórico ya publicado (base) ####

## El archivo nuevo de la DT (ver más abajo) dejó de ser un registro histórico
## completo: solo trae organizaciones activas con directiva vigente (ver NEWS.md,
## actualización 2026-07-04). Para no perder cobertura histórica (RECESO, DISUELTO,
## CADUCADO de años anteriores), se usa como base el sindicatos.rda ya publicado y
## se actualiza/agrega con la data nueva, en vez de reemplazarlo.

load("data/sindicatos.rda") # crea objeto `sindicatos` (histórico ya publicado)
sindicatos_base <- sindicatos %>%
  mutate(rsu_raf = as.integer(rsu_raf))
rm(sindicatos)

#### 2. Cargar y limpiar archivo nuevo ####

sindicatos_nuevo <- janitor::clean_names(readxl::read_excel("data-raw/archivo_sindicatos_20260704.xlsx"))

## Se crea variable RUT empresa
sindicatos_nuevo$rut <- numextract(sindicatos_nuevo$empresa)

## El archivo nuevo trae una fila por dirigente/directiva vigente (nombre_dirigente,
## glosa2=cargo, inicio_mandato, fin_mandato), por lo que un mismo rsu_raf se repite
## una vez por cada integrante de la directiva. Los datos a nivel de sindicato son
## siempre idénticos entre esas filas repetidas (verificado), así que se separan en
## dos tablas: una de sindicatos (1 fila = 1 sindicato) y una de dirigentes.

dirigentes <- sindicatos_nuevo %>%
  select(rsu_raf, nombre_dirigente, cargo = glosa2, inicio_mandato, fin_mandato) %>%
  distinct()

sindicatos_nuevo <- sindicatos_nuevo %>%
  select(region, rsu_raf, nombre, glosa, fono, glosa1, direccion, email, socios, socias,
         fecha_constitucion, column1, fecha_ultima_directiva, nombre_oficina,
         fecha_deposito_estatutos, empresa, rut) %>%
  distinct(rsu_raf, .keep_all = TRUE)

## Se crea variable actividad económica -> Códigos de Actividad Económica -> http://www.cmfchile.cl/institucional/seil/certificacion_cir1835_act_eco.php
sindicatos_nuevo$cae <- numextract(sindicatos_nuevo$column1)

## Formato fecha
sindicatos_nuevo <- sindicatos_nuevo %>%
  mutate(fecha_constitucion = ymd(fecha_constitucion),
         fecha_deposito_estatutos = ymd(fecha_deposito_estatutos),
         fecha_ultima_directiva = ymd_hms(fecha_ultima_directiva))

sindicatos_nuevo <- sindicatos_nuevo %>%
  rename(estado = glosa,
         tipo = glosa1,
         rut_empresa = rut) %>%
  select(-fono, -email, -column1, -fecha_deposito_estatutos) %>%
  mutate(total_socis = socios + socias)

# fecha última directiva no puede ser menor a la de constitución
sindicatos_nuevo <- sindicatos_nuevo %>% filter(!is.na(fecha_constitucion))

sindicatos_nuevo <- sindicatos_nuevo %>%
  dplyr::mutate(fecha_ultima_directiva =
                  dplyr::if_else(fecha_constitucion > fecha_ultima_directiva, NA_character_,
                                  as.character(fecha_ultima_directiva)),
                fecha_ultima_directiva = substr(fecha_ultima_directiva, 1, 10),
                fecha_ultima_directiva = lubridate::ymd(fecha_ultima_directiva))

## Quitar sindicatos con fecha de constitución antes de 1920
antes1920 <- sindicatos_nuevo %>% filter(fecha_constitucion < ymd("1920-01-01"))
sindicatos_nuevo <- sindicatos_nuevo %>% filter(fecha_constitucion >= ymd("1920-01-01"))

sindicatos_nuevo <- sindicatos_nuevo %>% mutate(rsu_raf = as.integer(rsu_raf))

#### 3. Combinar base histórica con la data nueva ####

## Para los sindicatos presentes en el archivo nuevo se usa su versión actualizada
## (más reciente); los que solo están en la base histórica (recesos/disueltos/
## caducados no incluidos en el nuevo reporte) se conservan tal cual.

cols_comunes <- intersect(names(sindicatos_base), names(sindicatos_nuevo))

sindicatos_base_only <- sindicatos_base %>%
  filter(!(rsu_raf %in% sindicatos_nuevo$rsu_raf))

sindicatos <- bind_rows(
  sindicatos_base_only[, cols_comunes],
  sindicatos_nuevo[, cols_comunes]
)

## Chequeos rápidos
stopifnot(sum(duplicated(sindicatos$rsu_raf)) == 0)
stopifnot(min(lubridate::year(sindicatos$fecha_constitucion)) == 1920)
stopifnot(min(sindicatos$total_socis, na.rm = TRUE) >= 0)
stopifnot(all(is.na(sindicatos$fecha_ultima_directiva) |
                sindicatos$fecha_constitucion <= sindicatos$fecha_ultima_directiva))

#### sii ####

load(file = "data-raw/sii2.Rdata")
sii$rut_empresa <- sii$rut
sii$rut <- NULL
sii$rut_empresa <- as.character(sii$rut_empresa)
sii$nt_sii <- as.numeric(sii$nt_sii)
sii <- dplyr::mutate(sii, nt_sii = dplyr::if_else(nt_sii == 0, NA_real_, nt_sii))

#### exportar ####

usethis::use_data(sindicatos, sii, dirigentes, overwrite = TRUE)
usethis::use_data(sindicatos, sii, overwrite = TRUE, internal = TRUE)


#### data ene ####

categoria_ocupacion <- janitor::clean_names(openxlsx::read.xlsx("https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/cuadros-estadisticos/series-vigentes/categoria.xlsx?sfvrsn=70dc54db_82", sheet = 2, startRow = 6))
nombres <- names(categoria_ocupacion)
nombres <- nombres[c(1, 2, 4 - 1, 6 - 1, 8 - 1, 10 - 1, 12 - 1, 14 - 1, 16 - 1, 18 - 1, 20 - 1, 22 - 1, 24 - 1, 26 - 1)]
categoria_ocupacion <- openxlsx::read.xlsx("https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/cuadros-estadisticos/series-vigentes/categoria.xlsx?sfvrsn=70dc54db_82", sheet = 2, startRow = 7)
categoria_ocupacion <- categoria_ocupacion[1:(nrow(categoria_ocupacion) - 9), c(1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26)]
names(categoria_ocupacion) <- nombres

categoria_ocupacion <- categoria_ocupacion %>% dplyr::filter(trimestre == "Oct - Dic")

ene <- categoria_ocupacion %>%
  dplyr::mutate(ft_ocupada1 = poblacion_ocupada_total * 1000,
                ft_ocupada2 = (poblacion_ocupada_total - independientes_empleadores_as -
                                 independientes_familiares_no_remunerados - asalariados_as_sector_publico_5) * 1000,
                ft_ocupada3 = (asalariados_as_sector_privado + personal_de_servicio_domestico_total_6) * 1000) %>%
  dplyr::select(ano, ft_ocupada1, ft_ocupada2, ft_ocupada3)

usethis::use_data(sindicatos, sii, ene, internal = TRUE, overwrite = TRUE)
