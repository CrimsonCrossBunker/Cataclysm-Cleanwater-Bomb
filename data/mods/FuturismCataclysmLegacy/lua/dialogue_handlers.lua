local ccb = require("ccb")
local services = ccb.services
local H = {}

H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

H.time_since = function(point_turns, unit_div)
    if point_turns == nil then return -1 end
    local diff = services.turn() - point_turns
    if unit_div and unit_div ~= 1 then return diff / unit_div end
    return diff
end

H.u = function(ctx)
    return ctx:speaker()
end

H.var_num_opt = function(actor, key)
    if not actor then return nil end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return nil end
    return r.value.value
end

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
