local ccb = require("ccb")
local services = ccb.services
local H = {}

H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

H.npc = function(ctx)
    return ctx:interlocutor()
end

H.npc_snap = function(npc)
    if not npc then return nil end
    local r = services.npcs.get(npc)
    if not r.ok then return nil end
    return r.value
end

H.npc_faction_trust = function(npc)
    local s = H.npc_snap(npc)
    if not s or not s.faction then return 0 end
    local r = services.factions.get(s.faction)
    if not r.ok or not r.value or not r.value.reputation then return 0 end
    return r.value.reputation.trusts or 0
end

H.npc_opinion = function(npc, field)
    local s = H.npc_snap(npc)
    if not s or not s.opinion then return 0 end
    return s.opinion[field] or 0
end

H.u = function(ctx)
    return ctx:speaker()
end

ccb.runtime.handler("dlg_p_translate_dialogue_4a7841f056c7", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 28)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_be44d4d6304e", function(ctx)
    return (H.global_var_num("talked_to_hub") == 1)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_0c73fc5311f1", function(ctx)
    return (H.global_var_num("exodii_knows_hub01") == 1)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_3b4f437cadf3", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "sold") >= 100)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_eecffe980cd4", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (5))
end)
