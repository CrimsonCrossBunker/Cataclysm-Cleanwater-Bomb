local ccb = require("ccb")
local services = ccb.services
local H = {}

H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok or not gid or not gid:is_valid() then return nil end
    return gid
end

H.mutate_towards = function(actor, trait_id, cat_id, use_vitamins)
    if not actor then return end
    local tgid = H.safe_id("mutation", trait_id)
    if not tgid then return end
    local cgid = nil
    if cat_id and cat_id ~= "" and cat_id ~= "ANY" then
        cgid = H.safe_id("mutation_category", cat_id)
    end
    services.mutations.mutate_towards(actor, tgid, cgid, use_vitamins == true)
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

H.var_str = function(scope, actor, ctx, key, default_val)
    if scope == "context" then
        local v = ctx:get_string(key)
        if v ~= nil and v ~= "" then return v end
        local gv = ctx:get(key)
        if gv ~= nil then return tostring(gv) end
        return default_val or ""
    end
    if scope == "global" then
        local r = services.variables.get_global_string(key)
        if r.ok and r.value and r.value.exists and r.value.value ~= nil then return r.value.value end
        return default_val or ""
    end
    if not actor then return default_val or "" end
    local r = services.variables.get_string(actor, key)
    if r.ok and r.value and r.value.exists and r.value.value ~= nil then return r.value.value end
    return default_val or ""
end

ccb.runtime.handler("dlg_p_perk_melee_dd59e3b64789", function(ctx)
    return ((ctx:evaluate_conditional("perk_condition") == true) and (H.var_num(H.u(ctx), "num_ma_perks") > 0))
end)

ccb.runtime.handler("dlg_a_perk_melee_8ccd5f544ce6", function(ctx)
    ctx:set_conditional("perk_condition", (0 == 0))
end)

ccb.runtime.handler("dlg_a_perk_melee_ebb3872ec2f7", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_COMBAT_TEMPO") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_6b502c186d59", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "MELEE_PERK_COMBAT_TEMPO") == 1) and (H.char_has_trait(H.u(ctx), "MELEE_PERK_COMBAT_TEMPO_2") == 1)))
end)

ccb.runtime.handler("dlg_a_perk_melee_0fcf6c68bf37", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_MOMENTUM") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_a6b5fcca89b7", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "MELEE_PERK_MOMENTUM") == 1) and (H.char_has_trait(H.u(ctx), "MELEE_PERK_DODGE") == 1)))
end)

ccb.runtime.handler("dlg_a_perk_melee_724cde31b873", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_INSIGHT") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_f5541b229d19", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_MYSTIC_SHOT") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_0f04e630b95f", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_SIXTH_SENSE") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_3f1205ad201a", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_POISE") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_d8171d3c5ec0", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_EXECUTION") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_129bcec5a018", function(ctx)
    H.mutate_towards(H.u(ctx), H.var_str("context", nil, ctx, "trait_id", ""), "ANY", false)
    H.set_var("actor", H.u(ctx), ctx, "num_ma_perks", (H.var_num(H.u(ctx), "num_ma_perks")) - 1)
end)
