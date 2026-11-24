local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

ccb.runtime.handler("dlg_p_magiclysm_5418beee4326", function(ctx)
    return (H.var_num(H.u(ctx), "num_perks") > 0)
end)

ccb.runtime.handler("dlg_p_magiclysm_941728746d69", function(ctx)
    return (not (services.gameplay.mods.is_loaded("innawood")))
end)

ccb.runtime.handler("dlg_p_magiclysm_7c2159134cc6", function(ctx)
    return services.gameplay.mods.is_loaded("innawood")
end)

ccb.runtime.handler("dlg_p_magiclysm_280f5b89c85b", function(ctx)
    return (H.char_has_item(H.u(ctx), "denarius") and (not (services.gameplay.mods.is_loaded("innawood"))))
end)

ccb.runtime.handler("dlg_p_magiclysm_627fa3dba5e2", function(ctx)
    return (H.char_has_item(H.u(ctx), "denarius") and services.gameplay.mods.is_loaded("innawood"))
end)

ccb.runtime.handler("dlg_a_magiclysm_35c28be1f42d", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "num_perks", (H.var_num(H.u(ctx), "num_perks")) - 1)
end)

ccb.runtime.handler("dlg_a_magiclysm_0a74c5591bcc", function(ctx)
    ctx:set_conditional("perk_condition", (0 == 0))
end)

ccb.runtime.handler("dlg_a_magiclysm_cad85f26d6fa", function(ctx)
    H.consume_item(H.u(ctx), "denarius", 1, 0)
end)

ccb.runtime.handler("dlg_a_magiclysm_b142e0f93d05", function(ctx)
    if services.random.native_probability(1, (2)) then
        local _n1, _u2 = H.npc(ctx), H.u(ctx)
        local _mg3 = H.safe_id("mission", "MISSION_FORGE_DIVINER_TOWER1")
        if _n1 and _u2 and _mg3 then services.npcs.missions.assign(_n1, _u2, _mg3) end
    else
        local _n4, _u5 = H.npc(ctx), H.u(ctx)
        local _mg6 = H.safe_id("mission", "MISSION_FORGE_DIVINER_TOWER2")
        if _n4 and _u5 and _mg6 then services.npcs.missions.assign(_n4, _u5, _mg6) end
    end
    H.consume_item(H.u(ctx), "denarius", 1, 0)
end)
