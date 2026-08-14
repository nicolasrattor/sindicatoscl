# sindicatoscl 0.4.0

* Datos de sindicatos actualizados con el archivo de la Dirección del Trabajo al
  4 de julio de 2026 (`archivo_sindicatos_20260704.xlsx`).

* Cambio importante: desde esta descarga, la DT dejó de publicar el registro
  histórico completo y pasó a publicar solo organizaciones activas con directiva
  vigente. Para no perder cobertura histórica, `sindicatos` ahora combina ese
  archivo con el snapshot anterior (0.3.0): las organizaciones presentes en el
  archivo nuevo quedan con su información más reciente; las que solo estaban en
  el snapshot anterior (recesos, disueltos y caducados de años previos, ~30.465
  organizaciones) se mantienen sin cambios.

* `tipo` pasa de 5 a 11 categorías: se agregan ASOCIACION DE FUNCIONARIOS,
  FEDERACION DE SINDICATOS, FEDERACION DE ASOCIACIONES, CONFEDERACION DE
  SINDICATOS, CONFEDERACION DE ASOCIACIONES y CENTRAL DE TRABAJADORES. Funciones
  que no filtran por `tipo` (p.ej. `activos_en()`, `activos_historico()`) ahora
  incluyen estas categorías en sus conteos; `afiliados_tipo()`/
  `tasa_sindicalizacion()` siguen acotadas a los 5 tipos originales porque los
  nombran explícitamente.

* Nuevo dataset `dirigentes`: directiva vigente (nombre, cargo, inicio y fin de
  mandato) de cada organización presente en la descarga de 2026-07-04. Sin
  cobertura histórica ni funciones asociadas todavía.

# sindicatoscl 0.3.0

* Datos de sindicatos actualizados al 27 de junio de 2022

* Datos de sindicatos actualizados al 16 de enero de 2022
