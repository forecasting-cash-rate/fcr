# a script to download the cash rate series from the RBA website
# and save in the cash_rate object

forecast_day    = "2023-09-30"        # this forecast was performed on

icr_dwnld   = readrba::read_rba(series_id = "FIRMMCRTD")   # Cash Rate Target
cash_rate   = xts::xts(icr_dwnld$value, as.Date(icr_dwnld$date))

cash_rate   = cash_rate[paste0("/",forecast_day)]
colnames(cash_rate)   = c("cash_rate")

save(cash_rate, file = "data/cash_rate.rda")
