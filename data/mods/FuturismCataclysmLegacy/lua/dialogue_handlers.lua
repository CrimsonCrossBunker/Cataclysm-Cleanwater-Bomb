local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

ccb.runtime.handler("dlg_p_futurismcataclysmlegacy_e885f8603cd2", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1209600)
end)

ccb.runtime.handler("dlg_p_futurismcataclysmlegacy_2ae6dc50d987", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 1036800)
end)

ccb.runtime.handler("dlg_p_futurismcataclysmlegacy_107ec80b5824", function(ctx)
    return (H.time_since(H.var_num_opt(H.u(ctx), "timer_hub_waiting_on_autodoc"), 1) >= 604800)
end)

ccb.runtime.handler("dlg_p_futurismcataclysmlegacy_97f048b36363", function(ctx)
    return (H.global_var_num("hub01_told_u_about_warehouse_autodoc") == 1)
end)
