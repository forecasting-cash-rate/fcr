# a script to download interest rates data from the RBA website
# and save in the interest_rates_oz object

forecast_day    = "2023-09-30"        # this forecast was performed on

icr_dwnld   = readrba::read_rba(series_id = "FIRMMCRTD")   # Cash Rate Target
icr_tmp     = xts::xts(icr_dwnld$value, icr_dwnld$date)
dates_tmp   = xts::xts(as.Date(icr_dwnld$date), icr_dwnld$date)

by1m_dwnld = readrba::read_rba(series_id = "FIRMMBAB30D")
by1m_tmp   = xts::xts(by1m_dwnld$value, by1m_dwnld$date)

by3m_dwnld = readrba::read_rba(series_id = "FIRMMBAB90D")
by3m_tmp   = xts::xts(by3m_dwnld$value, by3m_dwnld$date)

by6m_dwnld = readrba::read_rba(series_id = "FIRMMBAB180D")
by6m_tmp   = xts::xts(by6m_dwnld$value, by6m_dwnld$date)

by2y_dwnld = readrba::read_rba(series_id = "FCMYGBAG2D")
by2y_tmp   = xts::xts(by2y_dwnld$value, by2y_dwnld$date)

by3y_dwnld = readrba::read_rba(series_id = "FCMYGBAG3D")
by3y_tmp   = xts::xts(by3y_dwnld$value, by3y_dwnld$date)

by5y_dwnld = readrba::read_rba(series_id = "FCMYGBAG5D")
by5y_tmp   = xts::xts(by5y_dwnld$value, by5y_dwnld$date)

by10y_dwnld = readrba::read_rba(series_id = "FCMYGBAG10D")
by10y_tmp   = xts::xts(by10y_dwnld$value, by10y_dwnld$date)


long_ou_tmp = na.omit(merge(by2y_tmp, by3y_tmp, by5y_tmp, by10y_tmp))
long_be     = long_ou_tmp["/2013-05-16"]
long_af     = long_ou_tmp["2022-01-01/"]

long_in_tmp = readxl::read_xls(path = "f02d.xls", skip = 10)
long_in     = xts::xts(long_in_tmp[,2:5], as.Date(long_in_tmp$`Series ID`))
long_in     = long_in["2013-05-17/2021-12-31"]
colnames(long_in) <- colnames(long_af)

short       = na.omit(merge(icr_tmp, by1m_tmp, by3m_tmp, by6m_tmp))
long        = rbind(long_be, long_in, long_af)

###############################################################
# construct a matrix (xts) of daily interest rates data
###############################################################
variables_all             = na.omit(merge(short, long))
colnames(variables_all)   = c("cash rate", "1m", "3m", "6m", "2y", "3y", "5y", "10y")
interest_rates_oz         = variables_all[paste0("/",forecast_day)]
colnames(interest_rates_oz)   = c("cash_rate", "by1m", "by3m", "by6m", "by2y", "by3y", "by5y", "by10y")

save(interest_rates_oz, file = "data/interest_rates_oz.rda")
