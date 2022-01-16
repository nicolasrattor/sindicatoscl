test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

# Los 5 primeros test son utilizado por Riva Quiroga en su paquete "guaguas"

test_that("sindicatos nrow matches docs", {
  expect_equal(25457, nrow(sindicatos))
})

test_that("sindicatos years don't go below 1900", {
  anio_inicio <- 1900
  min_anio <- min(lubridate::year(sindicatos$fecha_constitucion))
  expect_equal(anio_inicio, min_anio)
})

test_that("sindicato estado possible values are only five", {
  n_estado_values <- 5
  estado_values <- length(unique(sindicatos$estado))
  expect_equal(n_estado_values, estado_values)
})

test_that("sindicato tipo possible values are only five", {
  n_estado_values <- 5
  estado_values <- length(unique(sindicatos$tipo))
  expect_equal(n_estado_values, estado_values)
})

test_that("sindicatos total_socis don't go below 0", {
  min_socis <- 0
  min_total_socis <- min(sindicatos$total_socis)
  expect_equal(min_socis, min_total_socis)
})

test_that("no pueden haber sindicatos duplicados (rsu_raf)", {
  no_hay_duplicados <- 0
  n_duplicados <- length(sindicatos$rsu_raf[duplicated(sindicatos$rsu_raf)])
  expect_equal(no_hay_duplicados, n_duplicados)
})

test_that("fecha última directiva no puede ser menor a la de constitución", {
  solo_verdadero <- 1
  longitud_tabla <- length(table((sindicatos$fecha_constitucion>sindicatos$fecha_ultima_directiva)))
  expect_equal(solo_verdadero , longitud_tabla)
})

