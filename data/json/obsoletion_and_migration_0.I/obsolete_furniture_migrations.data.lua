local ccb = require("ccb")

ccb.content.define_ter_furn_migration { from_ter = "t_atm", to_ter = "t_thconc_floor", to_furn = "f_atm_off" }
