% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/activos_historico.R
\name{activos_historico}
\alias{activos_historico}
\title{Cuenta los sindicatos activos y los afiliados en cada mes en un periodo de años}
\usage{
activos_historico(desde = 2020, hasta = 2021)
}
\arguments{
\item{desde}{Año desde el cuál partir haciendo el conteo. 2020 por defecto}

\item{hasta}{Año hasta el cuál partir haciendo el conteo. 2021 por defecto}
}
\value{
Una tibble con el número de sindicatos y socios en cada mes del periodo
indicado
}
\description{
Cuenta los sindicatos activos y los afiliados en cada mes en un periodo de años
}
\examples{
activos_historico(desde=2020,hasta=2021)


}
