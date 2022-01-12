
## datos de https://tramites.dirtrab.cl/VentanillaTransparencia/Transparencia/RerporteRRLLOrg.aspx
sindicatos <- janitor::clean_names(readxl::read_excel("data-raw/archivo_sindicatos_20220111.xlsx"))

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

usethis::use_data(sindicatos, internal = TRUE, overwrite = TRUE)
