local ccb = require("ccb")
local services = ccb.services
local H = {}

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
    return gid
end

H.char_has_item = function(actor, item_id)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_type(actor, gid)
    return r.ok and r.value == true
end

H.consume_item = function(actor, item_id, count, charges)
    if not actor then return end
    local gid = H.safe_id("item", item_id)
    if not gid then return end
    services.inventory.consume_by_type(actor, gid, math.floor(count or 0), math.floor(charges or 0))
end

H.npc = function(ctx)
    return ctx:interlocutor()
end

H.set_var = function(scope, actor, ctx, key, val)
    if scope == "context" then
        if val == nil then ctx:remove(key) else ctx:set(key, val) end
        return
    end
    if scope == "global" then
        if val == nil then services.variables.remove_global(key) else services.variables.set_global(key, val) end
        return
    end
    if not actor then return end
    if val == nil then services.variables.remove(actor, key) else services.variables.set(actor, key, val) end
end

H.u = function(ctx)
    return ctx:speaker()
end

H.var_num = function(actor, key)
    if not actor then return 0 end
    local r = services.variables.get_number(actor, key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

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
