
## datos de https://tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx
sindicatos <- janitor::clean_names(readxl::read_excel("data-raw/archivo_sindicatos_20220116.xlsx"))

## Cargar paquetes
library(readxl)
library(tidyverse)
library(lubridate)

## Función para extraer solo números (ignorando dígito verificador)
library(stringr)
numextract <- function(string){
  str_extract(string, "\\-*\\d+\\.*\\d*")
}

## Se crea variable RUT empresa
sindicatos$empresa[1:5]
numextract(sindicatos$empresa[1:5])
sindicatos$rut<-numextract(sindicatos$empresa)

## ¿Existen Casos duplicados? -> solo 22, se deja el caso que tenga rut de empresa
duplicados<-sindicatos$rsu_raf[duplicated(sindicatos$rsu_raf)]
duplicados<-sindicatos %>% filter(rsu_raf%in%duplicados)
sindicatos<-sindicatos %>% arrange(rut)
sindicatos<-sindicatos[!duplicated(sindicatos$rsu_raf), ]

## Se crea variable actividad económica -> Códigos de Actividad Económica -> http://www.cmfchile.cl/institucional/seil/certificacion_cir1835_act_eco.php

sindicatos$column1[1:5]
numextract(sindicatos$column1[1:5])
sindicatos$cae<-numextract(sindicatos$column1)
## Solamente 4130 casos de 38279 tienen actividad económica
sindicatos %>% filter(!is.na(cae)&cae>0) %>% tally()

table(sindicatos$cae)

sindicatos %>% filter(glosa=="ACTIVO") %>% count()

## Formato fecha

sindicatos<-sindicatos %>% mutate(fecha_constitucion=ymd(fecha_constitucion),
                      fecha_deposito_estatutos=ymd(fecha_deposito_estatutos),
                      fecha_ultima_directiva=ymd_hms(fecha_ultima_directiva))

sindicatos <- sindicatos %>% rename(estado=glosa,
                                    tipo=glosa1,
                                    rut_empresa=rut) %>%
  select(-fono,-email,-column1,-fecha_deposito_estatutos) %>%
  mutate(total_socis=socios+socias)


# fecha última directiva no puede ser menor a la de constitución

sindicatos <- sindicatos %>% filter(!is.na(fecha_constitucion))

sindicatos <- sindicatos %>% dplyr::mutate(fecha_ultima_directiva=
                                             dplyr::if_else(fecha_constitucion > fecha_ultima_directiva, NA_character_,
                                                            as.character(fecha_ultima_directiva)),
                                           fecha_ultima_directiva=substr(fecha_ultima_directiva,1,10),
                                           fecha_ultima_directiva=lubridate::ymd(fecha_ultima_directiva))

table((sindicatos$fecha_constitucion>sindicatos$fecha_ultima_directiva))

# exportar
#usethis::use_data(sindicatos, internal = TRUE, overwrite = TRUE)





#### sii ####

load(file="data-raw/sii.Rdata")
sii$rut_empresa <- sii$rut
sii$rut <- NULL
sii$rut_empresa <- as.character(sii$rut_empresa)
sii$nt_sii <- as.numeric(sii$nt_sii)
sii <- dplyr::mutate(sii,nt_sii=dplyr::if_else(nt_sii==0,NA_real_,nt_sii))


#usethis::use_data(sindicatos,sii, internal = TRUE, overwrite = TRUE)



#### exportar

#save(sindicatos,file="data/sindicatos.Rdata")
#save(sii,file="data/sii.Rdata")

usethis::use_data(sindicatos,sii,overwrite = TRUE)




#### data ene ####

categoria_ocupacion<-janitor::clean_names(openxlsx::read.xlsx("https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/cuadros-estadisticos/series-de-tiempo-nueva-calibraci%C3%B3n-proyecciones-de-poblaci%C3%B3n-censo-2017/categoria.xlsx?sfvrsn=70dc54db_70",sheet = 2,startRow = 6) )
nombres<-names(categoria_ocupacion)
nombres<-nombres[c(1,2,4-1,6-1,8-1,10-1,12-1,14-1,16-1,18-1,20-1,22-1,24-1,26-1)]
categoria_ocupacion<-openxlsx::read.xlsx("https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/cuadros-estadisticos/series-de-tiempo-nueva-calibraci%C3%B3n-proyecciones-de-poblaci%C3%B3n-censo-2017/categoria.xlsx?sfvrsn=70dc54db_70",sheet = 2,startRow = 7)
categoria_ocupacion<-categoria_ocupacion[1:(nrow(categoria_ocupacion)-9),c(1,2,4,6,8,10,12,14,16,18,20,22,24,26)]
names(categoria_ocupacion)<-nombres

categoria_ocupacion<-categoria_ocupacion %>% dplyr::filter(trimestre=="Oct - Dic")

ene<-categoria_ocupacion %>%

  dplyr::mutate(ft_ocupada1=poblacion_ocupada_total*1000,

         ft_ocupada2=(poblacion_ocupada_total-independientes_empleadores_as-
                        independientes_familiares_no_remunerados-asalariados_as_sector_publico_5)*1000,

         ft_ocupada3=(asalariados_as_sector_privado+ personal_de_servicio_domestico_total_6)*1000) %>%

  dplyr::select(ano, ft_ocupada1, ft_ocupada2 ,ft_ocupada3)


usethis::use_data(sindicatos,sii, ene , internal = TRUE, overwrite = TRUE)


