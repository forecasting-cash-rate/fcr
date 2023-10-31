#' @title Daily cash rate target series
#'
#' @description A series of daily cash rate target from 23 January 1990 to 29 September 2023
#'
#' @usage data(cash_rate)
#'
#' @format A matrix and a \code{xts} object with time series of 8529 observations:
#' \describe{
#'   \item{cash_rate}{cash rate target}
#' }
#'
#' @source
#' RBA Table F1 INTEREST RATES AND YIELDS – MONEY MARKET \url{http://www.rba.gov.au/statistics/tables/xls/f01d.xls}
#'
#' @examples
#' data(cash_rate)   # upload the data
#' plot(cash_rate)   # plot the data
"cash_rate"
